class Post < ActiveRecord::Base
  has_many :comments, :dependent => :delete_all
  belongs_to :user

  has_attached_file :image, styles: { medium: "600x600>", thumb: "150x150>" }, default_url: ":style/post_missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
