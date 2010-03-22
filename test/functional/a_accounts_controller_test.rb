require 'test_helper'

class AAccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:a_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a_account" do
    assert_difference('AAccount.count') do
      post :create, :a_account => { }
    end

    assert_redirected_to a_account_path(assigns(:a_account))
  end

  test "should show a_account" do
    get :show, :id => a_accounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => a_accounts(:one).to_param
    assert_response :success
  end

  test "should update a_account" do
    put :update, :id => a_accounts(:one).to_param, :a_account => { }
    assert_redirected_to a_account_path(assigns(:a_account))
  end

  test "should destroy a_account" do
    assert_difference('AAccount.count', -1) do
      delete :destroy, :id => a_accounts(:one).to_param
    end

    assert_redirected_to a_accounts_path
  end
end
