require 'test_helper'

class CreationCenterControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get creation_center_home_url
    assert_response :success
  end

end
