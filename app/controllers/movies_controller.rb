class MoviesController < ApplicationController

  def index   #checks sessions params so filter can work and updates session when params are passed in, 
    #makes sure arrors are eliminated
    @all_ratings = Movie.ratings
    if params[:ratings] == nil and session[:ratings] == nil
      session[:ratings] = @all_ratings
    elsif params[:ratings] != nil
      session[:ratings] = params[:ratings]
    end      
    if params[:sort] == nil and session[:sort] == nil
      session[:sort] = "id"
    elsif params[:sort] != nil
      session[:sort] = params[:sort]
    end 

    @movies = Movie.sort_by(session[:ratings], session[:sort])

  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end