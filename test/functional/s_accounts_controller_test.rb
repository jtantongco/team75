require 'test_helper'

class SAccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_account" do
    assert_difference('SAccount.count') do
      post :create, :s_account => { }
    end

    assert_redirected_to s_account_path(assigns(:s_account))
  end

  test "should show s_account" do
    get :show, :id => s_accounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => s_accounts(:one).to_param
    assert_response :success
  end

  test "should update s_account" do
    put :update, :id => s_accounts(:one).to_param, :s_account => { }
    assert_redirected_to s_account_path(assigns(:s_account))
  end

  test "should destroy s_account" do
    assert_difference('SAccount.count', -1) do
      delete :destroy, :id => s_accounts(:one).to_param
    end

    assert_redirected_to s_accounts_path
  end
end
