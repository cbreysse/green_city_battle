class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :info
  def info; end
end
