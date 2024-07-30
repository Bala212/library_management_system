class Library < ApplicationRecord
  has_many :books
  validates :name, presence: true
end
