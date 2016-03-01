class GameRound < ActiveRecord::Base
  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :ends_at_is_after_starts_at

  has_many :reports
  has_many :trophies

  def self.current
    # For now only COP21 is a game round, in future this could
    # return a different one, probably to be specified in a config
    # file
    GameRound.where(name: "COP21").first!
  end

  def active?
    Time.current > starts_at && Time.current < ends_at
  end

  private

  def ends_at_is_after_starts_at
    if self.ends_at < self.starts_at
      errors[:ends_at] << "must be at after starts_at: #{starts_at.to_s}"
    end
  end
end
