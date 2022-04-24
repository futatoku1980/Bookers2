class BooksController < ApplicationController
   before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
    @books = Book.all
    @users = User.all
     render :index
    end 
  end 
  
  def show
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
    @book = Book.new
  end 
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end 
  
  def edit
    @book = Book.find(params[:id])
    #@book.update(book_params)
  end 
  
  def destroy
    @book = Book.find(params[:id])
    @book.delete
    flash[:notice] = "You have destroyed book successfully."
    redirect_to books_path
  end 
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated  successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end 
  end 
  
  private
  def book_params
     params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
   book = Book.find(params[:id])
   user = User.find(book.user_id)
   if current_user.id != user.id
   redirect_to books_path
   end
  end 
end