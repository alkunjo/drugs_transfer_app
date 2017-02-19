require 'test_helper'

class OutletTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outlet_type = outlet_types(:one)
  end

  test "should get index" do
    get outlet_types_url
    assert_response :success
  end

  test "should get new" do
    get new_outlet_type_url
    assert_response :success
  end

  test "should create outlet_type" do
    assert_difference('OutletType.count') do
      post outlet_types_url, params: { outlet_type: { otype_name: @outlet_type.otype_name } }
    end

    assert_redirected_to outlet_type_url(OutletType.last)
  end

  test "should show outlet_type" do
    get outlet_type_url(@outlet_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_outlet_type_url(@outlet_type)
    assert_response :success
  end

  test "should update outlet_type" do
    patch outlet_type_url(@outlet_type), params: { outlet_type: { otype_name: @outlet_type.otype_name } }
    assert_redirected_to outlet_type_url(@outlet_type)
  end

  test "should destroy outlet_type" do
    assert_difference('OutletType.count', -1) do
      delete outlet_type_url(@outlet_type)
    end

    assert_redirected_to outlet_types_url
  end
end
