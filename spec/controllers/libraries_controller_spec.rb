require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it 'assigns @libraries' do
      library = Library.create(valid_library)
      expect(assigns(:libraries)).to eq([library])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    before do
      get :new
    end

    it 'assigns @library' do
      expect(assigns(:library)).to be_a_new(Library)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'when library is valid' do
      it 'record count should increase by 1' do
        expect{
          post :create, params: { library: valid_library }
        }.to change(Library, :count).by(1)
      end

      it 'redirects to list of library' do
        post :create, params: { library: valid_library }
        expect(response).to redirect_to(libraries_path)
      end

      it 'accepts and responds html of single library page' do
        post :create, params: { library: valid_library }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status created' do
        post :create, params: { library: valid_library }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when library is invalid' do
      it 'record count should change by 0' do
        expect{
          post :create, params: { library: invalid_library }
        }.to change(Library,:count).by(0)
      end

      it 'redirects to new library page' do
        post :create, params: { library: invalid_library }
        expect(response).to render_template 'new'
      end

      it 'accepts and responds html page of edit' do
        post :create, params: { library: invalid_library }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        post :create, params: { library: invalid_library }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH update' do
    before do
      @library = Library.create(valid_library)
    end
    context 'when library is updated successfully' do
      it 'record count should change by 0' do
        expect{
          patch :update, params: { library: valid_library_update, id: @library.to_param.to_i }
        }.to change(Library,:count).by(0)
      end

      it 'redirects to updated library' do
        patch :update, params: { library: valid_library_update, id: @library.to_param.to_i }
        expect(response).to redirect_to(libraries_path)
      end

      it 'accepts and responds html of updated library page' do
        patch :update, params: { library: valid_library_update, id: @library.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status found' do
        patch :update, params: { library: valid_library_update, id: @library.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when library is invalid' do
      before do
        @library = Library.create(valid_library)
      end
      it 'record count should change by 0' do
        expect{
          patch :update, params: { library: invalid_library_update, id: @library.to_param.to_i }
        }.to change(Library, :count).by(0)
      end

      it 'redirects to edit library page' do
        patch :update, params: { library: invalid_library_update, id: @library.to_param.to_i }
        expect(response).to render_template('edit')
      end

      it 'accepts and responds html page of edit' do
        patch :update, params: { library: invalid_library_update, id: @library.to_param.to_i }
        expect(response.content_type).to eq ("text/html; charset=utf-8")
        expect(response.media_type).to eq ("text/html")
      end

      it 'should have status unprocessable_entity' do
        patch :update, params: { library: invalid_library_update, id: @library.to_param.to_i }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when library is deleted successfully' do
      before do
        @library = Library.create(valid_library)
      end

      it 'record count should decrease by 1' do
        expect{
          delete :destroy, params: { library: valid_library, id: @library.to_param.to_i }
        }.to change(Library, :count).by(-1)
      end

      it 'redirects to index page' do
        delete :destroy, params: { library: valid_library, id: @library.to_param.to_i }
        expect(response).to redirect_to(libraries_path)
      end

      it 'should have status found' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  def invalid_library
    {
      name: nil,
    }
  end

  def valid_library
    {
      name: "name",
    }
  end

  def valid_library_update
    {
      name: "updated name",
    }
  end

  def invalid_library_update
    {
      name: nil,
    }
  end
end
