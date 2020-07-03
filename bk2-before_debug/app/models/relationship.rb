class Relationship < ApplicationRecord
    belong_to :user
    belong_to :follow, class_name: 'User'
    validates :user_id, presence: true
    validates :follow_id, presence: true
end
