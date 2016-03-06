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
      race = Race.find params[:id]
      render json: race, status: :ok
    end
  end

  def update
    Rails.logger.debug("method=#{request.method}")
    race = Race.find(params[:id])
    race.update race_params
    render json: race, status: :ok
  end

  def create
    if !request.accept || request.accept == "*/*"
      render plain: "#{params[:race][:name]}", status: :created
    else
      race = Race.create race_params
      render plain: race.name, status: :created
    end
  end

  def destroy
    Race.find(params[:id]).destroy
    render nothing: true, status: :no_content
  end

  private
  def race_params
    params.require(:race).permit(:name, :date)
  end

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
  end
end
