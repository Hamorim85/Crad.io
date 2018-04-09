require 'test_helper'

class InfluencersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @influencer = influencers(:one)
  end

  test "should get index" do
    get influencers_url
    assert_response :success
  end

  test "should get new" do
    get new_influencer_url
    assert_response :success
  end

  test "should create influencer" do
    assert_difference('Influencer.count') do
      post influencers_url, params: { influencer: { bio: @influencer.bio, country: @influencer.country, email: @influencer.email, external_url: @influencer.external_url, followers_count: @influencer.followers_count, following_count: @influencer.following_count, full_name: @influencer.full_name, igid: @influencer.igid, media_count: @influencer.media_count, photo: @influencer.photo, username: @influencer.username, verified: @influencer.verified } }
    end

    assert_redirected_to influencer_url(Influencer.last)
  end

  test "should show influencer" do
    get influencer_url(@influencer)
    assert_response :success
  end

  test "should get edit" do
    get edit_influencer_url(@influencer)
    assert_response :success
  end

  test "should update influencer" do
    patch influencer_url(@influencer), params: { influencer: { bio: @influencer.bio, country: @influencer.country, email: @influencer.email, external_url: @influencer.external_url, followers_count: @influencer.followers_count, following_count: @influencer.following_count, full_name: @influencer.full_name, igid: @influencer.igid, media_count: @influencer.media_count, photo: @influencer.photo, username: @influencer.username, verified: @influencer.verified } }
    assert_redirected_to influencer_url(@influencer)
  end

  test "should destroy influencer" do
    assert_difference('Influencer.count', -1) do
      delete influencer_url(@influencer)
    end

    assert_redirected_to influencers_url
  end
end
