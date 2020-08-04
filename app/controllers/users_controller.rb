class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    @users = User.all
    erb :"/users/index.html"
  end

  get "/users/login" do
    if !logged_in? 
      erb :"/users/login.html"
    else
      flash[:message] = "You are already logged in"  
      redirect "/users/show"  
    end  
  end

  post "/users/login" do
    user = User.find_by(:username => params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome back, #{user.username}"
      redirect "/users/show"
    else
      flash[:error] = "Login failed. Please try again or create a new account"
      redirect "/users/login"
    end
end


  # GET: /users/new
  get "/users/new" do
    if !logged_in?
      erb :"/users/new.html"
    else
      flash[:error] = "You are already logged in"
      redirect "/users/show" 
    end   
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
      flash[:message] = "You have successfully logged out"
      redirect to 'users/login'
    else
      flash[:error] = "You must be logged in first"
      redirect to '/'
    end
  end

  # POST: /users
  post "/users" do
    @user = User.create(params[:user])
    flash[:message] = "Account created! Please Log In"
    redirect "/users/login"
  end

  # GET: /users/5
  get "/users/:id" do
    if logged_in?
      @user = current_user
      @reviews = @user.reviews
      @review = @user.reviews.first
      erb :"/users/show.html"
    else  
      redirect "/users/login"
    end    
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user.id == current_user.id
        erb :"/users/edit.html"
      else  
        flash[:error] = "You do not have permission to edit this account"
      end      
    else  
      flash[:error] = "You do not have permission to edit this account"
      redirect "/"
    end    
  end

  # PATCH: /users/5
  patch "/users/:id" do
    if logged_in?
      @user = User.find_by_id(params[:id])
        if @user.id == current_user.id
          @user.username = params[:user][:username]
          @user.email = params[:user][:email]
          @user.password = params[:user][:password]
          @user.save
          if @user.save
            flash[:message] = "Your account has been updated"
            redirect "/users/:id"
          else
            flash[:error] = "Your acccunt was not updated"
            redirect "/users/#{@user.id}/edit"      
          end
        else
          flash[:error] = "You do not have permission to edit this account"
          redirect "/"    
        end
    else    
      redirect "/users/:id"
    end
  end  

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    if current_user.is_admin?
      @user = User.find_by_id(params[:id])
      @user.destroy
      flash[:message] = "You have successfully deleted the account"
      redirect '/users'
    else
      flash[:error] = "You do not have pemission to delete users"
      redirect '/users'
    end
  end

end
