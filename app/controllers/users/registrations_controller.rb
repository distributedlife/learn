class Users::RegistrationsController < Devise::RegistrationsController
  def create
    params[:email_only] ||= false
    
    build_resource

    #can we merge, otherwise just roll with it
    if params[:user][:password] and params[:user][:email]
      existing_user = get_first User.where(:email => params[:user][:email])

      unless existing_user.nil?
        if existing_user.valid_password? params[:user][:password] or existing_user.encrypted_password.empty?
          @user = existing_user
          @user.apply_omniauth(session[:omniauth])
        end
      end
    end

    
    #standard devise behaviour
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!

        #redirect to pending page
        redirect_to pending_authentications_path
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource, :email_only => params[:email_only]) { render_with_scope :new }
    end


    session[:omniauth] = nil unless @user.new_record?
  end

  def update
    #delete the admin property; this should stop admin accounts from being created via the devise form
    params[:user].delete :admin

    super
  end

  protected

  def after_sign_up_path_for(resource)
    user_index_path
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

end
