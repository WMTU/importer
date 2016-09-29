require 'test_helper'

class MediaAssetsControllerTest < ActionController::TestCase
  setup do
    @media_asset = media_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_asset" do
    assert_difference('MediaAsset.count') do
      post :create, media_asset: { album: @media_asset.album, artist: @media_asset.artist, audio_file: @media_asset.audio_file, channels: @media_asset.channels, cue: @media_asset.cue, eom: @media_asset.eom, intro: @media_asset.intro, sample_rate: @media_asset.sample_rate, title: @media_asset.title, year: @media_asset.year }
    end

    assert_redirected_to media_asset_path(assigns(:media_asset))
  end

  test "should show media_asset" do
    get :show, id: @media_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @media_asset
    assert_response :success
  end

  test "should update media_asset" do
    patch :update, id: @media_asset, media_asset: { album: @media_asset.album, artist: @media_asset.artist, audio_file: @media_asset.audio_file, channels: @media_asset.channels, cue: @media_asset.cue, eom: @media_asset.eom, intro: @media_asset.intro, sample_rate: @media_asset.sample_rate, title: @media_asset.title, year: @media_asset.year }
    assert_redirected_to media_asset_path(assigns(:media_asset))
  end

  test "should destroy media_asset" do
    assert_difference('MediaAsset.count', -1) do
      delete :destroy, id: @media_asset
    end

    assert_redirected_to media_assets_path
  end
end
