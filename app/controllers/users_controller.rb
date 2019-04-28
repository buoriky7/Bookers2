class UsersController < ApplicationController
    before_action :authenticate_user!

   def index
   	# @books = post.all
   	@book = Book.new
    @user = current_user
    @users = User.all


  end

  def create
   	@user = User.new(user_params)


     redirect_to user_path(@user.id)

   end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end



  def new
  end

  def update
        @user = User.find(params[:id])


        if @user.update(user_params)
           redirect_to user_path(@user.id)
           flash[:notice] = "successfully"
        else
          render :edit
        end
  end








  def edit
   @user = User.find(params[:id])


  end



  private


  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
