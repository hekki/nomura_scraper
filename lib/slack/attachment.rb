class SlackAttachment
  def initialize(fund:)
    @fund = fund
  end

  def make
    [{
      title: @fund.name,
      title_link: @fund.url,
      pretext: pretext,
      text: text,
      color: color
    }]
  end

  private

  def color
    @fund.price_drop? ? '#ffae42' : '#36a64f'
  end

  def pretext
    "#{@fund.date.strftime('%Y年%m月%d日')}現在の情報をお知らせします :moneybag:"
  end

  def text
    <<~TEXT
      基準価格: *#{@fund.base_price}*
      前日比: *#{@fund.day_before_ratio}*
    TEXT
  end
end
