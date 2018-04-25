class FarmController < ApplicationController
  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(name: 'Centrale Solaire', planet_id: self.id, lvl: 1, conso_power: 0, production: 55)
    puts 'aaaa'
    puts @farm.inspect
    respond_to do |format|
      if @farm.save
        format.html { redirect_to @farm, notice: 'Building was successfully created.' }
        format.json { render :show, status: :created, location: @farm }
      else
        format.html { render :new }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
      end
    end
  end
end
