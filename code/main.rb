# X Accept input, spit out whatever the user gave us on the command line.
# X Accept quantity and price, print sum.
# X Add in sales tax for a single state.
# X Add in sales tax for remaining state.
# X Add in discount for 1000-5000.
# X Add in discount for remaining prices.
# Validate input.

class RetailCalculator
  def order_total(quantity, price, state)
    subtotal = subtotal(price, quantity)
    (subtotal * (1 - discount_rate(subtotal))) * (tax_rate(state) + 1)
  end

  private

  TAX_RATES = {
    'NV' => 0.08,
    'UT' => 0.0685,
    'TX' => 0.0625,
    'AL' => 0.04,
    'CA' => 0.0825,
  }

  def subtotal(price, quantity)
    quantity * price
  end

  def tax_rate(state)
    TAX_RATES[state] || 0.00
  end

  def discount_rate(subtotal)
    case subtotal
      when 0...1000
        0.00
      when 1000...5000
        0.03
      when 5000...7000
        0.05
      when 7000...10000
        0.07
      when 10000...50000
        0.1
      else
        0.15
    end
  end
end

class CommandLineInterface
  def self.run(args)
    retail_calculator = RetailCalculator.new
    order_total = retail_calculator.order_total(Float(args[0]), Float(args[1]), args[2])
    $stdout.puts(order_total.to_s)
  end
end

class CurrencyUnit
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end


end
