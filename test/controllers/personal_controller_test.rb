require 'test_helper'

class PersonalControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get personal_show_url
    assert_response :success
  end
end
