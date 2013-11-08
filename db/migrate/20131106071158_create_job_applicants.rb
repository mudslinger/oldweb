class CreateJobApplicants < ActiveRecord::Migration
  def change
    create_table :job_applicants ,:options => "ENGINE=InnoDB,CHARACTER SET 'utf8'" do |t|
      t.boolean :male,null: false
      t.date :birthday,null:false
      t.string :name,null:false,limit:63
      t.string :zip,null:true,limit:31
      t.string :address,null:false,limit:255
      t.string :phone,null:true,limit:63
      t.string :mail_addr,null:false,limit:127
      t.string :work_style,null:false,limit:63
      t.integer :shop_id,null:false
      t.string :method,null:false,limit:63
      t.string :ip_addr,null:true,limit: 15
      t.float :lat,null: true
      t.float :lng,null: true
      t.decimal :work_times,null: false,default: 0
      t.text :message,null:true
      t.boolean :sent,null:false,default:false
      t.timestamps
    end
  end
end
