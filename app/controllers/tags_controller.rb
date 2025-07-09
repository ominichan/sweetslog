class TagsController < ApplicationController
  def autocomplete
    @tags = Tag.where("name like ?", "%#{params[:name]}%")
    respond_to do |format|
      format.js
    end
  end
end
