require "test_helper"

class VehiculosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vehiculos_index_url
    assert_response :success
  end
end
