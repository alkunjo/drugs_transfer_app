require 'test_helper'

class SatuansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @satuan = satuans(:one)
  end

  test "should get index" do
    get satuans_url
    assert_response :success
  end

  test "should get new" do
    get new_satuan_url
    assert_response :success
  end

  test "should create satuan" do
    assert_difference('Satuan.count') do
      post satuans_url, params: { satuan: { satuan_code: @satuan.satuan_code, satuan_isi: @satuan.satuan_isi, satuan_ukuran: @satuan.satuan_ukuran } }
    end

    assert_redirected_to satuan_url(Satuan.last)
  end

  test "should show satuan" do
    get satuan_url(@satuan)
    assert_response :success
  end

  test "should get edit" do
    get edit_satuan_url(@satuan)
    assert_response :success
  end

  test "should update satuan" do
    patch satuan_url(@satuan), params: { satuan: { satuan_code: @satuan.satuan_code, satuan_isi: @satuan.satuan_isi, satuan_ukuran: @satuan.satuan_ukuran } }
    assert_redirected_to satuan_url(@satuan)
  end

  test "should destroy satuan" do
    assert_difference('Satuan.count', -1) do
      delete satuan_url(@satuan)
    end

    assert_redirected_to satuans_url
  end
end
