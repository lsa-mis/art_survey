require 'rails_helper'

RSpec.describe PermissionsController, type: :controller do
  # Setup test data
  let(:super_user_role) { create(:role, title: "SuperUser") }
  let(:department) { create(:department) }
  let(:super_user_permission) { create(:permission, role: super_user_role, department: department) }
  let(:super_user) { create(:user, email: "super_user@example.com", uniqname: "super_user") }
  let!(:super_user_access) { create(:access, permission: super_user_permission, uniqname: super_user.uniqname) }

  let(:valid_attributes) {
    { role_id: create(:role).id, department_id: create(:department).id, updated_by: super_user.id }
  }

  let(:invalid_attributes) {
    { role_id: nil, department_id: nil, updated_by: nil }
  }

  describe "with authenticated super user" do
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
        create(:permission)
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        permission = create(:permission)
        get :show, params: { id: permission.to_param }
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
        permission = create(:permission)
        get :edit, params: { id: permission.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Permission" do
          expect {
            post :create, params: { permission: valid_attributes }
          }.to change(Permission, :count).by(1)
        end

        it "redirects to the created permission" do
          post :create, params: { permission: valid_attributes }
          expect(response).to redirect_to(Permission.last)
        end
      end

      context "with invalid params" do
        it "returns unprocessable_entity status" do
          post :create, params: { permission: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_role) { create(:role) }
        let(:new_department) { create(:department) }
        let(:new_attributes) {
          { role_id: new_role.id, department_id: new_department.id }
        }

        it "updates the requested permission" do
          permission = create(:permission)
          put :update, params: { id: permission.to_param, permission: new_attributes }
          permission.reload
          expect(permission.role_id).to eq(new_role.id)
          expect(permission.department_id).to eq(new_department.id)
        end

        it "redirects to the permission" do
          permission = create(:permission)
          put :update, params: { id: permission.to_param, permission: valid_attributes }
          expect(response).to redirect_to(permission)
        end
      end

      context "with invalid params" do
        it "returns unprocessable_entity status" do
          permission = create(:permission)
          put :update, params: { id: permission.to_param, permission: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested permission" do
        permission = create(:permission)
        expect {
          delete :destroy, params: { id: permission.to_param }
        }.to change(Permission, :count).by(-1)
      end

      it "redirects to the permissions list" do
        permission = create(:permission)
        delete :destroy, params: { id: permission.to_param }
        expect(response).to redirect_to(permissions_url)
      end
    end
  end

  describe "with non-super user" do
    let(:regular_user) { create(:user) }

    before do
      # Skip Devise authentication
      allow(controller).to receive(:authenticate_user!).and_return(true)
      # Set the session
      session[:user_uniqname] = regular_user.uniqname
      # Stub the authorization methods
      allow(controller).to receive(:is_super_user!).and_return(false)
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
        permission = create(:permission)
        get :show, params: { id: permission.to_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
