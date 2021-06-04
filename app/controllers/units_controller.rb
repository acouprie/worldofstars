class UnitsController < ApplicationController
  before_action :set_unit

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id]) unless params[:id].nil?
    end
end
