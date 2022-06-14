require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)

    @test_player = Player.new({ first_name: "Barry", last_name: "Sanders", name_brief: "Barry S.", position: "RB", sport: "football" })
    @test_player.save
  end

  test "/players/:id" do
    get "/players/#{@test_player.id}"
    assert_response :success
  end

  test "/search" do
    get "/search", params: { sport: "football" }
    assert_response :success
  end

  test "should get index" do
    get players_url, as: :json
    assert_response :success
  end

  # FIXME: for some reason this intermittingly fails ¯\_(ツ)_/¯
  test "should create player" do
    assert_difference("Player.count") do
      post players_url, params: { player: { age: @player.age, first_name: @player.first_name, full_name: @player.full_name, last_name: @player.last_name, position: @player.position, sport: @player.sport } }, as: :json
    end

    assert_response :created
  end

  test "should show player" do
    get player_url(@player), as: :json
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { age: @player.age, first_name: @player.first_name, full_name: @player.full_name, last_name: @player.last_name, position: @player.position, sport: @player.sport } }, as: :json
    assert_response :success
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player), as: :json
    end

    assert_response :no_content
  end
end
