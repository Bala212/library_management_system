require 'rails_helper'

RSpec.describe Library, type: :model do

  # IT IS DEPRICATED
  # it { Library.reflect_on_association(:books).macro.should eq(:has_many) }

  context 'associations' do
    it { expect(Library.reflect_on_association(:books).macro).to eq(:has_many) }
  end

  context 'validations' do
    context 'when name is empty' do
      before do
        @library_without_name = Library.create
      end
      it 'prints message' do
        expect(@library_without_name.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context 'when all attributes are valid' do
      it 'record count should increase by one' do
        expect { Library.create(name: 'name') }.to change(Library, :count).by(1)
      end
    end
  end
end
