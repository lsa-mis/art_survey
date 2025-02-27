require 'rails_helper'

RSpec.describe PageInformationsController, type: :controller do
  # Setup
  let(:user) { create(:user) }
  let(:role) { create(:role, title: "SuperUser") }
  let(:department) { create(:department) }
  let(:permission) { create(:permission, role: role, department: department) }
  let(:access) { create(:access, permission: permission, uniqname: user.uniqname) }

  let(:valid_attributes) {
    { location: "test_page", content: "<div>Test content</div>" }
  }

  # Mock authentication and authorization
  before do
    # Mock authentication
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)

    # Mock authorization
    allow(controller).to receive(:super_user_access_authorized!).and_return(true)

    # Create access record
    access
  end

  describe "GET #index" do
    it "returns a success response" do
      page_information = PageInformation.create! valid_attributes
      get :index
      expect(response).to be_successful
    end

    it "assigns all page_informations as @page_informations" do
      page_information = PageInformation.create! valid_attributes
      get :index
      expect(assigns(:page_informations)).to include(page_information)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      page_information = PageInformation.create! valid_attributes
      get :show, params: { id: page_information.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested page_information as @page_information" do
      page_information = PageInformation.create! valid_attributes
      get :show, params: { id: page_information.to_param }
      expect(assigns(:page_information)).to eq(page_information)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new page_information as @page_information" do
      get :new
      expect(assigns(:page_information)).to be_a_new(PageInformation)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      page_information = PageInformation.create! valid_attributes
      get :edit, params: { id: page_information.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested page_information as @page_information" do
      page_information = PageInformation.create! valid_attributes
      get :edit, params: { id: page_information.to_param }
      expect(assigns(:page_information)).to eq(page_information)
    end
  end

  describe "POST #create" do
    it "creates a new PageInformation" do
      expect {
        post :create, params: { page_information: valid_attributes }
      }.to change(PageInformation, :count).by(1)
    end

    it "assigns a newly created page_information as @page_information" do
      post :create, params: { page_information: valid_attributes }
      expect(assigns(:page_information)).to be_a(PageInformation)
      expect(assigns(:page_information)).to be_persisted
    end

    it "redirects to the created page_information" do
      post :create, params: { page_information: valid_attributes }
      expect(response).to redirect_to(PageInformation.last)
    end

    it "sets a success flash message" do
      post :create, params: { page_information: valid_attributes }
      expect(flash[:notice]).to eq("Page information was successfully created.")
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { location: "updated_page", content: "<div>Updated content</div>" }
    }

    it "updates the requested page_information" do
      page_information = PageInformation.create! valid_attributes
      put :update, params: { id: page_information.to_param, page_information: new_attributes }
      page_information.reload
      expect(page_information.location).to eq("updated_page")
    end

    it "assigns the requested page_information as @page_information" do
      page_information = PageInformation.create! valid_attributes
      put :update, params: { id: page_information.to_param, page_information: valid_attributes }
      expect(assigns(:page_information)).to eq(page_information)
    end

    it "redirects to the page_information" do
      page_information = PageInformation.create! valid_attributes
      put :update, params: { id: page_information.to_param, page_information: valid_attributes }
      expect(response).to redirect_to(page_information)
    end

    it "sets a success flash message" do
      page_information = PageInformation.create! valid_attributes
      put :update, params: { id: page_information.to_param, page_information: valid_attributes }
      expect(flash[:notice]).to eq("Page information was successfully updated.")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested page_information" do
      page_information = PageInformation.create! valid_attributes
      expect {
        delete :destroy, params: { id: page_information.to_param }
      }.to change(PageInformation, :count).by(-1)
    end

    it "redirects to the page_informations list" do
      page_information = PageInformation.create! valid_attributes
      delete :destroy, params: { id: page_information.to_param }
      expect(response).to redirect_to(page_informations_url)
    end

    it "sets a success flash message" do
      page_information = PageInformation.create! valid_attributes
      delete :destroy, params: { id: page_information.to_param }
      expect(flash[:notice]).to eq("Page information was successfully destroyed.")
    end
  end
end
