class WelcomeController < ApplicationController
  def welcome
    if can? :manage, :app
    elsif can? :manage, :bus
    else
      redirect_to new_user_session_path
    end
  end
end
