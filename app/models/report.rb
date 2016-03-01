class Report < ActiveRecord::Base
  CATEGORIES = [[I18n.t('cg.reports.adventure'), 'adventure'], [I18n.t('cg.reports.intel'), 'intel']]

  attr_accessor :password
  has_many :links
  belongs_to :team
  belongs_to :current_moderator, class_name: "Moderator"
  belongs_to :game_round

  has_many :report_awards, dependent: :destroy, inverse_of: :report
  has_many :awards, through: :report_awards

  after_initialize :defaults
  before_validation { image.clear if @delete_image }

  has_attached_file :image, styles: { large: '1024x1024>', small: '150x150>', thumb: '60x60#', original: '100%' }, convert_options: { all: '-strip' }, default_style: :large, default_url: 'https://www.climategames.net/assets/small/missing.png'
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  has_many :pictures, as: :picturable, dependent: :destroy
  accepts_nested_attributes_for :pictures

  validates :title, :latitude, :longitude, :date_time, presence: true
  validates :location, presence: true, unless: Proc.new { |r| r.longitude.present? && r.latitude.present? }
  validates :password, presence: true, unless: Proc.new { |r| r.team_id.blank? }, on: :create
  validates :game_round, presence: true

  validate :authenticate_team_if_present, on: :create
  validate :check_location_has_a_lat_lng

  validate :check_moderation_outcome_valid

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :awards, reject_if: :all_blank, allow_destroy: true

  scope :with_award, -> (award_id) { joins(:awards).group('reports.id').having('count(awards.id) > 0').where('awards.id = ?', award_id) }
  scope :with_pictures, -> { joins(:pictures).group('reports.id').having('count(pictures.id) > 0') }
  scope :with_team, -> (team_id) { where('team_id = ?', team_id) }

  scope :approved, -> { where(moderation_outcome: 'approved') }
  scope :rejected, -> { where(moderation_outcome: 'rejected') }
  scope :pending, -> { where("moderation_outcome is NULL OR moderation_outcome = '' OR moderation_outcome = 'pending'") }

  scope :adventure, -> { where(category: 'adventure') }
  scope :intel, -> { where(category: 'intel') }

  def destroy_pictures_with_id(delete_ids)
    if delete_ids.try(:any?)
      pictures_to_delete = self.pictures.where id: delete_ids
      pictures_to_delete.each { |picture| picture.destroy }
    end
  end

  def primary_picture_url(style = nil)
    if self.pictures.any?
      pictures.first.image style.try(:to_sym)
    else
      ActionController::Base.helpers.asset_path("pictures/missing_#{I18n.locale.to_s}.png")
    end
  end

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end

  def rejected?
    moderation_outcome == "rejected"
  end

  def approved?
    moderation_outcome == "approved"
  end

  def pending?
    moderation_outcome.blank?
  end

  def self.moderation_outcome_options
    %w{approved pending rejected}
  end

  def self.category_options
    %w{intel adventure}
  end

  def update_from_moderation!(params)
    update_attributes!(params.merge(current_moderator: nil, checked_at: Time.current))
  end

  def tweet_text
    # We have 140 characters. https link takes up 24 characters with t.co shortening + space before.
    #  #ClimateGames prefixed by a space is another 14 characters.
    #  via @Climate_Games prefixed by a space is another 19 characters.
    # So we have 83 characters left
    text = ""
    characters_left = 83
    if team
      characters_left = characters_left - team.name.length - 4
    end

    if team && characters_left > 50
      text = "#{title.truncate(characters_left)} by #{team.name}"
    else
      text = title.truncate(83)
    end
    return CGI.escape(text)
  end

  def check_location_has_a_lat_lng
    if location && !latitude || !longitude
      errors.add :location, I18n.t('cg.reports.is_invalid')
    end
  end

  def check_moderation_outcome_valid
    return if moderation_outcome.blank?
    return if Report::moderation_outcome_options.include? moderation_outcome
    errors.add :moderation_outcome, I18n.t('cg.reports.invalid_moderation_outcome')
  end

  def authenticate_team_if_present
    return unless team_id

    team = Team.find_by_id team_id
    authenticated = team.authenticate password if team

    if !team || !authenticated
      errors.add :password, I18n.t('cg.reports.is_incorrect')
    end
  end

  private

  def defaults
    self.game_round = GameRound.current
  end
end
