class Frame < ActiveRecord::Base
  belongs_to :animation
  belongs_to :spritesheet
end
