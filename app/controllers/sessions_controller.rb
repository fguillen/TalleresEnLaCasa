class SessionsController < ApplicationController
  def new
  end
  
  def create
    if( APP_CONFIG[:password] == params[:password] )
      session[:admin] = true
      flash[:notice] = "Aceptado como Administrador"
      redirect_to workshops_path
    else
      flash[:alert] = "Password incorrecta"
      redirect_to new_sessions_path
    end
  end
  
  def destroy
    session[:admin] = nil
    flash[:notice] = "Has cerrado la session como Administrador"
    redirect_to workshops_path
  end
end