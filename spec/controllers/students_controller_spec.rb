require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it 'assigns @studens' do
      student = Student.create(valid_student)
      expect(assigns(:students)).to eq([student])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    before do
      @student = Student.create(valid_student)
      get :show, params: { id: @student.id}
    end

    it 'assigns @student' do
      expect(assigns(:student)).to eq(@student)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    before do
      get :new
    end

    it 'assigns @student' do
      expect(assigns(:student)).to be_a_new(Student)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'when student is valid' do
      it 'record count should increase by 1' do
        expect{
          post :create, params: { student: valid_student }
        }.to change(Student, :count).by(1)
      end

      it 'redirects to created student' do
        post :create, params: { student: valid_student }
        expect(response).to redirect_to(Student.last)
      end

      it 'accepts and responds html of single student page' do
        post :create, params: { student: valid_student }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status created' do
        post :create, params: { student: valid_student }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when student is invalid' do
      it 'record count should change by 0' do
        expect{
          post :create, params: { student: invalid_student }
        }.to change(Student,:count).by(0)
      end

      it 'redirects to new student page' do
        post :create, params: { student: invalid_student }
        expect(response).to render_template 'new'
      end

      it 'accepts and responds html page of edit' do
        post :create, params: { student: invalid_student }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        post :create, params: { student: invalid_student }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH update' do
    before do
      @student = Student.create(valid_student)
    end
    context 'when student is updated successfully' do
      it 'record count should change by 0' do
        expect{
          patch :update, params: { student: valid_student_update, id: @student.to_param.to_i }
        }.to change(Student,:count).by(0)
      end

      it 'redirects to updated student' do
        patch :update, params: { student: valid_student_update, id: @student.to_param.to_i }
        expect(response).to redirect_to(student_path(@student))
      end

      it 'accepts and responds html of updated student page' do
        patch :update, params: { student: valid_student_update, id: @student.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status found' do
        patch :update, params: { student: valid_student_update, id: @student.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when student is invalid' do
      before do
        @student = Student.create(valid_student)
      end
      it 'record count should change by 0' do
        expect{
          patch :update, params: { student: invalid_student_update, id: @student.to_param.to_i }
        }.to change(Student, :count).by(0)
      end

      it 'redirects to edit student page' do
        patch :update, params: { student: invalid_student_update, id: @student.to_param.to_i }
        expect(response).to render_template('edit')
      end

      it 'accepts and responds html page of edit' do
        patch :update, params: { student: invalid_student_update, id: @student.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        patch :update, params: { student: invalid_student_update, id: @student.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when student is deleted successfully' do
      before do
        @student = Student.create(valid_student)
      end

      it 'record count should decrease by 1' do
        expect{
          delete :destroy, params: { student: valid_student, id: @student.to_param.to_i }
        }.to change(Student, :count).by(-1)
      end

      it 'redirects to index page' do
        delete :destroy, params: { student: valid_student, id: @student.to_param.to_i }
        expect(response).to redirect_to(students_path)
      end

      it 'should have status found' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  def invalid_student
    {
      # name: "name",
      email: "name@gmail.com",
      address: "address",
      phone: 1234567891,
    }
  end

  def valid_student
    {
      name: "name",
      email: "name@gmail.com",
      address: "address",
      phone: 1234567891
    }
  end

  def valid_student_update
    {
      name: "updated name",
      email: "name@gmail.com",
      address: "updated address",
      phone: 1234567891
    }
  end

  def invalid_student_update
    {
      name: nil,
      email: "name@gmail.com",
      address: "address",
      phone: 1234567891
    }
  end
end
