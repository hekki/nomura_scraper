require 'nokogiri'

class Fund
  def initialize(key)
    @key = key
    @html = nil
  end

  def name
    title = select_by_xpath('//title').first
    title = title.children.first.text

    # NOTE: 'ファンド名｜商品・サービス｜野村證券' といったstring が取れるので、余計な文字を省く
    name = title.split('｜').first
    width_full_to_half(name)
  end

  def date
    date_text = select_by_xpath('//section/p[@class="txt"]').first
    Date.parse(date_text)
  end

  def base_price
    # NOTE: .first で '基準価額 前日比' の行の td が取得できる
    td = select_by_xpath('//table[@class="tbl -secondary -compact -middle"]//td[@class="_ta-r"]').first

    # NOTE: td.children.first で基準価額の行に対応するオブジェクトを取得
    td.children.first.text
  end

  def day_before_ratio
    span = select_by_xpath('//table[@class="tbl -secondary -compact -middle"]//td[@class="_ta-r"]/span').first

    # NOTE: span.children.first で前日比の行に対応するオブジェクトを取得
    span.children.first.text
  end

  def price_drop?
    day_before_ratio.start_with?('-')
  end

  def url
    "https://advance.quote.nomura.co.jp/meigara/nomura2/qsearch.exe?F=users/nomura/detail2&KEY1=#{@key}"
  end

  private

  def html
    return @html unless @html.nil?

    web_client = WebClient.new(url)
    @html = Nokogiri::HTML.parse(web_client.body)
  end

  def select_by_xpath(xpath)
    html.xpath(xpath)
  end

  def width_full_to_half(str)
    str.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').tr('　', ' ')
  end
end
