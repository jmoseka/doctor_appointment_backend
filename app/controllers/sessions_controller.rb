class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = issue_token(@user)
      render json: { user: UserSerializer.new(@user), jwt: token }
    else
      render json: { error: 'Invalid username or password' }, status: 401
    end
  end

  def show
    if logged_in?
      render json: current_user
    else
        render json: { error: 'User is not logged in/could not be found.' } # rubocop:disable Layout/IndentationWidth
    end
  end
end