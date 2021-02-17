# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    require 'google/api_client/client_secrets'

    def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env['omniauth.auth'])
      client_secrets = Google::APIClient::ClientSecrets.load
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        :scope => 'https://www.googleapis.com/auth/calendar',
        :redirect_uri => 'http://localhost:3000/',
        :additional_parameters => {
          "access_type" => "offline",         # offline access
          "include_granted_scopes" => "true"  # incremental auth
        }
      )

    auth_client.code = params['code']
    byebug
    auth_client.fetch_access_token!
    session['auth_client'] = auth_client
       byebug
      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
  end
end
