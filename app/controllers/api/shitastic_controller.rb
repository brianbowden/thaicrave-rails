class Api::ShitasticController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!

  def index
  	render :json=>{:success=>true, :message=>"This thing works."}, :status=>200
  end
end
