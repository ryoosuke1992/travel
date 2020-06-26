class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :plan_id, presence: true
end
