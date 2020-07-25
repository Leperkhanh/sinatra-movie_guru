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
    @movie = Movie.find(params[:id])
    @users = @movie.users
    @reviews = @movie.reviews
    erb :"/movies/show.html"
  end

  # GET: /movies/5/edit
  get "/movies/:id/edit" do
    erb :"/movies/edit.html"
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    redirect "/movies/:id"
  end

  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    redirect "/movies"
  end
end
