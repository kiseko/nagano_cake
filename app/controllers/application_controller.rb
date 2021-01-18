class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_root_path
    elsif customer_signed_in?
      customers_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

end
