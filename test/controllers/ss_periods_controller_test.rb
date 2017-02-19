require 'test_helper'

class SsPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ss_period = ss_periods(:one)
  end

  test "should get index" do
    get ss_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_ss_period_url
    assert_response :success
  end

  test "should create ss_period" do
    assert_difference('SsPeriod.count') do
      post ss_periods_url, params: { ss_period: { ss_period_period: @ss_period.ss_period_period } }
    end

    assert_redirected_to ss_period_url(SsPeriod.last)
  end

  test "should show ss_period" do
    get ss_period_url(@ss_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_ss_period_url(@ss_period)
    assert_response :success
  end

  test "should update ss_period" do
    patch ss_period_url(@ss_period), params: { ss_period: { ss_period_period: @ss_period.ss_period_period } }
    assert_redirected_to ss_period_url(@ss_period)
  end

  test "should destroy ss_period" do
    assert_difference('SsPeriod.count', -1) do
      delete ss_period_url(@ss_period)
    end

    assert_redirected_to ss_periods_url
  end
end
