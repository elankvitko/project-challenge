class Like < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :dog
end
