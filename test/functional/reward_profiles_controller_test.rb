require 'test_helper'

class RewardProfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reward_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reward_profile" do
    assert_difference('RewardProfile.count') do
      post :create, :reward_profile => { }
    end

    assert_redirected_to reward_profile_path(assigns(:reward_profile))
  end

  test "should show reward_profile" do
    get :show, :id => reward_profiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reward_profiles(:one).to_param
    assert_response :success
  end

  test "should update reward_profile" do
    put :update, :id => reward_profiles(:one).to_param, :reward_profile => { }
    assert_redirected_to reward_profile_path(assigns(:reward_profile))
  end

  test "should destroy reward_profile" do
    assert_difference('RewardProfile.count', -1) do
      delete :destroy, :id => reward_profiles(:one).to_param
    end

    assert_redirected_to reward_profiles_path
  end
end
