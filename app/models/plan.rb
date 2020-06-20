class Plan < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :users, through: :participants
	has_many :participants
	validates :title, :date, :place, :meeting_place, :meeting_time, :content, presence: true
	mount_uploader :image, ImageUploader

	def feed_comment(plan_id)
    Comment.where("plan_id = ?", plan_id)
  end
end
