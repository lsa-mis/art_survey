require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#show_svg' do
    it 'returns the default attachment icon for blank types' do
      expect(helper.show_svg('')).to include('attachment-1483.svg')
    end

    it 'returns the pdf icon for pdf content types' do
      expect(helper.show_svg('application/pdf')).to include('pdf-3375.svg')
    end

    it 'returns the office icon for word document content types' do
      expect(helper.show_svg('application/msword')).to include('office-1466.svg')
    end

    it 'returns the jpg icon for image content types' do
      expect(helper.show_svg('image/jpeg')).to include('jpg-1476.svg')
    end

    it 'returns the default attachment icon for unknown content types' do
      expect(helper.show_svg('application/octet-stream')).to include('attachment-1483.svg')
    end
  end
end
