class Api::RacesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    if !request.accept || request.accept == "*/*"
      # only fire when content type is not specified
      offset = params[:offset]
      limit = params[:limit]
      render plain: "/api/races, offset=[#{offset}], limit=[#{limit}]"
    else

    end
  end

  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:id]}"
    else

    end
  end

  def create
    if !request.accept || request.accept == "*/*"
      render plain: "#{params[:race][:name]}", status: :created
    else
      race = Race.create(race_params)
      render plain: race.name, status: :created
    end
  end

  private
  def race_params
    params.require(:race).permit(:name, :date)
  end
end
