require 'test_helper'

class IrMessagesControllerTest < ActionController::TestCase
  setup do
    @ir_message = ir_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ir_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ir_message" do
    assert_difference('IrMessage.count') do
      post :create, ir_message: {  }
    end

    assert_redirected_to ir_message_path(assigns(:ir_message))
  end

  test "should show ir_message" do
    get :show, id: @ir_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ir_message
    assert_response :success
  end

  test "should update ir_message" do
    patch :update, id: @ir_message, ir_message: {  }
    assert_redirected_to ir_message_path(assigns(:ir_message))
  end

  test "should destroy ir_message" do
    assert_difference('IrMessage.count', -1) do
      delete :destroy, id: @ir_message
    end

    assert_redirected_to ir_messages_path
  end
end
