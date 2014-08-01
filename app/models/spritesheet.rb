class Spritesheet < ActiveRecord::Base
  has_many :animations
  has_many :frames, through: :animations
  mount_uploader :file, SpritesheetUploader
end
