require './test/test_helper'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test
  def setup
    @game_team_collection = GameTeamCollection.new("./test/data/game_teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_has_total_game_team
    assert_equal 40, @game_team_collection.total_game_teams.length
  end
end