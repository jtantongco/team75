class CreateVolunteers < ActiveRecord::Migration
  def self.up
    create_table :volunteers, :primary_key => :v_id do |t|
      t.integer :v_id
      t.string :first_name, :last_name, :email, :password,     :null => false    
      t.timestamps
    end
  end

  def self.down
    drop_table :volunteers
  end
end
