class ArtItemImagesController < ApplicationController
  layout false

  before_action :set_art_item, only: :index

  def index
  end

  private

  def set_art_item
    @art_item = ArtItem.find(params[:art_item_id])
  end
end