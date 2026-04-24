require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module SendWave
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # Worker configuration for screenshot generation
    config.screenshot_workers = ENV.fetch('SCREENSHOT_WORKERS', 4).to_i
    config.screenshot_timeout = ENV.fetch('SCREENSHOT_TIMEOUT', 30).to_i

    config.active_job.queue_adapter = :sidekiq
  end
end
