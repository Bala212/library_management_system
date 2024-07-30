class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_path(@book) }
        # format.json { render json: @book }
      else
        format.html { render 'new', status: :unprocessable_entity }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_path(@book) }
        # format.json { render json: @book }
      else
          format.html { render 'edit', status: :found }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @book.destroy
        format.html { redirect_to books_path }
        # format.json { render json: @book }
      else
        format.html { redirect_to book_path(@book), status: :unprocessable_entity }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :library_id)
  end
end
