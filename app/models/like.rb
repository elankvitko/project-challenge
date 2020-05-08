class Like < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :dog

  # Validations
  validates :user_id, :dog_id, presence: true
end
