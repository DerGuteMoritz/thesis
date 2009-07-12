require 'test_helper'

class ContributionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contributions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contribution" do
    assert_difference('Contribution.count') do
      post :create, :contribution => { }
    end

    assert_redirected_to contribution_path(assigns(:contribution))
  end

  test "should show contribution" do
    get :show, :id => contributions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => contributions(:one).to_param
    assert_response :success
  end

  test "should update contribution" do
    put :update, :id => contributions(:one).to_param, :contribution => { }
    assert_redirected_to contribution_path(assigns(:contribution))
  end

  test "should destroy contribution" do
    assert_difference('Contribution.count', -1) do
      delete :destroy, :id => contributions(:one).to_param
    end

    assert_redirected_to contributions_path
  end
end
