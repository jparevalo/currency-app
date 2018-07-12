class HomeController < ApplicationController
  def index
    @start_date = Date.today
    @end_date = Date.today
    @uf_values = GetCurrency.new().uf(@start_date, @end_date)[:UF]
  end

  def set_params
    params.require(:range).permit(:start_date, :end_date)
  end

  def update
    @start_date = Date.strptime(set_params[:start_date],'%m/%d/%Y')
    @end_date = Date.strptime(set_params[:end_date],'%m/%d/%Y')
    @uf_values = GetCurrency.new().uf(@start_date, @end_date)[:UF]
    render :index
  end
end
