require 'test_helper'

class KemasansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kemasan = kemasans(:one)
  end

  test "should get index" do
    get kemasans_url
    assert_response :success
  end

  test "should get new" do
    get new_kemasan_url
    assert_response :success
  end

  test "should create kemasan" do
    assert_difference('Kemasan.count') do
      post kemasans_url, params: { kemasan: { kemasan_kode: @kemasan.kemasan_kode, kemasan_name: @kemasan.kemasan_name } }
    end

    assert_redirected_to kemasan_url(Kemasan.last)
  end

  test "should show kemasan" do
    get kemasan_url(@kemasan)
    assert_response :success
  end

  test "should get edit" do
    get edit_kemasan_url(@kemasan)
    assert_response :success
  end

  test "should update kemasan" do
    patch kemasan_url(@kemasan), params: { kemasan: { kemasan_kode: @kemasan.kemasan_kode, kemasan_name: @kemasan.kemasan_name } }
    assert_redirected_to kemasan_url(@kemasan)
  end

  test "should destroy kemasan" do
    assert_difference('Kemasan.count', -1) do
      delete kemasan_url(@kemasan)
    end

    assert_redirected_to kemasans_url
  end
end
