class UnitsController < ApplicationController
  before_action :set_unit

  def train
    @unit.training

    flash_message = "Unité en cours de construction !"
    status = "success"

    respond_to do |format|
      format.js { flash.now[status] = flash_message }
      format.json { render json:
        {
        }
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id]) unless params[:id].nil?
    end
end
