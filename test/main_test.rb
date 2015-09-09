gem 'minitest'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'main'


class TestRetailCalculator < Minitest::Test
  def setup
    @retail_calculator = RetailCalculator.new
  end

  def test_order_total__tax_ut
    assert_in_delta 106.85, @retail_calculator.order_total(10, 10, 'UT'), 0.001
  end

  def test_order_total__tax_nv
    assert_in_delta 108, @retail_calculator.order_total(10, 10, 'NV'), 0.001
  end

  def test_order_total__tax_tx
    assert_in_delta 106.25, @retail_calculator.order_total(10, 10, 'TX'), 0.001
  end

  def test_order_total__tax_al
    assert_in_delta 104, @retail_calculator.order_total(10, 10, 'AL'), 0.001
  end

  def test_order_total__tax_ca
    assert_in_delta 108.25, @retail_calculator.order_total(10, 10, 'CA'), 0.001
  end

  def test_order_total__tax_wa
    assert_in_delta 100.00, @retail_calculator.order_total(10, 10, 'WA'), 0.001
  end

  def test_order_total__discount_applied_before_tax
    assert_in_delta 1050.025, @retail_calculator.order_total(100, 10, 'CA'), 0.001
  end

  def test_order_total__1000_subtotal_yields_3_percent_discount
    assert_in_delta 970.00, @retail_calculator.order_total(100, 10, 'WA'), 0.001
  end

  def test_order_total__5000_subtotal_yields_5_percent_discount
    assert_in_delta 4750.00, @retail_calculator.order_total(500, 10, 'WA'), 0.001
  end

  def test_order_total__7000_subtotal_yields_7_percent_discount
    assert_in_delta 6510.00, @retail_calculator.order_total(700, 10, 'WA'), 0.001
  end

  def test_order_total__10000_subtotal_yields_10_percent_discount
    assert_in_delta 9000.00, @retail_calculator.order_total(100, 100, 'WA'), 0.001
  end

  def test_order_total__50000_subtotal_yields_15_percent_discount
    assert_in_delta 42500.00, @retail_calculator.order_total(500, 100, 'WA'), 0.001
  end
end

class CommandLineInterfaceTest < Minitest::Test
  def test_run__command_line
    $stdout.expects(:puts).with('6.6247')
    CommandLineInterface.run(['2', '3.1', 'UT'])
  end

  def test_invalid_quantity_raises_error
    assert_raises(ArgumentError) do
      CommandLineInterface.run(['this is not a number', '1.0', 'UT'])
    end
  end

  def test_invalid_price_raises_error
    assert_raises(ArgumentError) do
      CommandLineInterface.run(['100', 'this is not a number', 'UT'])
    end
  end
end

class CurrencyUnitTest < Minitest::Test
  def test_classexist
    assert_in_delta 10.0, CurrencyUnit.new(10.0).amount
  end

  def test_currency_convert
    currency_unit = CurrencyUnit.from_yuan(36.00)
    assert_equal 36.00, currency_unit.to_yuan
    assert_equal 6.00, currency_unit.to_dollars
  end
end
