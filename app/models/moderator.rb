class Moderator < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password

  scope :enabled, -> { where(enabled: true) }
  scope :super_cape, -> { where(super_cape: true) }

end
