require "test_helper"

class BilleteraControllerTest < ActionDispatch::IntegrationTest
  test "should get mi_billetera" do
    get billetera_mi_billetera_url
    assert_response :success
  end
end
