class MenuController < ApplicationController
  #layout 'menu/layouts/menu'

  anot :menu , parent: 'menu#index',title:'メニュー',pattern: 'menu/:page(/:id(.:format))',valiation: ->{
    Menu.state(:active).map do |s|
      {
        controller: :menu,
        action: :menu,
        id: s.id,
        page: s.genre.page,
        title: s.name,
        parent: 'menu#index',
        format: :html
      }
    end
  }
  def menu
    @page = 0
    @page = params['page'].to_i if params['page'].present?
    @id = params['id'].to_i if params['id'].present?
    @id = Menu.heavy_lotation(@page) unless @id
    @genres = Genre.find_by_page(@page)
    @filter_type = @page == 100 ? :inactive : :active
    @menu = Menu.find(@id)
  end

  alias_method :index,:menu
  anot :index , parent: 'top#index',title:'メニュー'
end
