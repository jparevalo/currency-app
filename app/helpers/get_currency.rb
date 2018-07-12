require 'net/http'
require 'json'
require 'date'

class GetCurrency
  def initialize
    api_key = Figaro.env.sbif_api_key
    @api_url = "https://api.sbif.cl/api-sbifv3/recursos_api/%{currency_type}/periodo/%{start_year}/%{start_month}/"\
                "dias_i/%{start_day}/%{end_year}/%{end_month}/dias_f/%{end_day}?apikey=#{api_key}&formato=json"
  end

  def get_ymd_from_date(date)
    return date
  end

  def uf(start_date, end_date)
    url = URI(@api_url % {currency_type: 'uf', start_year: start_date.year, start_month: start_date.month, start_day: start_date.day, end_year: end_date.year, end_month: end_date.month, end_day: end_date.day})
    {'UF': JSON.parse(Net::HTTP.get(url))['UFs']}
  end

  def usd(start_date, end_date)
    url = URI(@api_url % {currency_type: 'dolar', start_year: start_date.year, start_month: start_date.month, start_day: start_date.day, end_year: end_date.year, end_month: end_date.month, end_day: end_date.day})
    {'USD': JSON.parse(Net::HTTP.get(url))['Dolares']}
  end
end