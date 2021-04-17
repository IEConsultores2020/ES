require 'test_helper'

class ComprasControllerTest < ActionController::TestCase
  setup do
    @compra = compras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compra" do
    assert_difference('Compra.count') do
      post :create, compra: { cantidad: @compra.cantidad, fecha_ingreso: @compra.fecha_ingreso, moneda: @compra.moneda, num_factura: @compra.num_factura, valor_total: @compra.valor_total, valor_unidad: @compra.valor_unidad, valor_venta: @compra.valor_venta }
    end

    assert_redirected_to compra_path(assigns(:compra))
  end

  test "should show compra" do
    get :show, id: @compra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @compra
    assert_response :success
  end

  test "should update compra" do
    patch :update, id: @compra, compra: { cantidad: @compra.cantidad, fecha_ingreso: @compra.fecha_ingreso, moneda: @compra.moneda, num_factura: @compra.num_factura, valor_total: @compra.valor_total, valor_unidad: @compra.valor_unidad, valor_venta: @compra.valor_venta }
    assert_redirected_to compra_path(assigns(:compra))
  end

  test "should destroy compra" do
    assert_difference('Compra.count', -1) do
      delete :destroy, id: @compra
    end

    assert_redirected_to compras_path
  end
end
