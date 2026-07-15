ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "logger"

# Bootsnap's ISeq cache cannot compile while RubyVM coverage (SimpleCov) is active.
unless defined?(Coverage) && Coverage.respond_to?(:running?) && Coverage.running?
  require "bootsnap/setup" # Speed up boot time by caching expensive operations.
end
