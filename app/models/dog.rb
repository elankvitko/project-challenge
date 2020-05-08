class Dog < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :likes, dependent: :destroy

  # ActiveStorage
  has_many_attached :images

  # Default Pagination Rule (will_paginate)
  self.per_page = 5

  # Methods

  # liked? checks for whether or not the user in question has already liked the dog
  def liked?(user_id)
    Like.where(user_id: user_id, dog_id: self.id).exists?
  end
end
