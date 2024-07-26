require 'rails_helper'

RSpec.describe Student, type: :model do

  context 'associations' do
    it { expect(Student.reflect_on_association(:books).macro).to eq(:has_many) }
  end

  context 'validations' do
    context 'when name is empty' do
      before do
        @student_without_name = Student.create(address: 'add', phone: 9911991199, email: 'a@gmail.com')
      end

      it 'prints message' do
        expect(@student_without_name.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context 'when address is empty' do
      before do
        @student_without_address = Student.create(name: 'name', phone: 9911991199, email: 'a@gmail.com')
      end
      it 'prints message' do
        expect(@student_without_address.errors.full_messages).to eq(["Address can't be blank"])
      end
    end

    context 'when phone is empty' do
      before do
        @student_without_phone = Student.create(address: 'add', name: 'name', email: 'a@gmail.com')
      end
      it 'prints message' do
        expect(@student_without_phone.errors.full_messages).to eq(["Phone can't be blank", "Phone is not a number", "Phone is too short (minimum is 10 characters)"])
      end
    end

    context 'when phone is short' do
      before do
        @student_without_phone = Student.create(email: 'a@gmail.com', address: 'add', phone: 2222, name: 'name')
      end
      it 'prints message' do
        expect(@student_without_phone.errors.full_messages).to eq(["Phone is too short (minimum is 10 characters)"])
      end
    end

    context 'when email is empty' do
      before do
        @student_without_email = Student.create(address: 'add', phone: 9911991199, name: 'name')
      end
      it 'prints message' do
        expect(@student_without_email.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
      end
    end

    context 'when email is invalid' do
      before do
        @student_with_invalid_email = Student.create(email: '@gmail.com', address: 'add', phone: '1111111111', name: 'name')
      end
      it 'prints message' do
        expect(@student_with_invalid_email.errors.full_messages).to eq(["Email is invalid"])
      end
    end

    context 'when all attributes are valid' do
      it 'record count should increase by one' do
        expect { Student.create(email: 'a@gmail.com', address: 'add', phone: 9911991199, name: 'name') }.to change(Student, :count).by(1)
      end
    end
  end
end
