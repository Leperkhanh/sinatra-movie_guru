class MoviesController < ApplicationController

  # GET: /movies
  get "/movies" do
    @movies = Movie.all
    flash[:warning] = "Hooray, Flash is working!"
    erb :"/movies/index.html"
  end

  # GET: /movies/new
  get "/movies/new" do
    if current_user.is_admin?
      erb :"/movies/new.html"
    else
      flash[:error] = "You do not have permission to create movies"
      redirect "/movies"
  end

  # POST: /movies
  post "/movies" do
    if current_user.is_admin?
    @movie = Movie.create(params[:movie])
    redirect "/movies"
    else
      flash[:error] = "You do not have permission to create movies"
      redirect "/movies"
    end
  end

  # GET: /movies/5
  get "/movies/:id" do
    @movie = Movie.find_by_id(params[:id])
    if @movie
      @users = @movie.users
      @reviews = @movie.reviews 
      erb :"/movies/show.html"
    else
      flash[:error] = "Sorry we cannot currently find this movie!"
      redirect "/movies"   
    end
  end

  # GET: /movies/5/edit
  get "/movies/:id/edit" do
    if current_user.is_admin?
      @movie = Movie.find_by_id(params[:id])
      erb :"/movies/edit.html"
    else
      flash[:error] = "You do not have permission to edit movies"
      redirect "/movies"
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    if current_user.is_admin?
      @movie = Movie.find_by_id(params[:id])
      @movie.title = params[:movie][:title]
      @movie.summary = params[:movie][:summary]
      @movie.save
      if @movie.save
        flash[:message] = "You have successfully updated the movie"
        redirect to "/movies/#{@movie.id}"
      else
        flash[:error] = "Movie was unsuccessfully saved"
        redirect "/movies/#{@movie.id}"  
      end  
    end
  end


  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    if current_user.is_admin?
      @movie = Movie.find_by_id(params[:id])
        @movie.delete
        redirect '/movies'
      else
        redirect '/movies'
    end
    flash[:error] = "You do not have pemission to delete movies"
    redirect '/login'
  end

end  
