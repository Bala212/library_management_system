class LibrariesController < ApplicationController
  before_action :set_library, only: [:edit, :update]

  def index
    @libraries = Library.all
  end

  def new
    @library = Library.new
  end

  def create
    @library = Library.new(library_params)
    # debugger
    respond_to do |format|
      if @library.save
        format.html { redirect_to libraries_path }
      else
        format.html { render 'new', status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to libraries_path }
      else
        format.html { render 'edit', status: :found }
      end
    end
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.require(:library).permit(:name)
  end
end
