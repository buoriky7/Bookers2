class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end


 def index
   	@book = Book.new
    @books = Book.all
    @user = @book.user
 end

 def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
  	@book.save
         if @book.save(book_params)
           redirect_to book_path(@book.id)
           flash[:notice] = "successfully"
        else
          render :index
        end

 end


  def update
        @book = Book.find(params[:id])
         if @book.update(book_params)
           redirect_to user_path(current_user)
           flash[:notice] = "successfully"
        else
          render :edit
        end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

 
  private

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
       redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end

