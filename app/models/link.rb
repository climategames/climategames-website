class Link < ActiveRecord::Base
  belongs_to :report
  validates :url, presence: true
end