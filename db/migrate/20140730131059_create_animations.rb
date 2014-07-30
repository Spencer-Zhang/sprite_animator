class CreateAnimations < ActiveRecord::Migration
  def change
    create_table :animations do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
