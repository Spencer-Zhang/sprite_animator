class Animation < ActiveRecord::Base
  has_many :frames
  belongs_to :spritesheet

  def to_csv
    self.frames.to_a.map(&:to_csv).join("\n")
  end
end
