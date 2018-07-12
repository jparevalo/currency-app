class HomeController < ApplicationController
  def index
    @start_date = Date.today
    @end_date = Date.today
    @uf_values = GetCurrency.new().uf(@start_date, @end_date)[:UF]
    @usd_values = GetCurrency.new().usd(@start_date, @end_date)[:USD]
    handle_no_results()
  end

  def set_params
    params.require(:range).permit(:start_date, :end_date)
  end

  def handle_no_results
    if not @uf_values
      @uf_values = [{"Fecha" => @end_date, "Valor" => 'No existe información' }]
    end
    if not @usd_values
      @usd_values = [{"Fecha" => @end_date, "Valor" => 'No existe información' }]
    end
  end

  def update
    @start_date = Date.strptime(set_params[:start_date],'%m/%d/%Y')
    @end_date = Date.strptime(set_params[:end_date],'%m/%d/%Y')
    @uf_values = GetCurrency.new().uf(@start_date, @end_date)[:UF]
    @usd_values = GetCurrency.new().usd(@start_date, @end_date)[:USD]
    handle_no_results()
    render :index
  end
end
