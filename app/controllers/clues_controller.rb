class CluesController < ApplicationController

  def show
    @my_hash1 = Location.get_tree(params[:id])
    @index = params[:id]
    respond_to do |format|
      format.html { render :'show'}
      format.json { render json: @my_hash1}
    end
  end

end
