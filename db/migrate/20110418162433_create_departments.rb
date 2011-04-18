class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :name

      t.timestamps
    end
    
    change_table :people do |t|
      t.integer :department_id
    end
  end

  def self.down
    change_table :people do |t|
    end
    drop_table :departments
  end
end