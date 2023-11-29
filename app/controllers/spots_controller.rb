class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  reverse_geocoded_by :latitude, :longitude

  def index; end
end
