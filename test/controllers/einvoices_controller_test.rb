require 'test_helper'

class EinvoicesControllerTest < ActionController::TestCase
  setup do
    @einvoice = einvoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:einvoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create einvoice" do
    assert_difference('Einvoice.count') do
      post :create, einvoice: {  }
    end

    assert_redirected_to einvoice_path(assigns(:einvoice))
  end

  test "should show einvoice" do
    get :show, id: @einvoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @einvoice
    assert_response :success
  end

  test "should update einvoice" do
    patch :update, id: @einvoice, einvoice: {  }
    assert_redirected_to einvoice_path(assigns(:einvoice))
  end

  test "should destroy einvoice" do
    assert_difference('Einvoice.count', -1) do
      delete :destroy, id: @einvoice
    end

    assert_redirected_to einvoices_path
  end
end
