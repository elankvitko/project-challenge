class Dog < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :likes, dependent: :destroy

  # ActiveStorage
  has_many_attached :images

  # Validations
  validates :name, :user_id, presence: true

  # Default Pagination Rule (will_paginate)
  self.per_page = 5

  # Scopes
  # This scope allows for all kinds of sorting. You can pass in 1 hour or 3 days
  scope :order_by_likes_in_last, -> (num, timeframe) {
    joins(:likes).
    where("likes.created_at >= ?", Time.now - num.to_i.send(timeframe)).
    group('dogs.id').
    order(Arel.sql("count(likes.id) DESC, created_at DESC"))
  }

  # Methods

  # liked? checks for whether or not the user in question has already liked the dog
  def liked?(user_id)
    Like.where(user_id: user_id, dog_id: self.id).exists?
  end
end
