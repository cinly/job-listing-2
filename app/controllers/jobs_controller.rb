class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :find_job_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
            when 'by_upper_bound'
              Job.published.high.paginate(:page => params[:page], :per_page => 5)
            when 'by_lower_bound'
              Job.published.low.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  def show
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to jobs_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job.user = current_user
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end



  private

  def find_job_by_id
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end

end
