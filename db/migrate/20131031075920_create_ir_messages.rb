class CreateIrMessages < ActiveRecord::Migration
  def change
    create_table :ir_messages2,:options => "ENGINE=InnoDB,CHARACTER SET 'utf8'" do |t|
      t.string :name,:limit => 63 , :null => false
      t.string :name_f,:limit => 63 , :null => true
      t.string :company_name,:limit => 127 , :null => true
      t.string :company_name_f,:limit => 127 , :null => true
      t.string :address,:limit => 127 , :null => true
      t.string :phone,:limit => 32 , :null => true
      t.string :mail_addr,:limit => 63 , :null => true
      t.text :message, :null => true
      t.boolean :mail_sent, null: false,default: false
      t.timestamps
    end
  end
end
