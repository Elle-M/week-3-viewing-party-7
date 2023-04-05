class VisitorMoviesController < ApplicationController
  def show
    if current_user
      redirect_to dashboard_path
    else
      @movie = MovieFacade.movie_details(params[:id])
    end
  end
end