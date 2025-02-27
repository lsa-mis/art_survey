# == Schema Information
#
# Table name: page_informations
#
#  id         :bigint           not null, primary key
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe PageInformation, type: :model do
  # Setup - create necessary test objects
  let(:valid_attributes) do
    {
      location: 'home',
      content: '<div>This is test content for the home page</div>'
    }
  end

  # Association tests
  describe 'associations' do
    it 'has rich text content' do
      # Test that the model responds to the content method
      page_info = PageInformation.new
      expect(page_info).to respond_to(:content)
    end
  end

  # Database constraints
  describe 'database constraints' do
    it 'has a NOT NULL constraint on location in the database' do
      # This test verifies the database constraint, not the model validation
      page_info = PageInformation.new(valid_attributes.merge(location: nil))

      # The model itself doesn't validate location, but the database will reject nil
      expect {
        # Skip validations to test the database constraint
        page_info.save(validate: false)
      }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  # Factory tests
  describe 'factory' do
    it 'has a valid factory' do
      page_info = build(:page_information)
      expect(page_info).to be_valid
    end

    it 'can create a page information with content' do
      page_info = build(:page_information)
      page_info.content = '<div>Test content</div>'
      expect(page_info).to be_valid
    end

    it 'can create a page information with a specific location' do
      page_info = build(:page_information, location: 'specific_location')
      expect(page_info.location).to eq('specific_location')
    end

    it 'can create a page information with custom content' do
      page_info = build(:page_information, content_text: 'Custom content')
      expect(page_info.content.body.to_s).to include('Custom content')
    end

    it 'can use traits for common pages' do
      home_page = build(:page_information, :home)
      expect(home_page.location).to eq('home')
      expect(home_page.content.body.to_s).to include('Welcome to the home page')
    end
  end

  # Instance method tests
  describe 'instance methods' do
    it 'creates a valid page information' do
      page_info = PageInformation.new(valid_attributes)
      expect(page_info).to be_valid
    end
  end

  # Callback tests
  describe 'callbacks' do
    it 'clears cache after save' do
      page_info = create(:page_information, location: 'test_location')

      # Mock the Rails cache to verify it's called
      expect(Rails.cache).to receive(:delete).with("page_information/test_location")

      # Trigger the after_save callback
      page_info.save
    end
  end

  # Behavior tests
  describe 'behavior' do
    it 'stores rich text content in the content field' do
      content = '<div>This is <strong>rich</strong> text content</div>'
      page_info = PageInformation.create(valid_attributes.merge(content: content))
      expect(page_info.content.body.to_s).to include('This is <strong>rich</strong> text content')
    end

    it 'can update content' do
      page_info = create(:page_information)
      page_info.content = '<div>Updated content</div>'
      page_info.save

      # Reload from database to ensure it was saved
      page_info.reload
      expect(page_info.content.body.to_s).to include('Updated content')
    end

    it 'can find by location' do
      create(:page_information, location: 'about')
      create(:page_information, location: 'contact')

      about_page = PageInformation.find_by(location: 'about')
      expect(about_page).to be_present
      expect(about_page.location).to eq('about')
    end
  end
end
