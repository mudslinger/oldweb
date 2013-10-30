module MenuHelper
  def digit(val)
    yval =  val.to_s + "円(税込)"
    ret = image_tag64 "menu/digit/y.gif",:alt => yval
    idx = 0
    val.to_s.each_char{ |s|
      ret += image_tag64 "menu/digit/#{s}.gif" ,:alt => yval
      ret += image_tag64 "menu/digit/cm.gif",:alt => yval if val >= 1000 and idx == 0
      idx+= 1
    }
    ret += image_tag64 "menu/digit/t.gif",:alt => yval
    return ret;
  end

end
