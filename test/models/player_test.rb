require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "saves player who happens to be best running back of all time" do
    player = Player.new({ first_name: "Barry", last_name: "Sanders", name_brief: "Barry S.", sport: "football" })
    assert player.save
  end
end
