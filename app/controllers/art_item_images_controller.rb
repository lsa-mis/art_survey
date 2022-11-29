class ArtItemImagesController < ApplicationController
  before_action :access_authorized!

  layout false

  before_action :set_art_item, only: :index

  def index
  end

  private

  def set_art_item
    @art_item = ArtItem.find(params[:art_item_id])
  end
end