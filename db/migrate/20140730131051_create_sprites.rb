class CreateSprites < ActiveRecord::Migration
  def change
    create_table :sprites do |t|
      t.integer :spritesheet_id
      t.integer :height, :width, :x, :y

      t.timestamps
    end
  end
end
