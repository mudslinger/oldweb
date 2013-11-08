require 'mime/types'
module ApplicationHelper
  def ctrl(obj)
    obj.controller_name
  end

  def act(obj)
    obj.action_name
  end

  def html(routes)
    routes[:format] = :html
    routes
  end

  #タイトルの表示
  def title(obj)
    key = "#{obj.controller_name}##{obj.action_name}"
    puts key
    begin
      sitemap[key][:title]
    rescue
      ''
    end
  end

  #サイドリンクの表示
  # TODO:コントローラ別にフィルター
  def side_links(obj)
    #puts sitemap
    ret = ''
    sitemap.each_value do |act|

      ret << link_to(
        raw("<div>#{act[:title]}</div>"),
        {action: act[:action],format: :html},
        {:class=>"sidemenu"}
      ) if act[:controller] == obj.controller_name
    end
    raw(ret)
  end
  def sitemap
    ApplicationController.find_routes do
    end
    #Rails.cache.read(:sitemap)
  end

  def static_map_link_to(shop)
    link_to(
      image_tag(
        shop.static_map.url,
        alt: "山岡家#{shop.name}地図",
        align: "right",
        style: "width:200px;height:100px;border:inset 1px #CC0000;",
        title: shop.name
      ),
      {action: 'shop',id: shop.id,format: :html}
    )
  end
  def fd (d)
    return "" unless d
    d.strftime("%Y/%m/%d")
  end
  def ft (d)
    return "" unless d
    d.strftime("%h:%M")
  end
  def fm (d)
    return "" unless d
    d.strftime("%Y年%m月")
  end

  def mfx(num)
    return "--" if num.nil?
    tmp = number_to_currency(num,:unit => "",:separator => ".", :delimiter => ",")
    #tmp = (num.to_s =~ /[-+]?\d{4,}/) ? (num.to_s.reverse.gsub(/\G((?:\d+\.)?\d{3})(?=\d)/, '\1,').reverse) : num.to_s
    #tmp = tmp.gsub(/\.00$/,"")
    return tmp.gsub(/\-/,"△")
  end

  def mf(num)
    return "--" if num.nil?

    tmp = (num.to_s =~ /[-+]?\d{4,}/) ? (num.to_s.reverse.gsub(/\G((?:\d+\.)?\d{3})(?=\d)/, '\1,').reverse) : num.to_s
    return tmp.gsub(/\-/,"△")
  end
  def h(s)
    return ERB::Util.html_escape(s)
  end

  def image_tag64(source, options = {})
    image_cache(source:source,request:request,options:options,request:request)
  end

  IMG_CACHE_PREFIX = "datauri:image:cache:"
  private
  def image_cache(source: nil,insteadof: '', options: {},request: nil)

    agent = Agent.new(request.user_agent)

    use_data_uri = !(agent.name.to_s == 'IE')
    puts "-#-#-#-#=##{agent.name.to_s} -#-#{use_data_uri}"
    subkey = use_data_uri ? 'data-uri:' : 'plain:'
    src = Rails.cache.read(IMG_CACHE_PREFIX + subkey + source)
    puts "cache:hit! ---#{IMG_CACHE_PREFIX + subkey + source}---" if src
    #変換・キャッシュ処理
    unless src then
      puts "cache:miss! ---#{IMG_CACHE_PREFIX + subkey + source}"
      #表面上のURL
      facade_path = Rails.root.join('app','assets','images',source).to_s
      #代替パス
      ins_path = Rails.root.join('app','assets','images',insteadof).to_s unless insteadof.blank?
      #実際のパス
      real_path = File.exist?(facade_path) ? facade_path : ins_path

      #実際のパス上に存在するファイルサイズが一定以上の場合、data-uriは使用しない。
      use_data_uri = use_data_uri && File.exist?(facade_path) && File.size(real_path) < 50 * 1024

      src = image2datauri(real_path) if use_data_uri && !real_path.blank?
      src = File.exist?(facade_path) ? source : insteadof unless use_data_uri

      Rails.cache.write(IMG_CACHE_PREFIX + subkey + source  ,src,expires_in: 1.hour)
      puts "cache:add! ---#{IMG_CACHE_PREFIX + subkey + source}"
    end
    #最終的に画像が無い場合はIMAGETAGを送出しない
    src.blank? ? '' : image_tag(src,options)
  end

  def image2datauri(path)
    buffer = []

    File.open(path,'rb') do |io|
      buffer << io.read
    end
    mimetype = MIME::Types.type_for(path)[0].to_s
    src = "data:#{mimetype};base64,"
    src << buffer.pack("m").gsub(/[\r\n]/,'')
    src
  end
end
