class StaticPagesController < ApplicationController

  def index
    @home_message = PageInformation.find_by(location: "home").content  if PageInformation.find_by(location: 'home').present?
  end

  def about
    @about_message = PageInformation.find_by(location: "about").content  if PageInformation.find_by(location: 'about').present?
  end

end
