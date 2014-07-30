class Sprite < ActiveRecord::Base
  has_many :frames
  belongs_to :spritesheet
end
