# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join("node_modules")

# Enable the asset pipeline
Rails.application.config.assets.enabled = true

# Precompile additional assets
Rails.application.config.assets.precompile += %w( application.tailwind.css actiontext.tailwind.css )
