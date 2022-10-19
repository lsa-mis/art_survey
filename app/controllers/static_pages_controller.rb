class StaticPagesController < ApplicationController

  def index
    @home_message = PageInformation.find_by(location: "home").content
  end

  def about
    @about_message = PageInformation.find_by(location: "about").content
  end

end
