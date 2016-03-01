class Picture < ActiveRecord::Base
  belongs_to :picturable, polymorphic: true
  has_attached_file :image, styles: { large: '1024x1024>', small: '250x250>', thumb: '120x120#', original: '100%' }, convert_options: { all: '-strip' }, default_style: :large, default_url: Proc.new { ActionController::Base.helpers.asset_path("pictures/missing_#{I18n.locale.to_s}.png") }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
end