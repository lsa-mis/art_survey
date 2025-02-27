require 'rails_helper'

RSpec.describe AnnotationsController, type: :controller do
  # Setup for tests
  let(:user) { create(:user) }
  let(:art_item) { create(:art_item) }
  let(:role) { create(:role, title: "SuperUser") }
  let(:department) { create(:department) }
  let(:permission) { create(:permission, role: role, department: department) }
  let(:access) { create(:access, permission: permission, uniqname: user.uniqname) }

  let(:valid_attributes) do
    {
      art_item_id: art_item.id,
      updated_by: user.id,
      note: '<div>This is a test annotation</div>'
    }
  end

  let(:invalid_attributes) do
    {
      art_item_id: art_item.id,
      updated_by: nil,
      note: nil
    }
  end

  # Mock authentication and authorization for controller tests
  before do
    # Create the access record to authorize the user
    access

    # Mock authentication
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)

    # Mock session
    session[:user_uniqname] = user.uniqname

    # Mock authorization
    allow(controller).to receive(:access_authorized!).and_return(true)
    allow(controller).to receive(:check_for_authorized_access).and_return(true)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      annotation = Annotation.create! valid_attributes
      get :show, params: { id: annotation.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new annotation as @new_annotation" do
      get :new
      expect(assigns(:new_annotation)).to be_a_new(Annotation)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      annotation = Annotation.create! valid_attributes
      get :edit, params: { id: annotation.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested annotation as @annotation" do
      annotation = Annotation.create! valid_attributes
      get :edit, params: { id: annotation.to_param }
      expect(assigns(:annotation)).to eq(annotation)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Annotation" do
        expect {
          post :create, params: { annotation: valid_attributes }, format: :turbo_stream
        }.to change(Annotation, :count).by(1)
      end

      it "sets the flash notice" do
        post :create, params: { annotation: valid_attributes }, format: :turbo_stream
        expect(flash.now[:notice]).to eq("Annotation successfully created.")
      end

      it "assigns newly created annotations to @annotations" do
        post :create, params: { annotation: valid_attributes }, format: :turbo_stream
        expect(assigns(:annotations)).to include(Annotation.last)
      end

      it "assigns a new annotation to @new_annotation" do
        post :create, params: { annotation: valid_attributes }, format: :turbo_stream
        expect(assigns(:new_annotation)).to be_a_new(Annotation)
        expect(assigns(:new_annotation).art_item).to eq(art_item)
      end

      it "renders the create template" do
        post :create, params: { annotation: valid_attributes }, format: :turbo_stream
        expect(response).to render_template(:create)
      end
    end

    context "with invalid params" do
      it "does not create a new Annotation" do
        expect {
          post :create, params: { annotation: invalid_attributes }, format: :html
        }.to change(Annotation, :count).by(0)
      end

      it "returns an unprocessable_entity response" do
        post :create, params: { annotation: invalid_attributes }, format: :html
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders the new template" do
        post :create, params: { annotation: invalid_attributes }, format: :html
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          note: '<div>Updated annotation text</div>'
        }
      end

      it "updates the requested annotation" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: new_attributes }, format: :turbo_stream
        annotation.reload

        # Get the rich text content as a string
        rich_text_content = annotation.note.to_s
        expect(rich_text_content).to include('Updated annotation text')
      end

      it "sets the flash notice" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: new_attributes }, format: :turbo_stream
        expect(flash.now[:notice]).to eq("Annotation successfully updated.")
      end

      it "assigns updated annotations to @annotations" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: new_attributes }, format: :turbo_stream
        expect(assigns(:annotations)).to include(annotation)
      end

      it "renders the update template" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: new_attributes }, format: :turbo_stream
        expect(response).to render_template(:update)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable_entity response" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: invalid_attributes }, format: :html
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders the edit template" do
        annotation = Annotation.create! valid_attributes
        put :update, params: { id: annotation.to_param, annotation: invalid_attributes }, format: :html
        expect(response).to render_template(:edit)
      end
    end
  end
end
