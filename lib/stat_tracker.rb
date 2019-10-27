require_relative './game_collection'
require_relative './team_collection'

class StatTracker
  attr_reader :stats

  def initialize(game_path, team_path, game_team_path)
    # should we move the creation of instances into a method
    @games_collection = GameCollection.new(game_path)
    @teams_collection = TeamCollection.new(team_path, game_team_path)
    #game_teams_path = GameTeamsCollection.new(team_path)

  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_team_path = locations[:game_teams]

    self.new(game_path, team_path, game_team_path)
  end

  def highest_total_score
    @games_collection.highest_total_score
  end

  def lowest_total_score
    @games_collection.lowest_total_score
  end

  def biggest_blowout
    @games_collection.biggest_blowout
  end

  def percentage_home_wins
    @games_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    @games_collection.percentage_visitor_wins
  end

  def percentage_ties
    @games_collection.percentage_ties
  end

  def count_of_games_by_season # rename to count_of_games_by_season to match spec? or is this what is in in specharnes?
    @games_collection.count_of_games_by_season
  end

  def average_goals_per_game
    @games_collection.average_goals_per_game
  end

  def average_goals_by_season
    @games_collection.average_goals_by_season
  end


  def count_of_teams
    @teams_collection.count_of_teams
  end

  def best_offense
    @teams_collection.best_offense
  end

  def worst_offense
    @teams_collection.worst_offense
  end

  def best_defense
    @teams_collection.best_defense
  end

  def worst_defense
    @teams_collection.worst_defense
  end

  def winningest_team
    @teams_collection.winningest_team
  end

  def best_fans
    @teams_collection.best_fans
  end

  def worst_fans
    #need to include more data so we an actually get a list of the worst teams?
    @teams_collection.worst_fans
  end

  def highest_scoring_visitor
    @teams_collection.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @teams_collection.highest_scoring_home_team
  end
end
