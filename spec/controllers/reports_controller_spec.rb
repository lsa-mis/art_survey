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

  describe 'CSV content for department selection' do
    before do
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
      allow(controller).to receive(:current_user_department_objects).and_return([department1, department2])
      allow(controller).to receive(:current_user_departments).and_return([department1.id, department2.id])
    end

    it 'includes all art_items when All Departments is selected' do
      get :art_items, format: :csv
      csv = CSV.parse(response.body, headers: true)
      expect(csv.count).to eq(2)
      depts = csv.map { |row| row['Department'] }
      expect(depts).to include('Painting', 'Sculpture')
    end

    it 'includes only selected department art_items when a department is selected' do
      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)
      expect(csv.count).to eq(1)
      expect(csv[0]['Department']).to eq('Painting')
      expect(csv[0]['Department']).not_to eq('Sculpture')
    end
  end

  describe 'CSV formula neutralization' do
    before do
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
    end

    it 'prefixes formula-like contact, location, and rich-text fields' do
      item = create(
        :art_item,
        department: department1,
        department_contact: '=HYPERLINK("http://evil.example")',
        location_building: '+Building',
        location_room: '-101',
        value_cost: 1500,
        date_acquired: '2022-01-01',
        appraisal_type: appraisal_type
      )
      # Factory after(:build) sets rich text; override after create for formula cases.
      item.update!(
        description: '=1+1',
        protection: '@SUM(A1)',
        appraisal_description: '+cmd'
      )

      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)
      row = csv.find { |r| r['Department Contact']&.start_with?("'=") }

      expect(row['Department Contact']).to eq("'=HYPERLINK(\"http://evil.example\")")
      expect(row['Description']).to eq("'=1+1")
      expect(row['Location Building']).to eq("'+Building")
      expect(row['Location Room']).to eq("'-101")
      expect(row['Protection']).to eq("'@SUM(A1)")
      expect(row['Appraisal Description']).to eq("'+cmd")
    end

    it 'leaves ordinary text values unchanged' do
      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)

      expect(csv[0]['Department Contact']).to eq('Alice')
      expect(csv[0]['Location Building']).to eq('A')
      expect(csv[0]['Location Room']).to eq('101')
      expect(csv[0]['Description']).not_to start_with("'")
    end

    it 'prefixes rich-text fields that start with a newline before a formula' do
      item = create(
        :art_item,
        department: department1,
        value_cost: 1500,
        date_acquired: '2022-01-01',
        appraisal_type: appraisal_type
      )
      # Blank Trix lines become \n in to_plain_text, which the formula check must treat
      # as a prefix so spreadsheet apps cannot strip the newline and execute the formula.
      item.update!(
        description: '<div><br></div><div>=1+1</div>',
        protection: '<div><br></div><div>@SUM(A1)</div>',
        appraisal_description: '<div><br></div><div>+cmd</div>'
      )

      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)
      row = csv.find { |r| r['Description']&.start_with?("'\n=") }

      expect(item.description.body.to_plain_text).to eq("\n=1+1")
      expect(row['Description']).to eq("'\n=1+1")
      expect(row['Protection']).to eq("'\n@SUM(A1)")
      expect(row['Appraisal Description']).to eq("'\n+cmd")
    end

    it 'prefixes formulas after leading whitespace or control characters that spreadsheets strip' do
      item = create(
        :art_item,
        department: department1,
        department_contact: " =HYPERLINK(\"http://evil.example\")",
        location_building: "\u00A0+Building",
        location_room: "\uFEFF-101",
        value_cost: 1500,
        date_acquired: '2022-01-01',
        appraisal_type: appraisal_type
      )
      # ActionText may normalize some C0 controls; leading space/NBSP still reach export
      # and must not bypass neutralization when followed by a formula trigger.
      item.update!(
        description: " =1+1",
        protection: "\u00A0@SUM(A1)",
        appraisal_description: "\v\f+cmd"
      )

      get :art_items, params: { department_id: department1.id }, format: :csv
      csv = CSV.parse(response.body, headers: true)
      row = csv.find { |r| r['Department Contact']&.start_with?("' ") }

      expect(row['Department Contact']).to eq("' =HYPERLINK(\"http://evil.example\")")
      expect(row['Location Building']).to eq("'\u00A0+Building")
      expect(row['Location Room']).to eq("'\uFEFF-101")
      expect(row['Description']).to start_with("'")
      expect(row['Description']).to end_with('=1+1')
      expect(row['Protection']).to start_with("'")
      expect(row['Protection']).to end_with('@SUM(A1)')
      expect(row['Appraisal Description']).to start_with("'")
      expect(row['Appraisal Description']).to end_with('+cmd')
    end

    it 'neutralizes formula triggers after ignorable prefixes in csv_safe_cell' do
      [
        " =1+1",
        "\u00A0+cmd",
        "\uFEFF@SUM(A1)",
        "\v=HYPERLINK(\"http://evil.example\")",
        "\f-1+1",
        "\t\r\n =WEBSERVICE(\"http://evil.example\")"
      ].each do |payload|
        expect(controller.send(:csv_safe_cell, payload)).to eq("'#{payload}")
      end

      expect(controller.send(:csv_safe_cell, ' ordinary')).to eq(' ordinary')
      expect(controller.send(:csv_safe_cell, "\u00A0safe")).to eq("\u00A0safe")
    end
  end
end
