class AuthenticationsController < ApplicationController
  def destroy
    authentication.destroy
    redirect_to :back
  end

  def authentication
    @authentiction ||= if params[:id]
      current_user.authentications.find params[:id]
    end
  end
end
