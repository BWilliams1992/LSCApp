class UserMailer < ApplicationMailer
    default from: "notifications@lscleaning.co.uk"
    layout 'mailer'

    def new_clean_request_email
        @user = params[:user]
        @clean_request = params[:clean_request]
        mail(to: "ben.legend@live.com", subject: "New clean request")
    end
end
