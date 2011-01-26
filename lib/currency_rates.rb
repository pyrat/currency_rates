require 'open-uri'
require 'nokogiri'

# This is a little currency class that grabs rates from the european bank
# and converts them into the base currency of your choice.
module CurrencyRates
  
  class Parser
    
    XML_URL = "http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml"
    
    def initialize(base_currency)
      @base_currency = base_currency
    end
    
    def engage
      doc = Nokogiri::XML(open(XML_URL))
      currency_collection = doc.css("Cube > Cube > Cube")
      
      # Just return if the base currency is EUR as that is
      # the format of the xml in the firstplace.
      return to_hash(currency_collection) if @base_currency == 'EUR'
      
      rate = get_rate(currency_collection, @base_currency)
      converted_rates = convert_rates(currency_collection, rate)
      
      return to_hash(converted_rates) << euro_rate(rate)
    end
    
    
    private
    
    def get_rate(currency_collection, currency_code = 'GBP')
      currency_collection.each do |currency|
        if currency['currency'].to_s == currency_code
          return currency['rate']
        end
      end
      raise "Unable to find the currency specified."
    end
    
    def convert_rates(currency_collection, rate)
      currency_collection.each do |currency|
        new_rate = currency['rate'].to_f / rate.to_f
        currency['rate'] = format("%.5f", new_rate)
      end
      currency_collection
    end
    
    def euro_rate(rate)
      new_rate = format("%.5f", 1 / rate.to_f)
      {'currency' => 'EUR', 'rate' => new_rate}
    end
    
    def to_hash(converted_rates)
      converted_rates.map do |rate|
        {'currency' => rate['currency'], 'rate' => rate['rate']}
      end
    end
    
  end
  
  
end


