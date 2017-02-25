require 'test_helper'

class DtransControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dtran = dtrans(:one)
  end

  test "should get index" do
    get dtrans_url
    assert_response :success
  end

  test "should get new" do
    get new_dtran_url
    assert_response :success
  end

  test "should create dtran" do
    assert_difference('Dtran.count') do
      post dtrans_url, params: { dtran: { belongs_to: @dtran.belongs_to, dta_qty: @dtran.dta_qty, dtd_qty: @dtran.dtd_qty, dtd_rsn: @dtran.dtd_rsn, dtt_qty: @dtran.dtt_qty, dtt_rsn: @dtran.dtt_rsn, stock_id: @dtran.stock_id, transaksi_id: @dtran.transaksi_id } }
    end

    assert_redirected_to dtran_url(Dtran.last)
  end

  test "should show dtran" do
    get dtran_url(@dtran)
    assert_response :success
  end

  test "should get edit" do
    get edit_dtran_url(@dtran)
    assert_response :success
  end

  test "should update dtran" do
    patch dtran_url(@dtran), params: { dtran: { belongs_to: @dtran.belongs_to, dta_qty: @dtran.dta_qty, dtd_qty: @dtran.dtd_qty, dtd_rsn: @dtran.dtd_rsn, dtt_qty: @dtran.dtt_qty, dtt_rsn: @dtran.dtt_rsn, stock_id: @dtran.stock_id, transaksi_id: @dtran.transaksi_id } }
    assert_redirected_to dtran_url(@dtran)
  end

  test "should destroy dtran" do
    assert_difference('Dtran.count', -1) do
      delete dtran_url(@dtran)
    end

    assert_redirected_to dtrans_url
  end
end
