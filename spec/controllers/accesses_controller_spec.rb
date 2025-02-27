require 'rails_helper'

RSpec.describe AccessesController, type: :controller do
  # Setup test data
  let(:super_user_role) { create(:role, title: "SuperUser") }
  let(:dept_admin_role) { create(:role, title: "DeptAdmin") }
  let(:department) { create(:department) }
  let(:other_department) { create(:department) }
  let(:super_user_permission) { create(:permission, role: super_user_role) }
  let(:dept_admin_permission) { create(:permission, role: dept_admin_role, department: department) }
  let(:super_user) { create(:user) }
  let(:dept_admin) { create(:user) }
  let!(:super_user_access) { create(:access, uniqname: super_user.uniqname, permission: super_user_permission, updated_by: 1) }
  let!(:dept_admin_access) { create(:access, uniqname: dept_admin.uniqname, permission: dept_admin_permission, updated_by: 1) }

  let(:valid_attributes) {
    {
      uniqname: "test_user",
      permission_id: super_user_permission.id,
      updated_by: super_user.id
    }
  }

  let(:invalid_attributes) {
    {
      uniqname: "",
      permission_id: nil,
      updated_by: nil
    }
  }

  describe "for authenticated super user" do
    before do
      # Skip Devise authentication
      allow(controller).to receive(:authenticate_user!).and_return(true)
      # Set the session
      session[:user_uniqname] = super_user.uniqname
      # Stub the authorization methods
      allow(controller).to receive(:is_super_user!).and_return(true)
      allow(controller).to receive(:is_department_admin_user!).and_return(false)
      allow(controller).to receive(:access_authorized!).and_return(true)
      allow(controller).to receive(:current_user_departments).and_return([department.id])
      allow(controller).to receive(:super_user_access_authorized!).and_return(true)
      allow(controller).to receive(:super_user_department_admin_access_authorized!).and_return(true)
      allow(controller).to receive(:current_user_associated_department_permissions).and_return([super_user_permission])
      allow(controller).to receive(:get_accesses_collection).and_return(Access.all)
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        access = Access.create! valid_attributes
        get :show, params: {id: access.to_param}
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
        access = Access.create! valid_attributes
        get :edit, params: {id: access.to_param}
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Access" do
          expect {
            post :create, params: {access: valid_attributes}
          }.to change(Access, :count).by(1)
        end

        it "redirects to the created access" do
          post :create, params: {access: valid_attributes}
          expect(response).to redirect_to(Access.last)
        end
      end

      context "with invalid params" do
        it "returns an appropriate response for invalid parameters" do
          post :create, params: {access: invalid_attributes}
          expect(response.status).to be_in([302, 422])
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            uniqname: "updated_user"
          }
        }

        it "updates the requested access" do
          access = Access.create! valid_attributes
          put :update, params: {id: access.to_param, access: new_attributes}
          access.reload
          expect(access.uniqname).to eq("updated_user")
        end

        it "redirects to the access" do
          access = Access.create! valid_attributes
          put :update, params: {id: access.to_param, access: new_attributes}
          expect(response).to redirect_to(access)
        end
      end

      context "with invalid params" do
        it "returns an appropriate response for invalid parameters" do
          access = Access.create! valid_attributes
          put :update, params: {id: access.to_param, access: invalid_attributes}
          expect(response.status).to be_in([302, 422])
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested access" do
        access = Access.create! valid_attributes
        expect {
          delete :destroy, params: {id: access.to_param}
        }.to change(Access, :count).by(-1)
      end

      it "redirects to the accesses list" do
        access = Access.create! valid_attributes
        delete :destroy, params: {id: access.to_param}
        expect(response).to redirect_to(accesses_url)
      end
    end
  end

  describe "for authenticated department admin user" do
    let(:dept_access) { create(:access, uniqname: "dept_user", permission: dept_admin_permission, updated_by: 1) }

    before do
      # Skip Devise authentication
      allow(controller).to receive(:authenticate_user!).and_return(true)
      # Set the session
      session[:user_uniqname] = dept_admin.uniqname
      # Stub the authorization methods
      allow(controller).to receive(:is_super_user!).and_return(false)
      allow(controller).to receive(:is_department_admin_user!).and_return(true)
      allow(controller).to receive(:access_authorized!).and_return(true)
      allow(controller).to receive(:current_user_departments).and_return([department.id])
      allow(controller).to receive(:super_user_access_authorized!).and_return(false)
      allow(controller).to receive(:super_user_department_admin_access_authorized!).and_return(true)
      allow(controller).to receive(:current_user_associated_department_permissions).and_return([dept_admin_permission])
      allow(controller).to receive(:get_accesses_collection).and_return([dept_access])
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {id: dept_access.to_param}
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
        get :edit, params: {id: dept_access.to_param}
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      let(:dept_valid_attributes) {
        {
          uniqname: "new_dept_user",
          permission_id: dept_admin_permission.id,
          updated_by: dept_admin.id
        }
      }

      it "creates a new Access" do
        expect {
          post :create, params: {access: dept_valid_attributes}
        }.to change(Access, :count).by(1)
      end

      it "redirects to the created access" do
        post :create, params: {access: dept_valid_attributes}
        expect(response).to redirect_to(Access.last)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
        {
          uniqname: "updated_dept_user"
        }
      }

      it "updates the requested access" do
        put :update, params: {id: dept_access.to_param, access: new_attributes}
        dept_access.reload
        expect(dept_access.uniqname).to eq("updated_dept_user")
      end

      it "redirects to the access" do
        put :update, params: {id: dept_access.to_param, access: new_attributes}
        expect(response).to redirect_to(dept_access)
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested access" do
        dept_access # ensure it's created
        expect {
          delete :destroy, params: {id: dept_access.to_param}
        }.to change(Access, :count).by(-1)
      end

      it "redirects to the accesses list" do
        delete :destroy, params: {id: dept_access.to_param}
        expect(response).to redirect_to(accesses_url)
      end
    end
  end
end
