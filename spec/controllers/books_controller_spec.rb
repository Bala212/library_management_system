require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    @lib = Library.create(name: 'lib')
  end
  describe 'GET index' do
    before do
      get :index
    end

    it 'assigns @books' do
      book = Book.create(valid_book)
      expect(assigns(:books)).to eq([book])
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
      @book = Book.create(valid_book)
      get :show, params: { id: @book.id }
    end

    it 'assigns @book' do
      expect(assigns(:book)).to eq(@book)
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

    it 'assigns @book' do
      expect(assigns(:book)).to be_a_new(Book)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'when book is valid' do
      it 'record count should increase by 1' do
        expect{
          post :create, params: { book: valid_book }
        }.to change(Book, :count).by(1)
      end

      it 'redirects to created book' do
        post :create, params: { book: valid_book }
        expect(response).to redirect_to(Book.last)
      end

      it 'accepts and responds html of single book page' do
        post :create, params: { book: valid_book }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status created' do
        post :create, params: { book: valid_book }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when book is invalid' do
      it 'record count should change by 0' do
        expect{
          post :create, params: { book: invalid_book }
        }.to change(Book,:count).by(0)
      end

      it 'redirects to new book page' do
        post :create, params: { book: invalid_book }
        expect(response).to render_template 'new'
      end

      it 'accepts and responds html page of edit' do
        post :create, params: { book: invalid_book }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        post :create, params: { book: invalid_book }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH update' do
    before do
      @book = Book.create(valid_book)
    end
    context 'when book is updated successfully' do
      it 'record count should change by 0' do
        expect{
          patch :update, params: { book: valid_book_update, id: @book.to_param.to_i }
        }.to change(Book,:count).by(0)
      end

      it 'redirects to updated book' do
        patch :update, params: { book: valid_book_update, id: @book.to_param.to_i }
        expect(response).to redirect_to(book_path(@book))
      end

      it 'accepts and responds html of updated book page' do
        patch :update, params: { book: valid_book_update, id: @book.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status found' do
        patch :update, params: { book: valid_book_update, id: @book.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when book is invalid' do
      before do
        @book = Book.create(valid_book)
      end
      it 'record count should change by 0' do
        expect{
          patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
        }.to change(Book, :count).by(0)
      end

      it 'redirects to edit book page' do
        patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
        expect(response).to render_template('edit')
      end

      it 'accepts and responds html page of edit' do
        patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when book is deleted successfully' do
      before do
        @book = Book.create(valid_book)
      end

      it 'record count should decrease by 1' do
        expect{
          delete :destroy, params: { book: valid_book, id: @book.to_param.to_i }
        }.to change(Book, :count).by(-1)
      end

      it 'redirects to index page' do
        delete :destroy, params: { book: valid_book, id: @book.to_param.to_i }
        expect(response).to redirect_to(books_path)
      end

      it 'should have status found' do
        expect(response).to have_http_status(:ok)
      end
    end

    # context 'when book is invalid' do
    #   before do
    #     @book = Book.create(valid_book)
    #   end
    #   it 'record count should change by 0' do
    #     expect(Book.destroy(id: @book.id + 1)).to change(Book,:count).by(0)
    #   end

    #   it 'redirects to edit book page' do
    #     patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
    #     expect(response).to redirect_to edit_book_path(@book)
    #   end

    #   it 'accepts and responds html page of edit' do
    #     patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
    #     expect(response.content_type).to eq ("text/html; charset=utf-8")
    #     expect(response.media_type).to eq ("text/html")
    #   end

    #   it 'should have status unprocessable_entity' do
    #     patch :update, params: { book: invalid_book_update, id: @book.to_param.to_i }
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end
  end

  def invalid_book
    {
      # title: "title",
      author: "asdf",
      genre: "asdf",
      isbn: 123,
    }
  end

  def valid_book
    {
      title: "title",
      author: "asdf",
      genre: "asdf",
      isbn: 123,
      library_id: @lib.id
    }
  end

  def valid_book_update
    {
      title: "update title",
    }
  end

  def invalid_book_update
    {
      title: nil
    }
  end
end
