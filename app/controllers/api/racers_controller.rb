class Api::RacersController < ApplicationController
  def index
    if !request.accept || request.accept == "*/*"
      # only fire when content type is not specified
      render plain: "/api/racers"
    else

    end
  end

  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:id]}"
    else

    end
  end
end
