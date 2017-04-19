class Account::JobsController < ApplicationController
  before_action :authenticate_user!

  def index
      @jobs = Job.recent.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @job = Job.find(params[:id])
  end
end
