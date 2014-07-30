class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :sprite_id
      t.integer :animation_id
      t.integer :offset_x, :offset_y

      t.timestamps
    end
  end
end
