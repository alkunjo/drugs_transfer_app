require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module DrugsTransferApp
  class Application < Rails::Application
  	config.assets.enabled = true
  	config.assets.paths << Rails.root.join('vendor','assets','css')
  	config.assets.paths << Rails.root.join('vendor','assets','js')
    config.assets.paths << Rails.root.join('vendor','assets','img')
  	config.assets.paths << Rails.root.join('vendor','assets','images')
  	config.assets.paths << Rails.root.join('app','assets','fonts')
  	config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
		config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
  	
  end
end
