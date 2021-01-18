class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.page(params[:page]).per(5).reverse_order
      render :index
    end
  end

  def index
    @genres = Genre.page(params[:page]).per(5).reverse_order
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
