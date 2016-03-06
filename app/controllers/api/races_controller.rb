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
      render plain: :nothing, status: :ok
    else

    end
  end
end
