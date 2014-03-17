class Integer
  def to_currency()
    self.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
  end
end
module MenuHelper
  THEDAY20140401 = Time.new(2014,4,1).freeze
  def digit(val)
    #税込価格
    wtax = val.to_currency
    #税抜き価格
    tax = Time.current() >= THEDAY20140401 ? 0.08 : 0.05
    wotax = (val / (1+tax)).ceil.to_currency
    alt = "税込価格:#{wtax}円 税抜本体価格:#{wotax}円"
    wtax_img = wtax.split('').map do |d|
      image_tag64 "menu/digit/#{d}.gif" ,:alt => alt
    end
    #円 税込みの追加
    wtax_img.push image_tag64 "menu/digit/t.gif",:alt => alt
    #税抜の追加
    wotax_img = wotax.split('').map do |d|
      image_tag64 "menu/digit/#{d}.gif" ,:alt => alt
    end
    wotax_img.push image_tag64 "menu/digit/t2.gif",:alt => alt
    return raw (wtax_img + wotax_img).join('')
  end

end
