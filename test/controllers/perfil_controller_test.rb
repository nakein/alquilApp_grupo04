require "test_helper"

class PerfilControllerTest < ActionDispatch::IntegrationTest
  test "should get mi_perfil" do
    get perfil_mi_perfil_url
    assert_response :success
  end
end
