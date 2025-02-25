// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"  // This imports controllers/index.js

// Import Trix and ActionText in the correct order
import "trix"
import * as ActionText from "@rails/actiontext"
