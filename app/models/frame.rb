class Frame < ActiveRecord::Base
  belongs_to :animation
  belongs_to :sprite
end
