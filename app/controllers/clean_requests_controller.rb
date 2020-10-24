class CleanRequestsController < ApplicationController
before_action :set_clean_request, only: [:show,:edit,:update,:destroy]

    def new 
        @clean_request = CleanRequest.new
    end

    def create
        @clean_request = CleanRequest.new(clean_request_params)
        @clean_request.user_id = current_user.id
        if @clean_request.save
            flash[:notice] = "Clean request was succesfully created!"
            redirect_to @clean_request
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
            flash[:notice] = "Clean Requestsuccessfully updated!"
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
            params.require(:clean_request).permit(:plot_numbers, :clean, :location, :notes, :approved, :date)
        end


end
