class CleansController < ApplicationController
    before_action :set_clean, only: [:show,:edit,:update,:destroy]
    load_and_authorize_resource

    def new 
        @clean = Clean.new
    end

    def create
        @clean = Clean.new(clean_params)
        if @clean.save!
            flash[:notice] = "Clean was succesfully created!"
            redirect_to @clean
        else
            render 'new'
        end

    end

    def show
    end

    def index
        @cleans = Clean.all 
    end

    def update
        if @clean.update!(clean_params)
            flash[:notice] = "Clean successfully updated!"
            redirect_to @clean
          else
            render 'edit'
          end
    end

    def edit
    end

    def destroy
        @clean.destroy
        flash[:notice] = "Clean removed"
        redirect_to cleans_path
    end

    private

        def set_clean
            @clean = Clean.find(params[:id])
        end

        def clean_params 
            params.require(:clean).permit(:date, :location_id, :plot_id, :completed, :clean_type, :clean_request, :start_time, :end_time, :num_people) 
        end

end
