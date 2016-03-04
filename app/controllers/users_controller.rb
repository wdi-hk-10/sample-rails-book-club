class UsersController < ApplicationController
  def signin
    # Dummy login, no need to check ID
    redirect_to main_path
  end
end
