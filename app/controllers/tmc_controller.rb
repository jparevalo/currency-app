class TmcController < ApplicationController
  def index
    @start_date = Date.today
    @end_date = Date.today
    @tmc_values = GetCurrency.new().tmc(@start_date, @end_date)[:TMC]
    handle_no_results
    group_by_name
  end

  def set_params
    params.require(:range).permit(:start_date, :end_date)
  end

  def handle_no_results
    if not @tmc_values
      @tmc_values = [{"Fecha" => @end_date, "Titulo" => 'No existe información para el rango seleccionado' }]
    end
  end

  def group_by_name
    @tmc_values.each_with_index do |tmc, index|
      if tmc["Titulo"].nil?
        puts 'iiii'
        @tmc_values[index]["Titulo"] = @tmc_values[index]["SubTitulo"]
      end
    end
    @tmc_by_title = @tmc_values.group_by { |tmc| tmc["Titulo"] }
  end

  def update
    @start_date = Date.strptime(set_params[:start_date],'%m/%d/%Y')
    @end_date = Date.strptime(set_params[:end_date],'%m/%d/%Y')
    @tmc_values = GetCurrency.new().tmc(@start_date, @end_date)[:TMC]
    handle_no_results
    group_by_name
    render :index
  end
end
