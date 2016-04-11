require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Timezone
    config.time_zone = 'Pacific Time (US & Canada)'

    # Generator Config
    config.generators do |g|
      g.assets              false
      g.fixture_replacement :factory_girl
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Autoload extra paths
    config.autoload_paths << "#{Rails.root}/app/resources/concerns"
  end
end
