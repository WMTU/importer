class SessionsController < ApplicationController
  layout 'login'
  skip_before_action :authenticate, only: [:new, :create]
  before_action :auth_via_cookie, only: [:new]

  def new
  end

  def create
    user = Users::Authenticate.call params[:username], params[:password]
    if user
      session[:user_id] = user.id
      self.session_cookie = user.tokens.create.key
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    find_token(session_cookie).destroy
    self.session_cookie = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  private

  def auth_via_cookie
    return unless user = find_token(session_cookie).user
    session[:user_id] = user.id
    self.session_cookie = Token.find_by_key(session_cookie).destroy.user.tokens.create.key
    redirect_back
  end

  def session_cookie=(value)
    cookies.delete(:_importer_session_id) && return if value.nil?
    cookies.encrypted[:_importer_session_id] = { value: value, expires: Time.now + eval(CONFIG[:token_expiry]) }
  end

  def session_cookie
    cookies.encrypted[:_importer_session_id]
  end

  def find_token(key)
    token = Token.find_by_key(key)
    return Token.new unless token
    token.destroy && return if token.expired?
    token || Token.new
  end
end
