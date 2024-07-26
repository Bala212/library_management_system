require 'rails_helper'

RSpec.describe Book, type: :model do
  # it { should belongs_to(:library) }
  # it { should belongs_to(:student) }

  it { expect(Book.reflect_on_association(:library).macro).to eq(:belongs_to) }
  it { expect(Book.reflect_on_association(:student).macro).to eq(:belongs_to) }

  
end
