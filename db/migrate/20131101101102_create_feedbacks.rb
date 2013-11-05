class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks ,options: "ENGINE=InnoDB,CHARACTER SET 'utf8'" do |t|
      t.string :mail_addr,limit: 63 , null: false
      t.string :name,limit: 32 , null: false
      t.integer :age,null: true
      t.boolean :male,null: true
      t.string :address,limit:127,null:true
      t.string :phone,limit:63,null:true
      t.string :ip_addr, limit:15,null:false
      t.float :lat,null:true
      t.float :lng,null:true
      t.string :region,null:true
      t.integer :shop_id,null:true
      t.date :visit_date,null:true
      t.integer :visit_time,null:true
      t.integer :repetition,null:true
      t.integer :menu_id,null:true
      t.integer :q,null:true
      t.integer :s,null:true
      t.integer :c,null:true
      t.integer :a,null:true
      t.boolean :reply,null:false
      t.text :message,null:false
      t.boolean :mail_sent ,null:false,default: false
      t.timestamps
    end
  end
end
