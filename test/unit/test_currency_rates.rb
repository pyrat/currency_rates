require 'test_helper'

class TestCurrencyRates < ActiveSupport::TestCase
  
  ['USD', 'GBP', 'EUR'].each do |currency|
    should "get the rates for #{currency}" do
      parser = CurrencyRates::Parser.new(currency)
      rates = parser.engage
      puts rates.inspect
      assert(rates.size > 0, "Empty rates array or not an array")
    end
  end

end
