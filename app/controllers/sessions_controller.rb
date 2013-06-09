class SessionsController < ActionController::Base

  def new

  end

  def create
      @user = User.from_omniauth(auth_hash)

      if @user.auth_token.nil?
        auth_token = SecureRandom.hex
        @user.auth_token = auth_token
        @user.save!
      end

      session[:auth_token] = @user.auth_token

      redirect_to root_path
  end

  def destroy
    session[:auth_token] = nil
    redirect_to root_path
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
