# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@lscleaning.co.uk'
  layout 'mailer'

  def new_clean_request_email
    @user = params[:user]
    @clean_request = params[:clean_request]
    mail(to: 'ben.legend@live.com', subject: 'New clean request')
  end

  def clean_request_approval_change_email
    @clean_request = params[:clean_request]
    @user = params[:user]
    mail(to: @user.email, subject: 'Clean request update')
  end
end
