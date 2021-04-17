require 'test_helper'

class InkardexesControllerTest < ActionController::TestCase
  setup do
    @inkardex = inkardexes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inkardexes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inkardex" do
    assert_difference('Inkardex.count') do
      post :create, inkardex: { cantidad: @inkardex.cantidad, existencia: @inkardex.existencia, infecha: @inkardex.infecha, moneda: @inkardex.moneda, numdocumento: @inkardex.numdocumento, valorcompra: @inkardex.valorcompra }
    end

    assert_redirected_to inkardex_path(assigns(:inkardex))
  end

  test "should show inkardex" do
    get :show, id: @inkardex
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inkardex
    assert_response :success
  end

  test "should update inkardex" do
    patch :update, id: @inkardex, inkardex: { cantidad: @inkardex.cantidad, existencia: @inkardex.existencia, infecha: @inkardex.infecha, moneda: @inkardex.moneda, numdocumento: @inkardex.numdocumento, valorcompra: @inkardex.valorcompra }
    assert_redirected_to inkardex_path(assigns(:inkardex))
  end

  test "should destroy inkardex" do
    assert_difference('Inkardex.count', -1) do
      delete :destroy, id: @inkardex
    end

    assert_redirected_to inkardexes_path
  end
end
