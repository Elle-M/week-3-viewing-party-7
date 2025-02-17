class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    if !current_user
      flash[:notice] = "You must be logged in to view this page."
      redirect_to root_path
    else 
      @user = User.find(params[:id])
    end
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form

  end 

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      if user.user?
      redirect_to "/users/#{user.id}"
      end
    else 
      flash[:error] = "Bad Credentials, try again."
      redirect_to "/login" 
    end 
  end

  def logout_user
    session.delete(:user_id)
    flash[:notice] = "You are not logged in."
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end 
end 