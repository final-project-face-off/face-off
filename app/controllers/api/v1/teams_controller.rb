class Api::V1::TeamsController < Api::V1::BaseController

    def index
      respond_with Team.all
    end

    # def show
    #     respond_with = Team.find params[:id]
    #   end
  
    # def create
    #   respond_with :api, :v1, Team.create(item_params)
    # end
  
    # def destroy
    #   respond_with Team.destroy(params[:id])
    # end
  
    # def update
    #   item = Team.find(params["id"])
    #   item.update_attributes(item_params)
    #   respond_with item, json: item
    # end
  
#     private
  
#     def team_params
#       params.require(:team).permit(:id)
#     end
#   end
    end