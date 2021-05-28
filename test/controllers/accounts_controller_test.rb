require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get accounts_name:string_url
    assert_response :success
  end

  test "should get description:text" do
    get accounts_description:text_url
    assert_response :success
  end

end
