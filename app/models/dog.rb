class Dog < ApplicationRecord
  # Relationships
  belongs_to :user

  # ActiveStorage
  has_many_attached :images

  # Default Pagination Rule (will_paginate)
  self.per_page = 5
end
