require 'test_helper'

class PaymentInfosControllerTest < ActionController::TestCase
  setup do
    @payment_info = payment_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_info" do
    assert_difference('PaymentInfo.count') do
      post :create, :payment_info => @payment_info.attributes
    end

    assert_redirected_to payment_info_path(assigns(:payment_info))
  end

  test "should show payment_info" do
    get :show, :id => @payment_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @payment_info.to_param
    assert_response :success
  end

  test "should update payment_info" do
    put :update, :id => @payment_info.to_param, :payment_info => @payment_info.attributes
    assert_redirected_to payment_info_path(assigns(:payment_info))
  end

  test "should destroy payment_info" do
    assert_difference('PaymentInfo.count', -1) do
      delete :destroy, :id => @payment_info.to_param
    end

    assert_redirected_to payment_infos_path
  end
end
