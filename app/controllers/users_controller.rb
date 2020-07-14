class UsersController < ApplicationController
before_action :authenticate_user!, except: [:top, :about]
before_action :check_user2, only: [:edit, :update, :destroy]

	def top
	end
	def about
	end

	def index
		@user = User.find(current_user.id)
        @users =User.all
        @book2= Book.new
	end
	def show
	    @user = User.find(params[:id])
	    @book = Book.new
	    @books =@user.books

	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		flash[:notice] = "User was successfully updated"
		redirect_to user_path(current_user.id)
		else
		render 'edit'
	end
	end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    def check_user2
        @user=User.find(params[:id])
        if current_user.id !=@user.id
        redirect_to user_path(current_user)
    end
    end
end
