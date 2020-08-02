class MoviesController < ApplicationController

  # GET: /movies
  get "/movies" do
    @movies = Movie.all
    flash[:warning] = "Hooray, Flash is working!"
    erb :"/movies/index.html"
  end

  # GET: /movies/new
  get "/movies/new" do
    erb :"/movies/new.html"
  end

  # POST: /movies
  post "/movies" do
    @movie = Movie.create(params[:movie])
    redirect "/movies"
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
    @movie = Movie.find_by_id(params[:id])
    erb :"/movies/edit.html"
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    if params[:movie] == ""
      redirect to "/movies/#{params[:id]}/edit"
    else
      @movie = Movie.find_by_id(params[:id])
      @movie.title = params[:movie][:title]
      @movie.summary = params[:movie][:summary]
      @movie.save
      redirect "/movies/#{@movie.id}"
    end
  end

  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
        @movie.delete
        redirect '/movies'
      else
        redirect '/movies'
      end
        redirect '/login'
  end
end
