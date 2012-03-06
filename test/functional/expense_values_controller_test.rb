require 'test_helper'

class ExpenseValuesControllerTest < ActionController::TestCase
  setup do
    @expense_value = expense_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_value" do
    assert_difference('ExpenseValue.count') do
      post :create, expense_value: @expense_value.attributes
    end

    assert_redirected_to expense_value_path(assigns(:expense_value))
  end

  test "should show expense_value" do
    get :show, id: @expense_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_value
    assert_response :success
  end

  test "should update expense_value" do
    put :update, id: @expense_value, expense_value: @expense_value.attributes
    assert_redirected_to expense_value_path(assigns(:expense_value))
  end

  test "should destroy expense_value" do
    assert_difference('ExpenseValue.count', -1) do
      delete :destroy, id: @expense_value
    end

    assert_redirected_to expense_values_path
  end
end
