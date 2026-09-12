# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      head :ok
    end

    def guarded
      check_for_authorized_access
      head :ok unless performed?
    end

    def super_user_guarded
      super_user_access_authorized!
      head :ok unless performed?
    end

    def admin_guarded
      super_user_department_admin_access_authorized!
      head :ok unless performed?
    end
  end

  before do
    routes.draw do
      get 'anonymous/index' => 'anonymous#index'
      get 'anonymous/guarded' => 'anonymous#guarded'
      get 'anonymous/super_user_guarded' => 'anonymous#super_user_guarded'
      get 'anonymous/admin_guarded' => 'anonymous#admin_guarded'
    end

    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  let!(:lsa_department) { create(:department, fullname: 'LSA College', shortname: 'LSA') }
  let!(:facilities_department) { create(:department, fullname: 'Facilities', shortname: 'FCL') }
  let!(:other_department) { create(:department, fullname: 'Other Dept', shortname: 'OTH') }

  let!(:super_user_role) { create(:role, title: 'SuperUser') }
  let!(:dept_admin_role) { create(:role, title: 'Department Administrator') }
  let!(:recorder_role) { create(:role, title: 'Recorder') }

  let!(:super_user_permission) { create(:permission, role: super_user_role, department: lsa_department) }
  let!(:dept_admin_permission) { create(:permission, role: dept_admin_role, department: facilities_department) }
  let!(:recorder_permission) { create(:permission, role: recorder_role, department: facilities_department) }
  let!(:extra_recorder_permission) { create(:permission, role: recorder_role, department: other_department) }

  let!(:super_user) { create(:user, uniqname: 'super_user', email: 'super_user@example.com') }
  let!(:dept_admin) { create(:user, uniqname: 'dept_admin', email: 'dept_admin@example.com') }
  let!(:recorder) { create(:user, uniqname: 'recorder', email: 'recorder@example.com') }
  let!(:stranger) { create(:user, uniqname: 'stranger', email: 'stranger@example.com') }

  let!(:super_user_access) do
    create(:access, permission: super_user_permission, uniqname: super_user.uniqname, updated_by: 1)
  end
  let!(:dept_admin_access) do
    create(:access, permission: dept_admin_permission, uniqname: dept_admin.uniqname, updated_by: 1)
  end
  let!(:recorder_access) do
    create(:access, permission: recorder_permission, uniqname: recorder.uniqname, updated_by: 1)
  end
  let!(:dept_admin_extra_access) do
    create(:access, permission: extra_recorder_permission, uniqname: dept_admin.uniqname, updated_by: 1)
  end

  def set_session_uniqname(uniqname)
    session[:user_uniqname] = uniqname
  end

  describe '#is_user_a?' do
    it 'returns true when the session uniqname has an Access for that role' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.is_user_a?('SuperUser')).to be(true)
    end

    it 'returns false when the session uniqname lacks that role' do
      set_session_uniqname(recorder.uniqname)
      expect(controller.is_user_a?('SuperUser')).to be(false)
    end

    it 'returns nil when no Permission rows exist for the role title' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.is_user_a?('Missing Role')).to be_nil
    end
  end

  describe '#access_authorized!' do
    it 'returns true when an Access row matches the session uniqname' do
      set_session_uniqname(recorder.uniqname)
      expect(controller.access_authorized!).to be(true)
    end

    it 'returns nil when no Access row matches the session uniqname' do
      set_session_uniqname(stranger.uniqname)
      expect(controller.access_authorized!).to be_nil
    end
  end

  describe '#is_super_user! and #is_department_admin_user!' do
    it 'returns true only for users with the matching role Access' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.is_super_user!).to be(true)
      expect(controller.is_department_admin_user!).to be_nil

      set_session_uniqname(dept_admin.uniqname)
      expect(controller.is_super_user!).to be_nil
      expect(controller.is_department_admin_user!).to be(true)
    end
  end

  describe '#current_user_departments' do
    it 'returns every department id for SuperUsers' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.current_user_departments).to eq(
        Department.order(:fullname).pluck(:id)
      )
    end

    it 'unions Department Administrator departments with other Access permissions' do
      set_session_uniqname(dept_admin.uniqname)
      expect(controller.current_user_departments).to contain_exactly(
        facilities_department.id,
        other_department.id
      )
    end

    it 'returns only granted departments for Recorders' do
      set_session_uniqname(recorder.uniqname)
      expect(controller.current_user_departments).to eq([facilities_department.id])
    end
  end

  describe '#current_user_department_objects' do
    it 'returns ordered department records matching #current_user_departments' do
      set_session_uniqname(dept_admin.uniqname)
      objects = controller.current_user_department_objects
      expect(objects.map(&:id)).to eq(
        Department.where(id: [facilities_department.id, other_department.id]).order(:fullname).pluck(:id)
      )
      expect(objects).to all(be_a(Department))
    end
  end

  describe '#current_user_permissions' do
    it 'returns all permissions for SuperUsers' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.current_user_permissions.pluck(:id)).to match_array(Permission.pluck(:id))
    end

    it 'returns only Department Administrator permissions for dept admins' do
      set_session_uniqname(dept_admin.uniqname)
      expect(controller.current_user_permissions.pluck(:id)).to eq([dept_admin_permission.id])
    end

    it 'returns only Access-linked permissions for Recorders' do
      set_session_uniqname(recorder.uniqname)
      expect(controller.current_user_permissions.pluck(:id)).to eq([recorder_permission.id])
    end
  end

  describe '#get_accesses_collection' do
    it 'returns all Access rows for SuperUsers' do
      set_session_uniqname(super_user.uniqname)
      expect(controller.get_accesses_collection.pluck(:id)).to match_array(Access.pluck(:id))
    end

    it 'returns only the current user Access rows for Recorders' do
      set_session_uniqname(recorder.uniqname)
      expect(controller.get_accesses_collection.pluck(:id)).to eq([recorder_access.id])
    end
  end

  describe '#check_for_authorized_access' do
    it 'allows Access holders through' do
      set_session_uniqname(recorder.uniqname)
      get :guarded
      expect(response).to have_http_status(:ok)
    end

    it 'redirects unauthorized users to root with a flash alert' do
      set_session_uniqname(stranger.uniqname)
      get :guarded
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Not Authorized.')
    end
  end

  describe '#super_user_access_authorized!' do
    it 'allows SuperUsers through' do
      set_session_uniqname(super_user.uniqname)
      get :super_user_guarded
      expect(response).to have_http_status(:ok)
    end

    it 'redirects non-SuperUsers' do
      set_session_uniqname(dept_admin.uniqname)
      get :super_user_guarded
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Not Authorized.')
    end
  end

  describe '#super_user_department_admin_access_authorized!' do
    it 'allows Department Administrators through' do
      set_session_uniqname(dept_admin.uniqname)
      get :admin_guarded
      expect(response).to have_http_status(:ok)
    end

    it 'redirects Recorders' do
      set_session_uniqname(recorder.uniqname)
      get :admin_guarded
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Not Authorized.')
    end
  end
end
