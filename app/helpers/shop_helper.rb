module ShopHelper
  def areas
    ret = {}
    Area.active.each do |a|
      ss = a.shops.map do |s|
        s.id
      end
      ret[a.code] = ss
    end
    ret
  end
end
