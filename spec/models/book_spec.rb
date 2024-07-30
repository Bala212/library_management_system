require 'rails_helper'

RSpec.describe Book, type: :model do
  it { expect(Book.reflect_on_association(:library).macro).to eq(:belongs_to) }
  it { expect(Book.reflect_on_association(:students).macro).to eq(:has_and_belongs_to_many) }
end
