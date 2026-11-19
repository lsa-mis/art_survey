# frozen_string_literal: true

# Ruby 4 + SimpleCov can make Devise helpers like authenticate_user! look
# unimplemented to RSpec verifying doubles (Kernel#respond_to? returns false
# until method lookup is warmed). Bypass verification for this known helper.
module DeviseControllerStubHelpers
  def stub_authenticate_user!
    without_partial_double_verification do
      allow(controller).to receive(:authenticate_user!).and_return(true)
    end
  end
end

RSpec.configure do |config|
  config.include DeviseControllerStubHelpers, type: :controller
end
