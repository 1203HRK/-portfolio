require 'test_helper'

class Admin::PersonalsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_personals_index_url
    assert_response :success
  end

  test 'should get edit' do
    get admin_personals_edit_url
    assert_response :success
  end
end
