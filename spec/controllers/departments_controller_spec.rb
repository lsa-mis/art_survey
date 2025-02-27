require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
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

  let(:valid_attributes) {
    { fullname: "Computer Science", shortname: "CS", deptID: 12345, updated_by: super_user.id }
  }

  let(:invalid_attributes) {
    { fullname: "", shortname: "", deptID: nil, updated_by: nil }
  }

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
        create(:department)
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        department = create(:department)
        get :show, params: { id: department.to_param }
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        department = create(:department)
        get :edit, params: { id: department.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Department" do
          expect {
            post :create, params: { department: valid_attributes }
          }.to change(Department, :count).by(1)
        end

        it "redirects to the created department" do
          post :create, params: { department: valid_attributes }
          expect(response).to redirect_to(Department.last)
        end
      end

      context "with invalid params" do
        it "returns an appropriate response for invalid parameters" do
          post :create, params: { department: invalid_attributes }
          expect(response.status).to be_in([200, 422])
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { fullname: "Mathematics", shortname: "MATH" }
        }

        it "updates the requested department" do
          department = create(:department)
          put :update, params: { id: department.to_param, department: new_attributes }
          department.reload
          expect(department.fullname).to eq("Mathematics")
          expect(department.shortname).to eq("MATH")
        end

        it "redirects to the department" do
          department = create(:department)
          put :update, params: { id: department.to_param, department: valid_attributes }
          expect(response).to redirect_to(department)
        end
      end

      context "with invalid params" do
        it "returns an appropriate response for invalid parameters" do
          department = create(:department)
          put :update, params: { id: department.to_param, department: invalid_attributes }
          expect(response.status).to be_in([200, 422])
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested department" do
        department = create(:department)
        expect {
          delete :destroy, params: { id: department.to_param }
        }.to change(Department, :count).by(-1)
      end

      it "redirects to the departments list" do
        department = create(:department)
        delete :destroy, params: { id: department.to_param }
        expect(response).to redirect_to(departments_url)
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
      it "redirects to the root path" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #show" do
      it "redirects to the root path" do
        department = create(:department)
        get :show, params: { id: department.to_param }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #new" do
      it "redirects to the root path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #edit" do
      it "redirects to the root path" do
        department = create(:department)
        get :edit, params: { id: department.to_param }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST #create" do
      it "redirects to the root path" do
        post :create, params: { department: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT #update" do
      it "redirects to the root path" do
        department = create(:department)
        put :update, params: { id: department.to_param, department: { fullname: "Updated Department" } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the root path" do
        department = create(:department)
        delete :destroy, params: { id: department.to_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
