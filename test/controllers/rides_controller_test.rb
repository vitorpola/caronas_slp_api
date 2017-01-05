require 'test_helper'

class RidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ride = rides(:one)
  end

  test "should get index" do
    get rides_url, as: :json
    assert_response :success
  end

  test "should create ride" do
    assert_difference('Ride.count') do
      post rides_url, params: { ride: { description: @ride.description, driver_id: @ride.driver_id, end_at: @ride.end_at, from_city_id: @ride.from_city_id, from_description: @ride.from_description, from_neighborhood_id: @ride.from_neighborhood_id, start_at: @ride.start_at, status: @ride.status, to_city_id: @ride.to_city_id, to_description: @ride.to_description, to_neighborhood_id: @ride.to_neighborhood_id } }, as: :json
    end

    assert_response 201
  end

  test "should show ride" do
    get ride_url(@ride), as: :json
    assert_response :success
  end

  test "should update ride" do
    patch ride_url(@ride), params: { ride: { description: @ride.description, driver_id: @ride.driver_id, end_at: @ride.end_at, from_city_id: @ride.from_city_id, from_description: @ride.from_description, from_neighborhood_id: @ride.from_neighborhood_id, start_at: @ride.start_at, status: @ride.status, to_city_id: @ride.to_city_id, to_description: @ride.to_description, to_neighborhood_id: @ride.to_neighborhood_id } }, as: :json
    assert_response 200
  end

  test "should destroy ride" do
    assert_difference('Ride.count', -1) do
      delete ride_url(@ride), as: :json
    end

    assert_response 204
  end
end
