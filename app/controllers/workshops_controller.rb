class WorkshopsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]
  
  def index
    @workshops = Workshop.all
  end
  
  def show
    @workshop = Workshop.find_by_permalink(params[:id])
    @attendee = @workshop.attendees.new
  end
  
  def new
    @workshop = Workshop.new
  end
  
  def create
    @workshop = Workshop.new(params[:workshop])
    if @workshop.save
      flash[:notice] = "Taller creado."
      redirect_to @workshop
    else
      flash[:alert] = "Algún error al crear Taller."
      render :action => 'new'
    end
  end
  
  def edit
    @workshop = Workshop.find_by_permalink(params[:id])
  end
  
  def update
    @workshop = Workshop.find_by_permalink(params[:id])
    if @workshop.update_attributes(params[:workshop])
      flash[:notice] = "Taller actualizado."
      redirect_to @workshop
    else
      flash[:alert] = "Algún error al modificar Taller."
      render :action => 'edit'
    end
  end
  
  def destroy
    @workshop = Workshop.find_by_permalink(params[:id])
    @workshop.destroy
    flash[:notice] = "Taller eliminado."
    redirect_to workshops_url
  end
end
