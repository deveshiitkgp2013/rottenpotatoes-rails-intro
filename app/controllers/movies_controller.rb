class MoviesController < ApplicationController
  @ratings_to_show = []


  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    
    @movies = Movie.all
    
    
    
    
    if params.include? :ratings
      selected_ratings = params[:ratings].keys
    else
     selected_ratings = session[:ratings].keys 
    end
    if !selected_ratings.nil?
        @movies = Movie.with_ratings(selected_ratings)
    end
    
    if params.include? :sort
      sort = params[:sort]
    else
      sort = session[:sort]
    end
    if 'title' == sort
      if !selected_ratings.nil?
        @movies = Movie.order_and_ratings(selected_ratings,:title)
      else
        @movies = Movie.order(:title)
      end
    elsif 'date' == sort
      if !selected_ratings.nil?
        @movies = Movie.order_and_ratings(selected_ratings,:release_date)
      else
        @movies = Movie.order(:release_date)
      end
     
    end
    
    session[:sort] = params[:sort]
    session[:ratings] = params[:ratings]
    @redirect_params = params
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
