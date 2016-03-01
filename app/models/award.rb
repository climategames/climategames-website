class Award < ActiveRecord::Base
  has_many :report_awards, dependent: :destroy, inverse_of: :award
  has_many :reports, through: :report_awards
  has_many :trophies

  scope :with_approved_reports, -> { joins(:reports).group('awards.id').having('count(reports.id) > 0').where("reports.moderation_outcome = 'approved'") }

  def name
    I18n.t("cg.awards.award_#{id}")
  end

  def description
    I18n.t("cg.awards.award_#{id}_description")
  end

  def winners
    trophies.where(rank: "winner").map(&:team)
  end

  def runner_ups
    trophies.where(rank: "runner_up").map(&:team)
  end

  def mentions
    trophies.where(rank: "mention").map(&:team)
  end
end
