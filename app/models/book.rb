class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  has_attached_file :image, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
