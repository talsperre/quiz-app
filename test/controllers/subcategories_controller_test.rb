require 'test_helper'

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subcategories_new_url
    assert_response :success
  end

end
