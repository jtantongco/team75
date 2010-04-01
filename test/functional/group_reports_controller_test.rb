require 'test_helper'

class GroupReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_report" do
    assert_difference('GroupReport.count') do
      post :create, :group_report => { }
    end

    assert_redirected_to group_report_path(assigns(:group_report))
  end

  test "should show group_report" do
    get :show, :id => group_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => group_reports(:one).to_param
    assert_response :success
  end

  test "should update group_report" do
    put :update, :id => group_reports(:one).to_param, :group_report => { }
    assert_redirected_to group_report_path(assigns(:group_report))
  end

  test "should destroy group_report" do
    assert_difference('GroupReport.count', -1) do
      delete :destroy, :id => group_reports(:one).to_param
    end

    assert_redirected_to group_reports_path
  end
end
