class AttendeesController < ApplicationController
  before_filter :charge_workshop
  def index
    @attendees = @workshop.attendees.all
  end
  
  def show
    @attendee = @workshop.attendees.find(params[:id])
  end
  
  def edit
    @attendee = @workshop.attendees.find(params[:id])
  end
  
  def update
    @attendee = @workshop.attendees.find(params[:id])
    if @attendee.update_attributes(params[:attendee])
      flash[:notice] = "Alumno creado."
      redirect_to [@workshop, @attendee]
    else
      flash[:alert] = "Algún error al actualizar el Alumno."
      render :action => 'edit'
    end
  end

  
  def create
    @attendee = @workshop.attendees.new(params[:attendee])
    if @attendee.save
      flash[:notice] = "Apuntado tu interés al Taller de #{@workshop.title}."
      redirect_to @workshop
    else
      flash[:alert] = "Algún error al apuntarte al Taller."
      redirect_to @workshop
    end
  end
  
  def destroy
    @attendee = @workshop.attendees.find(params[:id])
    @attendee.destroy
    flash[:notice] = "Eliminado el alumno #{@attendee.name} del Taller #{@workshop}."
    redirect_to @workshop
  end
  
  private
    def charge_workshop
      @workshop = Workshop.find_by_permalink(params[:workshop_id])
    end
end
