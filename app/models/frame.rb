class Frame < ActiveRecord::Base
  belongs_to :animation
  has_one :spritesheet, through: :animation

  def to_csv
    "#{self.x}, #{self.y}, #{self.width}, #{self.height}, #{self.offset_x}, #{self.offset_y}"
  end
end
