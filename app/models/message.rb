class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :content, presence: true, unless: :image?
  # もしimageカラムが空だったら

  mount_uploader :image, ImageUploader
end
