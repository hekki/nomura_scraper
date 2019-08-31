['./lib', './lib/slack'].each do |dir|
  Dir[File.expand_path(dir, __dir__) << '/*.rb'].each(&method(:require))
end

def lambda_handler(event:, context:)
  ENV['PATH'] += ':/var/task/bin'

  keys.each do |key|
    web_client = WebClient.new key
    fund = Fund.new web_client.body

    slack_notifier = SlackNotifier.new
    slack_attachemnt = SlackAttachment.new fund: fund, web_client: web_client
    slack_notifier.post channel: slack_channel, attachments: slack_attachemnt.make
  end
end

def keys
  keys = ENV['NOMURA_KEYS']
  return [] if keys.nil?

  keys.split(',').map(&:strip)
end

def slack_channel
  ENV['SLACK_CHANNEL'].nil? ? '#general' : ENV['SLACK_CHANNEL']
end
