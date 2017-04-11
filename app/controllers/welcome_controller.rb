class WelcomeController < ApplicationController
  def index
    flash[:notice] = "home"
  end
end
