class Frame < ActiveRecord::Base
  belongs_to :animation
  belongs_to :spritesheet

  def to_csv
    "#{self.x}, #{self.y}, #{self.width}, #{self.height}, #{self.offset_x}, #{self.offset_y}"
  end
end
