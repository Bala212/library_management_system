class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    # debugger
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_path(@student) }
        # format.json { render json: @book }
      else
        format.html { render   'new', status: :unprocessable_entity }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_path(@student) }
        # format.json { render json: @book }
      else
        # debugger
        format.html { render 'edit', status: :found }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @student.destroy
        # debugger
        format.html { redirect_to students_path, status: :found }
        # format.json { render json: @book }
      else
        format.html { redirect_to student_path(@student), status: :unprocessable_entity }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :address, :phone)
  end
end
