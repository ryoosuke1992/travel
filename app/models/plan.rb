class Plan < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	validates :title, :date, :place, :meeting_place, :meeting_time, :content, presence: true
	mount_uploader :image, ImageUploader
end
