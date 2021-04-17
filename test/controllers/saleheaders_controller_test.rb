require 'test_helper'

class SaleheadersControllerTest < ActionController::TestCase
  setup do
    @saleheader = saleheaders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saleheaders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saleheader" do
    assert_difference('Saleheader.count') do
      post :create, saleheader: {  }
    end

    assert_redirected_to saleheader_path(assigns(:saleheader))
  end

  test "should show saleheader" do
    get :show, id: @saleheader
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saleheader
    assert_response :success
  end

  test "should update saleheader" do
    patch :update, id: @saleheader, saleheader: {  }
    assert_redirected_to saleheader_path(assigns(:saleheader))
  end

  test "should destroy saleheader" do
    assert_difference('Saleheader.count', -1) do
      delete :destroy, id: @saleheader
    end

    assert_redirected_to saleheaders_path
  end
end
