require 'slack-ruby-client'

class SlackNotifier
  def initialize
    configure

    @client = nil
  end

  def post(message)
    client.chat_postMessage message
  end

  private

  def client
    @client ||= Slack::Web::Client.new
  end

  def configure
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end
end
