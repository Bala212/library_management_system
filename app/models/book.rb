class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  belongs_to :library
  has_and_belongs_to_many :students
end
