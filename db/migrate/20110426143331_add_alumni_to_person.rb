class AddAlumniToPerson < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.boolean :alumni
    end
  end

  def self.down
    t.remove :alumni
  end
end
