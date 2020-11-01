class CleanRequestsController < ApplicationController
before_action :set_clean_request, except: [:index,:new,:create,:convert]

    def new 
        @clean_request = CleanRequest.new
    end

    def create
        @clean_request = CleanRequest.new(clean_request_params)
        @clean_request.user_id = current_user.id

        if @clean_request.save
            flash[:notice] = "Clean request was succesfully created!"
            redirect_to @clean_request
            UserMailer.with(user: current_user, clean_request: @clean_request).new_clean_request_email.deliver_now
        else
            render 'new'
        end

    end

    def show
    end

    def index
        @clean_requests = CleanRequest.all 
    end

    def update
        if @clean_request.update(clean_request_params)
            flash[:notice] = "Clean Request successfully updated!"
            redirect_to @clean_request
          else
            render 'edit'
          end
    end

    def edit
    end

    def destroy
        @clean_request.destroy
        flash[:notice] = "Clean request removed"
        redirect_to clean_requests_path
    end

    private

        def set_clean_request
            @clean_request = CleanRequest.find(params[:id])
        end

        def clean_request_params 
            params.require(:clean_request).permit(:clean_type, :location_id, :notes, :approved, :date, :plot_numbers => [])
        end

end
