class ReportAward < ActiveRecord::Base
  belongs_to :report
  belongs_to :award
end