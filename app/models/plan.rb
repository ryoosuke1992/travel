class Plan < ApplicationRecord
  belongs_to :user
  has_many :users, through: :participants
  has_many :participants, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :date, :place, :meeting_place, :meeting_time, :content, presence: true
  validates :plan_comment, presence: true, length: { maximum: 120 }
  mount_uploader :image, ImageUploader

  def feed_comment(plan_id)
    Comment.where("plan_id = ?", plan_id)
  end
end
