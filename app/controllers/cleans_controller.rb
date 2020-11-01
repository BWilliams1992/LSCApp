class CleansController < ApplicationController
    before_action :set_clean, only: [:show,:edit,:update,:destroy]

    def new 
        @clean = Clean.new
    end

    def create
        @clean = Clean.new(clean_params)
        if @clean.save
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
        if @clean.update(clean_params)
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

    def convert
        @clean_request = CleanRequest.find(params[:clean_request_id])
        if !@clean_request.cleans[0]
                @clean = Clean.new(
                    date: @clean_request.date, 
                    location_id: @clean_request.location_id,
                    plot: @clean_request.plot_numbers,
                    house_id: '1',
                    clean_type: @clean_request.clean_type,
                    clean_request_id: @clean_request.id,
                    completed: false
                )
                if @clean.save
                    flash[:notice] = "Clean successfully generated from clean request"
                else
                    render 'show'
                    flash[:error] = 'Error in conversion'
                end
            redirect_to cleans_path
        else
            raise  Exception.new("Cleans already exists for this clean request")
        end
    end

    private

        def set_clean
            @clean = Clean.find(params[:id])
        end

        def clean_params 
            params.require(:clean).permit(:date, :location_id, :plot, :house_id, :completed, :clean_type) 
        end

end
