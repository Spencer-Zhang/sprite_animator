class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :spritesheet_id
      t.integer :animation_id

      t.integer :height, :width, :x, :y
      t.integer :offset_x, :offset_y

      t.timestamps
    end
  end
end
