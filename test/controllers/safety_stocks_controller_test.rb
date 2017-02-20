require 'test_helper'

class SafetyStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @safety_stock = safety_stocks(:one)
  end

  test "should get index" do
    get safety_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_safety_stock_url
    assert_response :success
  end

  test "should create safety_stock" do
    assert_difference('SafetyStock.count') do
      post safety_stocks_url, params: { safety_stock: { belongs_to: @safety_stock.belongs_to, belongs_to: @safety_stock.belongs_to, safety_stock_qty: @safety_stock.safety_stock_qty } }
    end

    assert_redirected_to safety_stock_url(SafetyStock.last)
  end

  test "should show safety_stock" do
    get safety_stock_url(@safety_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_safety_stock_url(@safety_stock)
    assert_response :success
  end

  test "should update safety_stock" do
    patch safety_stock_url(@safety_stock), params: { safety_stock: { belongs_to: @safety_stock.belongs_to, belongs_to: @safety_stock.belongs_to, safety_stock_qty: @safety_stock.safety_stock_qty } }
    assert_redirected_to safety_stock_url(@safety_stock)
  end

  test "should destroy safety_stock" do
    assert_difference('SafetyStock.count', -1) do
      delete safety_stock_url(@safety_stock)
    end

    assert_redirected_to safety_stocks_url
  end
end
