class BooksController < ApplicationController
before_action :authenticate_user!
before_action :check_user, only: [:edit, :update, :destroy]

    def create
	    @user = User.find(current_user.id)
	    @book2 =Book.new
	    @book = Book.new(book_params)
	    @book.user_id = current_user.id
		if @book.save
           flash[:notice] = "Book was successfully created"
		   redirect_to book_path(@book.id)#bookモデルのshowページへ移動する
        else
           @books =Book.all
           render 'index'
        end
    end

    def show
	    @book2 =Book.new
	    @book =Book.find(params[:id])
        @user =@book.user
    end

    def edit
    	@book =Book.find(params[:id])
    end
    def update
        @book = Book.find(params[:id])
    if  @book.update(book_params)
        flash[:notice] = "Book was successfully updated"
        redirect_to book_path(@book)
    else
        render 'edit'
    end
    end
    def index
        @user = User.find(current_user.id)
        @books =Book.all
        @book2= Book.new
        @book = Book.new
    end

    def destroy
    	@book =Book.find(params[:id])
    	@book.destroy
    	redirect_to books_path
    end
    private

    def book_params
        params.require(:book).permit(:title, :body)
    end
    def check_user
        book=Book.find(params[:id])
        @user=book.user
        if current_user.id !=@user.id
        redirect_to books_path
    end
    end
end