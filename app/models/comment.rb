class Comment < ApplicationRecord
  validates :comment_content, presence: true, length: { maximum: 255 }
  belongs_to :user
  belongs_to :post
end
