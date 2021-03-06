require 'capybara'
require 'capybara/poltergeist'

class IllegalStatusCodeErrror < StandardError; end

class WebClient
  def initialize(url)
    @url = url
  end

  def body
    session.body
  end

  private

  def session
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 1000)
    end
    Capybara.default_selector = :xpath
    session = Capybara::Session.new(:poltergeist)

    session.driver.headers = { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)' }
    session.visit @url
    raise IllegalStatusCodeErrror.new "URL: #{url}, Status Code: #{session.status_code}" unless session.status_code == 200

    session
  end
end
