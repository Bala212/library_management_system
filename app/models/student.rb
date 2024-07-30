class Student < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, numericality: true, length: { minimum: 10 }
  validates :email, presence: true,format: { with: /\A(\S+)@(.+)\.(\S+)\z/}

  has_and_belongs_to_many :books
end
