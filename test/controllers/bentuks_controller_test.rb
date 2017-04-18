require 'test_helper'

class BentuksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bentuk = bentuks(:one)
  end

  test "should get index" do
    get bentuks_url
    assert_response :success
  end

  test "should get new" do
    get new_bentuk_url
    assert_response :success
  end

  test "should create bentuk" do
    assert_difference('Bentuk.count') do
      post bentuks_url, params: { bentuk: { bentuk_name: @bentuk.bentuk_name } }
    end

    assert_redirected_to bentuk_url(Bentuk.last)
  end

  test "should show bentuk" do
    get bentuk_url(@bentuk)
    assert_response :success
  end

  test "should get edit" do
    get edit_bentuk_url(@bentuk)
    assert_response :success
  end

  test "should update bentuk" do
    patch bentuk_url(@bentuk), params: { bentuk: { bentuk_name: @bentuk.bentuk_name } }
    assert_redirected_to bentuk_url(@bentuk)
  end

  test "should destroy bentuk" do
    assert_difference('Bentuk.count', -1) do
      delete bentuk_url(@bentuk)
    end

    assert_redirected_to bentuks_url
  end
end
