class Comment < ApplicationRecord
  belongs_to :plan
  validates :user_id, presence: true
  validates :plan_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
