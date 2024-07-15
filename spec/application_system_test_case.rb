require "rails_helper"

# Settings for all system tests
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  RSpec.configure do |config|
    config.before(:each, type: :system) do
      driven_by :rack_test
    end

    config.before(:each, type: :system, js: true) do
      if ENV["SELENIUM_DRIVER_URL"].present?
        Capybara.server = :puma, {Silent: true}
        Capybara.server_host = "0.0.0.0"
        Capybara.server_port = 3001
        Capybara.app_host = "http://web:#{Capybara.server_port}"

        driven_by :selenium, using: :chrome,
          options: {
            browser: :remote,
            url: ENV.fetch("SELENIUM_DRIVER_URL")
          }
      else
        driven_by :selenium_chrome_headless
      end
    end
  end
end
