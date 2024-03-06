class PlacesController < ApplicationController

  def index
    @places = Place.all
    respond_to do|format|
      format.html
      format.json {render :json => @entries }
    end
  end

  def show
   @user = User.find_by({"id" => params["user_id"]})
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["id"] })
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    existing_place = Place.find_by("name" => @place["name"])
    if existing_place
      flash[:notice] = "A place with the name #{@place["name"]} already exists."
      redirect_to "/places/new"

    elsif @place["name"].present?
    @place.save
      redirect_to "/places"
    else 
    flash[:notice] = "Please enter the name of a new place!"
    redirect_to "/places/new"
    end
  end
end
