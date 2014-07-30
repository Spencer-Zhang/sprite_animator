class Spritesheet < ActiveRecord::Base
  has_many :sprites
  mount_uploader :file, SpritesheetUploader
end
