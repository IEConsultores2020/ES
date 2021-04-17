require 'test_helper'

class SaledetailsControllerTest < ActionController::TestCase
  setup do
    @saledetail = saledetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saledetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saledetail" do
    assert_difference('Saledetail.count') do
      post :create, saledetail: {  }
    end

    assert_redirected_to saledetail_path(assigns(:saledetail))
  end

  test "should show saledetail" do
    get :show, id: @saledetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saledetail
    assert_response :success
  end

  test "should update saledetail" do
    patch :update, id: @saledetail, saledetail: {  }
    assert_redirected_to saledetail_path(assigns(:saledetail))
  end

  test "should destroy saledetail" do
    assert_difference('Saledetail.count', -1) do
      delete :destroy, id: @saledetail
    end

    assert_redirected_to saledetails_path
  end
end
