class AttendeesController < ApplicationController
  before_filter :charge_workshop
  before_filter :require_admin, :only => [:index, :show, :edit, :update, :destroy]
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
      gateway_response = 
        gateway.setup_purchase(
          APP_CONFIG[:preinscription_price] * 100,
          :ip                => request.remote_ip,
          :return_url        => confirm_payment_workshop_attendee_url( @workshop, @attendee ),
          :cancel_return_url => workshop_url( @workshop )
        )
      
      @attendee.update_attribute(:paypal_token, gateway_response.token)

      paypal_url = gateway.redirect_url_for(gateway_response.token, :review => false)
          
      redirect_to paypal_url
    else
      flash[:alert] = "Algún error al apuntarte al Taller."
      render 'workshops/show'
    end
  end
  
  def confirm_payment
    @attendee = @workshop.attendees.find(params[:id])
    
    gateway_response = gateway.details_for(params[:token])
    @attendee.parse_paypal_response( gateway_response )

    if gateway_response.success?
      @attendee.mark_as_purchased
      flash[:notice] = "Has completado tu preinscripcion al Taller '#{@workshop.title}'."
    else
      flash[:alert] = "Se ha producido un error en el pago de tu preinscripción, por favor vuelve a intentarlo o contacta con nosotros."
      @attendee.update_attributes(:status => Attendee::STATUS[:error])
    end  

    redirect_to @workshop
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

    def gateway
      @gateway ||= 
        ActiveMerchant::Billing::PaypalExpressGateway.new(
          :login =>     APP_CONFIG[:paypal_api_user],
          :password =>  APP_CONFIG[:paypal_api_password],
          :signature => APP_CONFIG[:paypal_api_firm]
        )
    end
end
