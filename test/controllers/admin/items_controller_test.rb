require 'test_helper'

class Admin::ItemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_items_index_url
    assert_response :success
  end

  test 'should get edit' do
    get admin_items_edit_url
    assert_response :success
  end
end
