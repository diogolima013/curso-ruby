class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Diogo[COOKIE]"
    session[:curso] = "Curso de Ruby on Rails - Diogo[SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
