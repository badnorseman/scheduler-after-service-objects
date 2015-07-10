class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  ##### Details: http://technpol.wordpress.com/2014/04/17/rails4-angularjs-csrf-and-devise/
  ##### after_action :set_csrf_cookie_for_ng

  ##### serialization_scope :current_ability
  ##### serialization_scope :current_user

  ##### leauge-tutorial-rails4
  ##### rescue_from ActionController::InvalidAuthenticityToken do |exception|
  #####   cookies["XSRF-TOKEN"] = form_authenticity_token if protect_against_forgery?
  ##### end

  ##### leauge-tutorial-rails4
  ##### def set_csrf_cookie_for_ng
  #####   cookies["XSRF-TOKEN"] = form_authenticity_token if protect_against_forgery?
  ##### end

  ##### leauge-tutorial-rails4
  ##### Redirects any HTML request to root
  ##### def intercept_html_requests
  #####   redirect_to("/") if request.format == Mime::HTML
  ##### end

  ##### leauge-tutorial-rails4
  ##### def render_with_protection(object, parameters = {})
  #####   render parameters.merge(content_type: "application/json", text: ")]}",\n" + object.to_json)
  ##### end

  # Prevents CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  protected

  ##### leauge-tutorial-rails4
  def verified_request?
    super || form_authenticity_token == request.headers["X-XSRF-TOKEN"]
  end

  # Allows access to current_user in serializators.
  serialization_scope :current_user
end
