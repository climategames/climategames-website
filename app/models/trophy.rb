class Trophy < ActiveRecord::Base
  belongs_to :team
  belongs_to :game_round
  belongs_to :award

  validates :team, :game_round, :award, :rank, presence: true

  scope :order_by_rank, -> { order("case rank when 'winner' then 1 when 'runner_up' then 2 when 'mention' then 3 end asc") }

  def picture_url(style = nil)
    if self.team.image?
      self.team.image(style)
    elsif report_image = self.team.reports.map(&:pictures).flatten.first
      report_image.image(style)
    else
      ActionController::Base.helpers.asset_path("pictures/missing_#{I18n.locale.to_s}.png")
    end
  end
end
