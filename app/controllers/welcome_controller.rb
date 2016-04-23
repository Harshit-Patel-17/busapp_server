class WelcomeController < ApplicationController
  def welcome
    if can? :manage, :app
      redirect_to buses_path
    elsif can? :manage, :bus
      sign_out current_user
      redirect_to new_user_session_path
    else
      redirect_to new_user_session_path
    end
  end
end
