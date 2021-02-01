# frozen_string_literal: true

module CookieHelper
  def cookie_named(name)
    Capybara.current_session.driver.browser.manage.cookie_named(name)
  rescue Selenium::WebDriver::Error::NoSuchCookieError
    nil
  end
end
