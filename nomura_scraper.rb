require 'bundler'
Bundler.require

require './web_client'
require './fund'
require './slack/notifier'
require './slack/attachment'

# NOTE: 野村證券の投資信託ファンド詳細ページのURLに含まれる 'KEY1' を、カンマ区切りで環境変数 'nomura_keys' に設定する
#   URL example: https://advance.quote.nomura.co.jp/meigara/nomura2/qsearch.exe?F=users/nomura/detail2&KEY1=99999999
def keys
  keys = ENV['NOMURA_KEYS']
  return [] if keys.nil?

  keys.split(',').map(&:strip)
end

def slack_channel
  ENV['SLACK_CHANNEL'].nil? ? '#general' : ENV['SLACK_CHANNEL']
end

keys.each do |key|
  # web_client = WebClient.new '03311138'
  web_client = WebClient.new key
  fund = Fund.new web_client.body

  slack_notifier = SlackNotifier.new
  slack_attachemnt = SlackAttachment.new fund: fund, web_client: web_client
  slack_notifier.post channel: slack_channel, attachments: slack_attachemnt.make
end
