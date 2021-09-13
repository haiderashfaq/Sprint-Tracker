require "test_helper"

class ListcompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get listcompanies_index_url
    assert_response :success
  end

  test "should get show" do
    get listcompanies_show_url
    assert_response :success
  end

  test "should get new" do
    get listcompanies_new_url
    assert_response :success
  end

  test "should get create" do
    get listcompanies_create_url
    assert_response :success
  end

  test "should get edit" do
    get listcompanies_edit_url
    assert_response :success
  end

  test "should get update" do
    get listcompanies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get listcompanies_destroy_url
    assert_response :success
  end
end
