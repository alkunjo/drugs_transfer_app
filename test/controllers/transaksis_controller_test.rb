require 'test_helper'

class TransaksisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaksi = transaksis(:one)
  end

  test "should get index" do
    get transaksis_url
    assert_response :success
  end

  test "should get new" do
    get new_transaksi_url
    assert_response :success
  end

  test "should create transaksi" do
    assert_difference('Transaksi.count') do
      post transaksis_url, params: { transaksi: { accepted_at: @transaksi.accepted_at, asked_at: @transaksi.asked_at, dropped_at: @transaksi.dropped_at, receiver_id: @transaksi.receiver_id, receiver_id: @transaksi.receiver_id, sender_id: @transaksi.sender_id, sender_id: @transaksi.sender_id, trans_status: @transaksi.trans_status } }
    end

    assert_redirected_to transaksi_url(Transaksi.last)
  end

  test "should show transaksi" do
    get transaksi_url(@transaksi)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaksi_url(@transaksi)
    assert_response :success
  end

  test "should update transaksi" do
    patch transaksi_url(@transaksi), params: { transaksi: { accepted_at: @transaksi.accepted_at, asked_at: @transaksi.asked_at, dropped_at: @transaksi.dropped_at, receiver_id: @transaksi.receiver_id, receiver_id: @transaksi.receiver_id, sender_id: @transaksi.sender_id, sender_id: @transaksi.sender_id, trans_status: @transaksi.trans_status } }
    assert_redirected_to transaksi_url(@transaksi)
  end

  test "should destroy transaksi" do
    assert_difference('Transaksi.count', -1) do
      delete transaksi_url(@transaksi)
    end

    assert_redirected_to transaksis_url
  end
end
