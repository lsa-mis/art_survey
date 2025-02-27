require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # Setup test data
  let(:super_user_role) { create(:role, title: "SuperUser") }
  let(:dept_admin_role) { create(:role, title: "DeptAdmin") }
  let(:department) { create(:department) }
  let(:super_user_permission) { create(:permission, role: super_user_role) }
  let(:dept_admin_permission) { create(:permission, role: dept_admin_role, department: department) }
  let(:super_user) { create(:user) }
  let(:dept_admin) { create(:user) }
  let!(:super_user_access) { create(:access, uniqname: super_user.uniqname, permission: super_user_permission, updated_by: 1) }
  let!(:dept_admin_access) { create(:access, uniqname: dept_admin.uniqname, permission: dept_admin_permission, updated_by: 1) }

  describe "for authenticated super user" do
    before do
      # Skip Devise authentication
      allow(controller).to receive(:authenticate_user!).and_return(true)
      # Set the session
      session[:user_uniqname] = super_user.uniqname
      # Stub the authorization methods
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:access_authorized!).and_return(true)
      allow(controller).to receive(:super_user_access_authorized!).and_return(true)
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        user = create(:user)
        get :show, params: { id: user.to_param }
        expect(response).to be_successful
      end
    end
  end

  describe "for authenticated department admin user" do
    before do
      # Skip Devise authentication
      allow(controller).to receive(:authenticate_user!).and_return(true)
      # Set the session
      session[:user_uniqname] = dept_admin.uniqname
      # Stub the authorization methods
      allow(controller).to receive(:is_super_user!).and_return(false)
      allow(controller).to receive(:is_department_admin_user!).and_return(true)
      allow(controller).to receive(:access_authorized!).and_return(true)

      # Properly simulate the super_user_access_authorized! method behavior
      allow(controller).to receive(:super_user_access_authorized!).and_wrap_original do |original, *args|
        controller.send(:redirect_to, root_path)
        controller.flash[:alert] = "Not Authorized."
        false
      end
    end

    describe "GET #index" do
      it "redirects to root path" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #show" do
      it "redirects to root path for other users" do
        other_user = create(:user)
        get :show, params: { id: other_user.to_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
