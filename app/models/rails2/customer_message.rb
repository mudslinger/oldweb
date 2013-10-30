require "rexml/document"
require "open-uri"
require "igo-ruby"
class CustomerMessage < ActiveRecord::Base
  DIC_ADDRESS = Rails.root.join('lib','dic').to_s

  validates_presence_of :name,:mail_addr
  validates_format_of :mail_addr,:with=> /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_confirmation_of :mail_addr
  belongs_to :shop,:foreign_key => "shop_code"
  belongs_to :menu,:foreign_key => "menu_code"
  AGE_OPTS = [
   ["15-19歳", 15],
   ["20-24歳", 20],
   ["25-29歳", 25],
   ["30-34歳", 30],
   ["35-39歳", 35],
   ["40-44歳", 40],
   ["45-49歳", 45],
   ["50-54歳", 50],
   ["55-59歳", 55],
   ["60-64歳", 60],
   ["65-69歳", 65],
   ["70歳以上", 70]
  ].freeze
  SEX_OPTS = [
   ["男性", true],
   ["女性", false]
  ].freeze
  TIME_OPTS = [
    ["9:00-10:00","9:00"],
    ["10:00-11:00","10:00"],
    ["11:00-12:00","11:00"],
    ["12:00-13:00","12:00"],
    ["13:00-14:00","13:00"],
    ["14:00-15:00","14:00"],
    ["15:00-16:00","15:00"],
    ["16:00-17:00","16:00"],
    ["17:00-18:00","17:00"],
    ["18:00-19:00","18:00"],
    ["19:00-20:00","19:00"],    
    ["20:00-21:00","20:00"],    
    ["21:00-22:00","21:00"],    
    ["22:00-23:00","22:00"],    
    ["23:00- 0:00","23:00"],    
    [" 0:00- 1:00","0:00"],    
    [" 1:00- 2:00","1:00"],
    [" 2:00- 3:00","2:00"],    
    [" 3:00- 4:00","3:00"],
    [" 4:00- 5:00","4:00"],    
    [" 5:00- 6:00","5:00"],
    [" 6:00- 7:00","6:00"],    
    [" 7:00- 8:00","7:00"],
    [" 8:00- 9:00","8:00"]
  ].freeze
  REP_OPTS = [
    ["初めて","0"],
    ["1年に1回程度","1"],
    ["半年に1回程度","2"],
    ["3ヶ月に1回程度","4"],
    ["月に1回程度","12"],
    ["月に2回程度","24"],
    ["週に1回程度","48"],
    ["週に2回程度","96"],
    ["週に3回以上","180"]
  ].freeze
  REPL_OPTS = [
    ["希望する",1],
    ["希望しない",0]
  ].freeze
  
  QSCA_OPTS = [
    ["判断できない",""],
    ["非常に悪い",-2],
    ["悪い",-1],
    ["普通",0],
    ["良い",1],
    ["非常に良い",2]
  ]

    @maddr_user = ""
    @maddr_domain = ""
  attr_accessor :maddr_user,:maddr_domain
  
  def before_save
    begin
      open("http://api.hostip.info/?ip=#{ip_addr}") { |st|  
        d = REXML::Document.new st
        p d.elements["HostipLookupResultSet/gml:featureMember/Hostip/gml:name"].text
        self.region = d.elements["HostipLookupResultSet/gml:featureMember/Hostip/gml:name"].text
      }
    rescue
      self.region = "検索失敗"
    end
    
    
    true
  end
  def mail_addr_confirmation
    return @maddr_user + "@" + @maddr_domain
  end
  
  def age_txt
    AGE_OPTS.each{ |a|
      return a[0] if a[1] == age
    }
    return "未選択"
  end
  
  def sex_txt
    SEX_OPTS.each{ |a|
      return a[0] if a[1] == sex
    }
    return "未選択"
  end
  
  def visit_time_txt
    return "未選択" if !visit_time
    TIME_OPTS.each{ |a|
      return a[0] if a[1].strip == visit_time.strftime("%H:%M")
    }
    return "未選択"
  end
  
  def rept_txt
    REP_OPTS.each{ |a|
      return a[0] if a[1] == repetition.to_s
    }
    return "未選択"
  end
  
  def qsca_txt(o)
    QSCA_OPTS.each{ |a|
      return a[0] if a[1] == o
    }
    return "未選択"
  end

  def subject_raw
    sub = "お客様よりメール(No.#{self.id})"
    sub += "【#{self.shop.name}】" if !self.shop.nil?
    sub
  end

  def subject_inspected
    sub = "お客様よりメール(No.#{self.id})[個人情報削除済]"
    sub += "【#{self.shop.name}】" if !self.shop.nil?
    sub
  end

  def body_raw
    return <<"EOS"
名前: #{self.name}
メールアドレス: #{self.mail_addr}
住所: #{self.address}
電話番号: #{self.phone}
IPアドレス: #{self.ip_addr}
発信地域(推定): #{self.region}
年齢: #{self.age_txt}
性別: #{self.sex_txt}
店舗名: #{self.shop.name if self.shop.present?}
来店日: #{(self.visit_date.strftime('%Y/%m/%d'))}  
時間帯: #{self.visit_time_txt}
頻度: #{self.rept_txt}
品質: #{self.qsca_txt(self.q)}
サービス: #{self.qsca_txt(self.s)}
クレンリネス: #{self.qsca_txt(self.c)}
店の雰囲気: #{self.qsca_txt(self.a)}
メニュー: #{self.menu.name if self.menu.present?}
返信: #{self.reply ? '希望する' : '希望しない'}
メッセージ内容: |
#{self.message}
EOS
  end

  def body_inspected

    return <<"EOS"
発信地域(推定): #{self.region}
年齢: #{self.age_txt}
性別: #{self.sex_txt}
店舗名: #{self.shop.name if self.shop.present?}
来店日: #{(self.visit_date.strftime('%Y/%m/%d'))}
時間帯: #{self.visit_time_txt}
頻度: #{self.rept_txt}
品質: #{self.qsca_txt(self.q)}
サービス: #{self.qsca_txt(self.s)}
クレンリネス: #{self.qsca_txt(self.c)}
店の雰囲気: #{self.qsca_txt(self.a)}
メニュー: #{self.menu.name if self.menu.present?}
返信: #{self.reply ? '希望する' : '希望しない'}
メッセージ内容: |
#{self.message_i}
EOS
  end

  def message_i
    tagger = Igo::Tagger.new(DIC_ADDRESS)
    t = tagger.parse(self.message) if self.message.present?
    t.map{|m|
      m.feature.include?('固有') ? '●●●' : m.surface 
    }.join if t.present?
  end
end

