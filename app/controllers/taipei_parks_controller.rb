class TaipeiParksController < ApplicationController

  def index
    @taipeiparks = TaipeiPark.all
    @park_nums_per_area = TaipeiPark.group("administrativearea").count
  end

end
