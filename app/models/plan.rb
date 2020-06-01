class Plan < ApplicationRecord
	belongs_to :user
	validates :title, :date, :place, :meeting_place, :meeting_time, :content, presence: true
end
