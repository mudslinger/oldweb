class Site < ActiveRecord::Base
  acts_as_nested_set
  named_scope :root, :conditions => "parent_id is null"
  named_scope :first, :first
  
  def self.find_current(d)
    return self.find(:first,:conditions =>["controller = ? and action =? and (item_id= ? or ? is null) and (menu_page = ? or ? is null)",d[:ctrl],d[:act],d[:item_id],d[:item_id],d[:menu_page],d[:menu_page]])
  end


  
  def self.create_sitemap
    Site.transaction do
      Site.delete_all
      #ルート階層
      root = Site.create(
        :name=>"TOP",
        :description=>"トップページ",
        :controller=>"top",
        :action=>"index",
        :priority=>0.9,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )

      #ルート階層
      root2 = Site.create(
        :name=>"TOP2",
        :description=>"トップページ2",
        :controller=>"top",
        :action=>"indexx",
        :priority=>0.9,
        :last_modified=>Time.now,
        :change_freq => "yearly"
      )

      #一段目
      shop = Site.create(
        :name=>"店舗情報",
        :description=>"店舗の情報",
        :keywords=>"北海道,札幌,北関東,茨城,栃木,千葉,埼玉,群馬,神奈川,静岡,愛知,三重,東京,山梨,宮城,福島,山形",
        :controller=>"shop",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )
      menu = Site.create(
        :name=>"メニュー",
        :description=>"メニュー",
        :keywords =>"醤油,味噌,塩,特製味噌,辛味噌,期間限定,サイドメニュー,トッピング",
        :controller=>"menu",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )
      #ニュース

      news = Site.create(
        :name=>"最新情報",
        :description=>"山岡家の最新情報をお伝えします",
        :controller=>"news",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )

      company = Site.create(
        :name=>"会社概要",
        :description=>"会社概要",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"company",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )
      ir = Site.create(
        :name=>"IR情報",
        :description=>"IR情報",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )

      recruit = Site.create(
        :name=>"採用情報",
        :description=>"山岡家で一緒に働きませんか？スタッフ募集中です。",
        :keywords=>"正社員,PA,アルバイト,パート,リクルート,就職活動,就活",
        :controller=>"recruit",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )
      property = Site.create(
        :name=>"物件募集",
        :description=>"弊社の店舗を運営させていただける物件を募集しています",
        :keywords=>"ロードサイド,テナント,店舗物件,不動産",
        :controller=>"property",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )
      customer = Site.create(
        :name=>"ご意見・ご感想",
        :description=>"お客様の声を募集しています",
        :controller=>"customer",
        :action=>"index",
        :priority=>0.2,
        :last_modified=>Time.now,
        :change_freq => "yearly"
      )

      thissite = Site.create(
        :name=>"山岡家HPについて",
        :description=>"このホームページについて",
        :controller=>"site",
        :action=>"about",
        :priority=>0.2,
        :last_modified=>Time.now,
        :change_freq => "yearly"
      )
      sitemap = Site.create(
        :name=>"サイトマップ",
        :description=>"サイトマップ",
        :controller=>"site",
        :action=>"sitemap",
        :priority=>0.4,
        :last_modified=>Time.now,
        :change_freq => "daily"
      )

      root.add_child(company)
      root.add_child(news)
      root.add_child(recruit)
      root.add_child(property)
      root.add_child(customer)    
      root.add_child(menu)
      root.add_child(shop)
      root.add_child(ir)
      root.add_child(thissite) 
      root.add_child(sitemap)

      #2段目
      customer.add_child(
        Site.create(
          :name=>"ご意見・ご感想(送信)",
          :description=>"お客様の声を募集しています",
          :controller=>"customer",
          :action=>"send_message",
          :priority=>0,
          :last_modified=>Time.now,
          :change_freq => "yearly"
        )
      )
      
      company.add_child(
        Site.create(
        :name=>"ヒストリー",
        :description=>"山岡家の歴史",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"company",
        :action=>"history",
        :priority=>0.5,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      company.add_child(
        Site.create(
        :name=>"ごあいさつ",
        :description=>"社長 山岡 正よりごあいさつ",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"company",
        :action=>"greetings",
        :priority=>0.4,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      company.add_child(
        Site.create(
        :name=>"SNSガイドライン",
        :description=>"",
        :keywords=>"facebook,twitter,3399,ジャスダック,JASDAQ",
        :controller=>"company",
        :action=>"sns_guideline",
        :priority=>0.4,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      company.add_child(
        Site.create(
        :name=>"創業25年感謝祭の開催について",
        :description=>"",
        :keywords=>"創業25年,3399,ジャスダック,JASDAQ",
        :controller=>"company",
        :action=>"aniv_25",
        :priority=>0.7,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"財務ハイライト",
        :description=>"財務ハイライト",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"highlight",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"財務情報",
        :description=>"財務情報",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"infomation",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"事業の概要",
        :description=>"事業の概要",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"business",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"電子公告",
        :description=>"電子公告",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"announce",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"IRライブラリ",
        :description=>"IRライブラリ",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"library",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"IRライブラリ(開示資料一覧)",
        :description=>"IRライブラリ(開示資料一覧)",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"past_library",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"株式情報",
        :description=>"株式情報",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"stock",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"株価情報",
        :description=>"株価情報",
        :keywords=>"3399,ジャスダック,JASDAQ",
        :controller=>"ir",
        :action=>"market",
        :priority=>0.3,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"IRお問い合わせ",
        :description=>"IRお問い合わせ",
        :controller=>"ir",
        :action=>"contact",
        :priority=>0.1,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      ir.add_child(
        Site.create(
        :name=>"IRお問い合わせ(送信)",
        :description=>"IRお問い合わせ(送信)",
        :controller=>"ir",
        :action=>"contact_send",
        :priority=>0,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      ) 
      ir.add_child(
        Site.create(
        :name=>"免責事項",
        :description=>"免責事項",
        :controller=>"ir",
        :action=>"disclaimer",
        :priority=>0.1,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      recruit.add_child(
        Site.create(
        :name=>"応募フォーム",
        :description=>"採用応募フォーム",
        :controller=>"recruit",
        :action=>"entry",
        :priority=>0.1,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )
      recruit.add_child(
        Site.create(
        :name=>"応募フォーム",
        :description=>"採用応募フォーム",
        :controller=>"recruit",
        :action=>"entry_send",
        :priority=>0,
        :last_modified=>Time.now,
        :change_freq => "yearly"
        )
      )

      Shop.find_current().each{ |s|
        kwds = Array.new
        kwds.push(s.name)
        kwds.push(s.pref.name) if !s.pref.nil?
        shop.add_child(
          Site.create(
          :name=>s.name + "(" + s.address + ")",
          :description=>s.name + "の情報(" + s.address + ")",
          #:keywords=> kwds.to_s,
          :controller=>"shop",
          :action=>"shop",
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "yearly",
          :item_id => s.id
          )
        )
      }
      #メニュー関連ツリーの作成
      page000 = Site.create(
        :name=>"レギュラーメニュー",
        :description=>"レギュラーメニュー",
        :keywords =>"醤油ラーメン,味噌ラーメン,塩ラーメン,特製味噌ラーメン,辛味噌ラーメン",
        :controller=>"menu",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "yearly",
        :menu_page => 0
        )
      page001 = Site.create(
        :name=>"サービスセット・トッピング/サイドメニュー",
        :description=>"サービスセット・トッピング/サイドメニュー",
        :keywords =>"ミニチャーシュー丼,白髪ネギ,海苔,チャーシュー,バター,コーン",
        :controller=>"menu",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "yearly",
        :menu_page => 1
        )
      page002 = Site.create(
        :name=>"期間・地域限定メニュー",
        :description=>"期間・地域限定メニュー",
        :controller=>"menu",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "yearly",
        :menu_page => 2
        )
      page100 = Site.create(
        :name=>"過去のメニュー",
        :description=>"山岡家の軌跡",
        :controller=>"menu",
        :action=>"index",
        :priority=>0.8,
        :last_modified=>Time.now,
        :change_freq => "yearly",
        :menu_page => 100
        )
      menu.add_child(page000)
      menu.add_child(page001)
      menu.add_child(page002)
      menu.add_child(page100)
      #ページごとに検索して追加
      Menu.find_current(0).each{ |m|
        page000.add_child(
          Site.create(
          :name=>m.name,
          :description=>m.comment,
          :controller=>"menu",
          :action=>"menu",
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "monthly",
          :item_id => m.id,
          :menu_page => 0
          )
        )
      }
      Menu.find_current(1).each{ |m|
        page001.add_child(
          Site.create(
          :name=>m.name,
          :description=>m.comment,
          :controller=>"menu",
          :action=>"menu",
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "monthly",
          :item_id => m.id,
          :menu_page => 1
          )
        )
      }
      Menu.find_current(2).each{ |m|
        page002.add_child(
          Site.create(
          :name=>m.name,
          :description=>"",
          :controller=>"menu",
          :action=>"menu",
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "monthly",
          :item_id => m.id,
          :menu_page => 2
          )
        )
      }
      Menu.find_current(100).each{ |m|
        page100.add_child(
          Site.create(
          :name=>m.name,
          :description=>m.comment,
          :controller=>"menu",
          :action=>"menu",
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "monthly",
          :item_id => m.id,
          :menu_page => 100
          )
        )
      }

      #ニュース関連のサイトマップ
      NewsRelease.topics.pure.each{|n|
        news.add_child(
          Site.create(
          :name=>n.title,
          :description=>n.title,
          :controller=>"news",
          :action=>n.news_code,
          :priority=>0.8,
          :last_modified=>Time.now,
          :change_freq => "monthly"
          )
        )
      }
    end
  end
end
