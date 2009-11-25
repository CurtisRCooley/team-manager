class WelcomeController < ApplicationController
  skip_before_filter :check_authorization, :check_authentication

  def index
  end

end
