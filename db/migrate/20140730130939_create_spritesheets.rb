class CreateSpritesheets < ActiveRecord::Migration
  def change
    create_table :spritesheets do |t|
      t.string :filename
      t.string :file

      t.timestamps
    end
  end
end
