require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorldOfStars
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = 'Paris'
  end
end
