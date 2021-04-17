require 'test_helper'

class OutkardexesControllerTest < ActionController::TestCase
  setup do
    @outkardex = outkardexes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outkardexes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outkardex" do
    assert_difference('Outkardex.count') do
      post :create, outkardex: { cantidad: @outkardex.cantidad, moneda: @outkardex.moneda, numdocumento: @outkardex.numdocumento, outfecha: @outkardex.outfecha, valorventa: @outkardex.valorventa }
    end

    assert_redirected_to outkardex_path(assigns(:outkardex))
  end

  test "should show outkardex" do
    get :show, id: @outkardex
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outkardex
    assert_response :success
  end

  test "should update outkardex" do
    patch :update, id: @outkardex, outkardex: { cantidad: @outkardex.cantidad, moneda: @outkardex.moneda, numdocumento: @outkardex.numdocumento, outfecha: @outkardex.outfecha, valorventa: @outkardex.valorventa }
    assert_redirected_to outkardex_path(assigns(:outkardex))
  end

  test "should destroy outkardex" do
    assert_difference('Outkardex.count', -1) do
      delete :destroy, id: @outkardex
    end

    assert_redirected_to outkardexes_path
  end
end
