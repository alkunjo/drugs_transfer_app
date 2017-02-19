require 'test_helper'

class ObatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @obat = obats(:one)
  end

  test "should get index" do
    get obats_url
    assert_response :success
  end

  test "should get new" do
    get new_obat_url
    assert_response :success
  end

  test "should create obat" do
    assert_difference('Obat.count') do
      post obats_url, params: { obat: { obat_hpp: @obat.obat_hpp, obat_name: @obat.obat_name } }
    end

    assert_redirected_to obat_url(Obat.last)
  end

  test "should show obat" do
    get obat_url(@obat)
    assert_response :success
  end

  test "should get edit" do
    get edit_obat_url(@obat)
    assert_response :success
  end

  test "should update obat" do
    patch obat_url(@obat), params: { obat: { obat_hpp: @obat.obat_hpp, obat_name: @obat.obat_name } }
    assert_redirected_to obat_url(@obat)
  end

  test "should destroy obat" do
    assert_difference('Obat.count', -1) do
      delete obat_url(@obat)
    end

    assert_redirected_to obats_url
  end
end
