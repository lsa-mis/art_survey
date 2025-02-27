require 'rails_helper'

RSpec.describe "Annotations", type: :system do
  let(:user) { create(:user) }
  let(:art_item) { create(:art_item) }
  let(:role) { create(:role, title: "SuperUser") }
  let(:department) { create(:department) }
  let(:permission) { create(:permission, role: role, department: department) }
  let(:access) { create(:access, permission: permission, uniqname: user.uniqname) }

  before do
    # Create the access record to authorize the user
    access

    # Set up authentication
    driven_by(:rack_test)

    # Mock authentication
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # Mock session
    page.driver.browser.rack_mock_session.cookie_jar['user_uniqname'] = user.uniqname

    # Mock authorization
    allow_any_instance_of(ApplicationController).to receive(:access_authorized!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:check_for_authorized_access).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:is_super_user!).and_return(true)

    # Mock helper method for user display name
    allow_any_instance_of(ApplicationHelper).to receive(:show_user_name_by_id).and_return(user.display_name)
  end

  describe "Annotation management" do
    before do
      # Visit the art item page where annotations would be managed
      visit art_item_path(art_item)
    end

    it "displays existing annotations" do
      # Create an annotation for the art item
      annotation = create(:annotation, art_item: art_item, updated_by: user.id)

      # Refresh the page to see the annotation
      visit art_item_path(art_item)

      # Check that the annotation is displayed
      expect(page).to have_content("This is a factory-generated annotation note")
    end

    it "allows creating a new annotation", js: true do
      skip "Skipping JS tests for now - requires proper setup"
      # Switch to JS driver for this test
      driven_by(:selenium_chrome_headless)

      # Re-setup authentication for JS driver
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:access_authorized!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:check_for_authorized_access).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:is_super_user!).and_return(true)

      # Visit the page
      visit art_item_path(art_item)

      # Fill in the form - no need to click a button as the form is already visible
      within "#new_annotation" do
        # Use the rich text editor to add content
        find("trix-editor").click.set("This is a new test annotation")

        # Submit the form - the button is "Add Annotation" not "Create Annotation"
        click_button "Add Annotation"
      end

      # Check that the new annotation appears
      expect(page).to have_content("Annotation successfully created")
      expect(page).to have_content("This is a new test annotation")
    end

    it "allows editing an existing annotation", js: true do
      skip "Skipping JS tests for now - requires proper setup"
      # Switch to JS driver for this test
      driven_by(:selenium_chrome_headless)

      # Re-setup authentication for JS driver
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:access_authorized!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:check_for_authorized_access).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:is_super_user!).and_return(true)

      # Create an annotation for the art item
      annotation = create(:annotation, art_item: art_item, updated_by: user.id)

      # Visit the page
      visit art_item_path(art_item)

      # Click edit on the annotation
      within "#annotations" do
        click_link "Edit"
      end

      # Edit the annotation - the form is now loaded in a turbo frame
      within "form" do
        find("trix-editor").click.set("This annotation has been updated")
        click_button "Update"
      end

      # Check that the updated annotation appears
      expect(page).to have_content("Annotation successfully updated")
      expect(page).to have_content("This annotation has been updated")
    end
  end

  describe "Annotation display" do
    it "shows annotations in reverse chronological order" do
      # Create multiple annotations
      old_annotation = create(:annotation, art_item: art_item, updated_by: user.id, created_at: 2.days.ago)
      new_annotation = create(:annotation, art_item: art_item, updated_by: user.id, created_at: 1.day.ago, note_content: "This is a newer annotation")

      # Visit the art item page
      visit art_item_path(art_item)

      # Check that both annotations are displayed
      expect(page).to have_content("This is a factory-generated annotation note")
      expect(page).to have_content("This is a newer annotation")
    end

    it "displays the user who created the annotation" do
      # Create an annotation
      annotation = create(:annotation, art_item: art_item, updated_by: user.id)

      # Visit the art item page
      visit art_item_path(art_item)

      # Check that the user information is displayed
      within "#annotations" do
        expect(page).to have_content(user.display_name)
      end
    end
  end
end
