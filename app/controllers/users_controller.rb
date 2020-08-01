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
      redirect "/users/show" 
    end   
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
      flash[:message] = "You have successfully logged out"
      redirect to 'users/login'
    else
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
      erb :"/users/show.html"
    else  
      redirect "/users/login"
    end    
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
