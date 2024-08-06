require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  describe 'GET /index' do
    it 'assigns @studens' do
      student = Student.create(valid_student)
      get '/students'
      expect(assigns(:students)).to eq([student])
    end

    it 'renders the index template' do
      get '/students'
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      get '/students'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    before do
      @student = Student.create(valid_student)
      get student_url(@student)
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

  describe 'GET /new' do
    before do
      get new_student_url
    end

    it 'assigns @student' do
      expect(assigns(:student)).to be_a_new(Student)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST /create' do
    context 'when student is valid' do
      it 'should create the student' do
        post '/students', params: { student: valid_student }
        expect(assigns[:student].name).to eq("name")
      end

      it 'record count should increase by 1' do
        expect{
          post students_url, params: { student: valid_student }
        }.to change(Student, :count).by(1)
      end

      it 'redirects to created student' do
        post students_url, params: { student: valid_student }
        expect(response).to redirect_to(Student.last)
      end

      it 'accepts and responds html of single student page' do
        post students_url, params: { student: valid_student }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status created' do
        post students_url, params: { student: valid_student }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when student is invalid' do
      it 'record count should change by 0' do
        expect{
          post students_url, params: { student: invalid_student }
        }.to change(Student,:count).by(0)
      end

      it 'redirects to new student page' do
        post students_url, params: { student: invalid_student }
        expect(response).to render_template 'new'
      end

      it 'accepts and responds html page of edit' do
        post students_url, params: { student: invalid_student }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        post students_url, params: { student: invalid_student }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    before do
      @student = Student.create(valid_student)
    end
    context 'when student is updated successfully' do
      it 'should update the student' do
        patch student_url(@student), params: { student: valid_student_update }
        @student.reload
        expect(@student.name).to eq("updated name")
      end

      it 'record count should change by 0' do
        expect{
          patch student_url(@student), params: { student: valid_student_update }
        }.to change(Student,:count).by(0)
      end

      it 'redirects to updated student' do
        patch student_url(@student), params: { student: valid_student_update }
        expect(response).to redirect_to(student_path(@student))
      end

      it 'accepts and responds html of updated student page' do
        patch student_url(@student), params: { student: valid_student_update }
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status found' do
        patch student_url(@student), params: { student: valid_student_update }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when student is invalid' do
      before do
        @student = Student.create(valid_student)
      end
      it 'record count should change by 0' do
        expect{
          patch student_url(@student), params: { student: invalid_student_update }
        }.to change(Student, :count).by(0)
      end

      it 'redirects to edit student page' do
        patch student_url(@student), params: { student: invalid_student_update }
        expect(response).to render_template('edit')
      end

      it 'accepts and responds html page of edit' do
        patch student_url(@student), params: { student: invalid_student_update }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        patch student_url(@student), params: { student: invalid_student_update }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when student is deleted successfully' do
      before do
        @student = Student.create(valid_student)
      end

      it 'record count should decrease by 1' do
        expect{
          delete student_url(@student)
        }.to change(Student, :count).by(-1)
      end

      it 'redirects to index page' do
        delete student_url(@student)
        expect(response).to redirect_to(students_path)
      end

      it 'should have status found' do
        delete student_url(@student)
        expect(response).to have_http_status(:found)
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
      name: "updated name"
    }
  end

  def invalid_student_update
    {
      name: nil,
    }
  end
end
