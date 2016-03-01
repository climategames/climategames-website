class Team < ActiveRecord::Base
  has_secure_password

  has_many :reports
  has_many :trophies

  has_attached_file :image, styles: { large: '1024x1024>', small: '250x250>', thumb: '120x120', original: '100%' }, convert_options: { all: '-strip' }, default_style: :large, default_url: Proc.new { ActionController::Base.helpers.asset_path("pictures/missing_#{I18n.locale.to_s}.png") }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: false, if: Proc.new { |team| team.password.present? }
  validates :password, presence: true, on: :create

  scope :alphabetical, -> { order('lower(name)') }
  scope :with_approved_reports, -> { joins(:reports).group('teams.id').having('count(reports.id) > 0').where("reports.moderation_outcome = 'approved'") }
  scope :with_image, -> { where('image_file_name IS NOT NULL') }

  def approved_reports
    reports.where(:moderation_outcome => :approved)
  end

  def approved_reports_count
    reports.where(:moderation_outcome => [:approved]).count
  end

  def pending_reports_count
    reports.where(:moderation_outcome => [nil, :pending]).count
  end

  def rejected_reports_count
    reports.where(:moderation_outcome => :rejected).count
  end

  def tweet_text
    # We have 140 characters. https link takes up 24 characters with t.co shortening + space before.
    #  via @Climate_Games prefixed by a space is another 19 characters.
    #  are playing #ClimateGames prefixed by a space is another 26 characters.
    # So we have 71 characters left
    text = "#{name.truncate(71)} are playing #ClimateGames"
    return CGI.escape(text)
  end

end
