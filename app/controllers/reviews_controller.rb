class ReviewsController < ApplicationController

  # GET: /reviews
  get "/reviews" do
    @reviews = Review.all
    erb :"/reviews/index.html"
  end

  # GET: /reviews/new
  get "/reviews/new" do
    @movies = Movie.all
    erb :"/reviews/new.html"
  end

  # POST: /reviews
  post "/reviews" do
    if logged_in?
      @movie = Movie.find_by(:title => params[:movie][:title])
      @review = current_user.reviews.build(params[:review])
      @review.movie = @movie
      @review.save
      if @review.save
      flash[:message] = "Your review has been successfully posted"
      redirect "/reviews/#{@review.id}"
      else    
      flash[:error] = "Review creation failed: #{@review.errors.full_messages.to_sentence}"
      redirect "/reviews/new"
      end
    else 
      flash[:error] = "Please login to post a review"
      redirect "/users/login" 
    end
  end

  # GET: /reviews/5
  get "/reviews/:id" do
    @review = Review.find_by_id(params[:id])
    erb :"/reviews/show.html"
  end

  # GET: /reviews/5/edit
  get "/reviews/:id/edit" do
    @review = Review.find_by(params[:id])
    @movies = Movie.all
    erb :"/reviews/edit.html"
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
    if params[:review] == ""
      redirect to "/reviews/#{params[:id]}/edit"
    else
      @review = Review.find_by_id(params[:id])
      @review.rating = params[:review][:rating]
      @review.content = params[:review][:content]
      @review.save
      redirect to "/reviews/#{@review.id}"
    end
    redirect "/reviews/:id"
  end

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review.user_id == current_user.id 
        @review.delete 
        flash[:message] = "Your review has been deleted!"
        redirect "/users/show"
      else
        flash[:error] = "You do not have permission to delete this review"
        redirect "/reviews"  
      end
    else
      flash[:error] = "Please login to delete this review"
      redirect "/users/login"  
    end
  end

end
class ReviewsController < ApplicationController

  # GET: /reviews
  get "/reviews" do
    @reviews = Review.all
    erb :"/reviews/index.html"
  end

  # GET: /reviews/new
  get "/reviews/new" do
    @movies = Movie.all
    erb :"/reviews/new.html"
  end

  # POST: /reviews
  post "/reviews" do
    if logged_in?
      @movie = Movie.find_by(:title => params[:movie][:title])
      @review = current_user.reviews.build(params[:review])
      @review.movie = @movie
      @review.save
      if @review.save
      flash[:message] = "Your review has been successfully posted"
      redirect "/reviews/#{@review.id}"
      else    
      flash[:error] = "Review creation failed: #{@review.errors.full_messages.to_sentence}"
      redirect "/reviews/new"
      end
    else 
      flash[:error] = "Please login to post a review"
      redirect "/users/login" 
    end
  end

  # GET: /reviews/5
  get "/reviews/:id" do
    @review = Review.find_by_id(params[:id])
    erb :"/reviews/show.html"
  end

  # GET: /reviews/5/edit
  get "/reviews/:id/edit" do
    @review = Review.find_by(params[:id])
    @movies = Movie.all
    erb :"/reviews/edit.html"
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
      @review = Review.find_by_id(params[:id])
      if @review.user_id == current_user.id
        @review.rating = params[:review][:rating]
        @review.content = params[:review][:content]
        @review.save
        if @review.save
          redirect to "/reviews/#{@review.id}"
        else
          flash[:error] = "Review was not successfully changed"
          redirect "/reviews/#{params[:id]}/edit"
        end     
      else
        flash[:error] = "You do not have permission to edit this review"   
      end
    redirect "/reviews/:id"
  end

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review.user_id == current_user.id 
        @review.delete 
        flash[:message] = "Your review has been deleted!"
        redirect "/users/show"
      else
        flash[:error] = "You do not have permission to delete this review"
        redirect "/reviews"  
      end
    else
      flash[:error] = "Please login to delete this review"
      redirect "/users/login"  
    end
  end

end
