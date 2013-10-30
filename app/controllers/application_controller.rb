class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #@@my_route_keys = Set.new
  @@my_route_data = {}
  #アノテーションメソッドの処理
  def self.anot(m,attrs)
    key = "#{self.controller_name}##{m.to_s}"
    find_routes do |r|
      r[key] = {} unless r[key].present?
      r[key][:title] = attrs[:title]
      r[key][:parent] = attrs[:parent]
      r[key][:controller] = self.controller_name
      r[key][:action] = m.to_s
      r[key][:format] = attrs.key?(:format) ? attrs[:format] : :html
      r[key][:valiation] = attrs[:valiation]
      r[key][:pattern] = attrs[:pattern] if attrs.key? :pattern
    end
  end

  def self.route_keys
    # @@my_route_keys.each do |key|
    #   yield("#{key}.html".gsub('#','/'),key)
    # end
    @@my_route_data.each do |k,v|
      if v[:controller] == self.controller_name

        if v.key?(:pattern)
          yield(v[:pattern],k)
        end
        yield("#{k}(.:format)".gsub('#','/'),k) unless v.key?(:pattern)
      end
    end
  end

  def generate_sitemap
    smap = nil
    ApplicationController.find_routes do |r|
      smap = r['top#index'].clone
      recursive_sitemap(r.clone,smap)
    end
    smap
  end

  def recursive_sitemap(routes,current)
    routes.each do | key,value_org |
      value = value_org.clone
      if value[:parent] == "#{current[:controller]}##{current[:action]}"
        current[:children] = [] unless current[:children]
        puts value
        unless value[:valiation]
          current[:children] << value
          recursive_sitemap(routes,value)
        else
          puts "-------------------------valiation-------------------------"
          #puts value[:valiation].call
          current[:children] = value[:valiation].call
        end

      end
    end
  end

  #private
  def self.find_routes
    #ルートの一覧を取得
    #routes = Rails.cache.read(:sitemap)
    routes = @@my_route_data
    routes = {} unless routes.present?
    Rails.application.routes.routes.each do |route|
      d = route.defaults
      #コントローラー名・アクション名が空白・RAILSののものなら処理しない
      next unless d[:controller].present? and d[:action].present?
      next if d[:controller].start_with?('rails')

      cnt = route.defaults[:controller]
      act = route.defaults[:action]
      #puts "-----------------------#{cnt}##{act}"
      routes["#{cnt}##{act}"] = {} unless routes["#{cnt}##{act}"].present?
    end if routes.empty?
    yield routes
    #Rails.cache.write(:sitemap,routes)
    @@my_route_data = routes
    routes
    end

end
