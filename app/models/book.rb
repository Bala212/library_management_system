class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  belongs_to :library, optional: true
  belongs_to :student, optional: true
end
