require 'rails_helper'
require 'csv'

RSpec.describe ReportsController, type: :controller do
  let!(:super_user_role) { create(:role, title: 'SuperUser') }
  let!(:dept_admin_role) { create(:role, title: 'Department Administrator') }
  let!(:department1) { create(:department, fullname: 'Painting') }
  let!(:department2) { create(:department, fullname: 'Sculpture') }
  let!(:appraisal_type) { create(:appraisal_type, classification: 'Standard') }
  let!(:art_item1) do
    create(:art_item, department: department1, department_contact: 'Alice', description: 'Desc1', location_building: 'A', location_room: '101', value_cost: 1000, date_acquired: '2020-01-01', appraisal_type: appraisal_type, protection: 'Prot1', appraisal_description: 'AppDesc1')
  end
  let!(:art_item2) do
    create(:art_item, department: department2, department_contact: 'Bob', description: 'Desc2', location_building: 'B', location_room: '202', value_cost: 2000, date_acquired: '2021-01-01', appraisal_type: appraisal_type, protection: 'Prot2', appraisal_description: 'AppDesc2')
  end

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user_department_objects).and_return([department1, department2])
    allow(controller).to receive(:current_user_departments).and_return([department1.id, department2.id])
  end

  describe 'GET #art_items as SuperUser' do
    before do
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
    end

    it 'returns all art_items as CSV' do
      get :art_items, format: :csv
      csv = CSV.parse(response.body, headers: true)
      expect(csv.count).to eq(2)
      expect(csv.headers).to include('Department', 'Department Contact', 'Description', 'Location Building', 'Location Room', 'Value Cost', 'Date Acquired', 'Appraisal Type', 'Protection', 'Appraisal Description', 'Image URL')
    end

    it 'filters by department' do
      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)
      expect(csv.count).to eq(1)
      expect(csv[0]['Department']).to eq('Painting')
    end
  end

  describe 'GET #art_items as Department Admin' do
    before do
      allow(controller).to receive(:is_super_user!).and_return(false)
      allow(controller).to receive(:is_department_admin_user!).and_return(true)
      allow(controller).to receive(:current_user_departments).and_return([department1.id])
      allow(controller).to receive(:current_user_department_objects).and_return([department1])
    end

    it 'returns only their department art_items as CSV' do
      get :art_items, format: :csv
      csv = CSV.parse(response.body, headers: true)
      expect(csv.count).to eq(1)
      expect(csv[0]['Department']).to eq('Painting')
    end
  end

  describe 'GET #art_items as unauthorized user' do
    before do
      allow(controller).to receive(:is_super_user!).and_return(false)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
    end

    it 'redirects to root' do
      get :art_items
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'department selection in @departments' do
    let!(:other_department) { create(:department, fullname: 'Photography') }

    it 'SuperUser sees all departments' do
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
      allow(controller).to receive(:current_user_department_objects).and_return([department1, department2, other_department])
      get :art_items
      expect(assigns(:departments)).to match_array([department1, department2, other_department])
    end

    it 'Department Admin sees only their assigned departments' do
      allow(controller).to receive(:is_super_user!).and_return(false)
      allow(controller).to receive(:is_department_admin_user!).and_return(true)
      allow(controller).to receive(:current_user_department_objects).and_return([department2])
      get :art_items
      expect(assigns(:departments)).to eq([department2])
    end
  end
end
