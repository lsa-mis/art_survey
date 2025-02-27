require 'rails_helper'

RSpec.describe AppraisalTypesController, type: :controller do
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
    { classification: "Painting", description: "Oil on canvas", updated_by: super_user.id }
  }

  # Since the model doesn't have validations, we'll use attributes that would typically be invalid
  # but will actually save successfully
  let(:empty_attributes) {
    { classification: "", description: "", updated_by: nil }
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
        create(:appraisal_type)
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        appraisal_type = create(:appraisal_type)
        get :show, params: { id: appraisal_type.to_param }
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
        appraisal_type = create(:appraisal_type)
        get :edit, params: { id: appraisal_type.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new AppraisalType" do
          expect {
            post :create, params: { appraisal_type: valid_attributes }
          }.to change(AppraisalType, :count).by(1)
        end

        it "redirects to the created appraisal_type" do
          post :create, params: { appraisal_type: valid_attributes }
          expect(response).to redirect_to(AppraisalType.last)
        end
      end

      context "with empty params" do
        it "creates a new AppraisalType with empty values" do
          expect {
            post :create, params: { appraisal_type: empty_attributes }
          }.to change(AppraisalType, :count).by(1)
        end

        it "redirects to the created appraisal_type" do
          post :create, params: { appraisal_type: empty_attributes }
          expect(response).to redirect_to(AppraisalType.last)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { classification: "Sculpture", description: "Bronze statue" }
        }

        it "updates the requested appraisal_type" do
          appraisal_type = create(:appraisal_type)
          put :update, params: { id: appraisal_type.to_param, appraisal_type: new_attributes }
          appraisal_type.reload
          expect(appraisal_type.classification).to eq("Sculpture")
          expect(appraisal_type.description).to eq("Bronze statue")
        end

        it "redirects to the appraisal_type" do
          appraisal_type = create(:appraisal_type)
          put :update, params: { id: appraisal_type.to_param, appraisal_type: valid_attributes }
          expect(response).to redirect_to(appraisal_type)
        end
      end

      context "with empty params" do
        it "updates the requested appraisal_type with empty values" do
          appraisal_type = create(:appraisal_type, classification: "Original", description: "Original desc")
          put :update, params: { id: appraisal_type.to_param, appraisal_type: empty_attributes }
          appraisal_type.reload
          expect(appraisal_type.classification).to eq("")
          expect(appraisal_type.description).to eq("")
        end

        it "redirects to the appraisal_type" do
          appraisal_type = create(:appraisal_type)
          put :update, params: { id: appraisal_type.to_param, appraisal_type: empty_attributes }
          expect(response).to redirect_to(appraisal_type)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested appraisal_type" do
        appraisal_type = create(:appraisal_type)
        expect {
          delete :destroy, params: { id: appraisal_type.to_param }
        }.to change(AppraisalType, :count).by(-1)
      end

      it "redirects to the appraisal_types list" do
        appraisal_type = create(:appraisal_type)
        delete :destroy, params: { id: appraisal_type.to_param }
        expect(response).to redirect_to(appraisal_types_url)
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
        appraisal_type = create(:appraisal_type)
        get :show, params: { id: appraisal_type.to_param }
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
        appraisal_type = create(:appraisal_type)
        get :edit, params: { id: appraisal_type.to_param }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST #create" do
      it "redirects to the root path" do
        post :create, params: { appraisal_type: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT #update" do
      it "redirects to the root path" do
        appraisal_type = create(:appraisal_type)
        put :update, params: { id: appraisal_type.to_param, appraisal_type: { classification: "Updated Type" } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the root path" do
        appraisal_type = create(:appraisal_type)
        delete :destroy, params: { id: appraisal_type.to_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
