require 'csv'
require_relative './game.rb'

class GameCollection
  attr_reader :total_games

  def initialize(game_path)
    @total_games = create_games(game_path)
  end

# created class method in Game to find all_games
  def create_games(game_path)
    csv = CSV.read(game_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  #method to sort by total goals
  #max_by { \game| game. away + game. home}
  #min_by ""
  # OR just sort game_sums and pull the first/last
  def highest_total_score
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max_by { |sum| sum }
  end

  def lowest_total_score
    #game_sums has been used the same twice now
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min_by { |sum| sum }
  end

  def biggest_blowout
    game_differences = @total_games.map do |game|
      (game.home_goals - game.away_goals).abs
    end
    game_differences.max_by { |difference| difference }
  end

  def percentage_home_wins
    home_wins = @total_games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / @total_games.length * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @total_games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / @total_games.length * 100).round(2)
  end

  def percentage_ties
    ties_count = @total_games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count / @total_games.count.to_f).round(2)
  end

  def count_of_games_by_season
    count_games_by_season_list = {}
    @total_games.each do |game|
      count_games_by_season_list[game.season] = 0
    end
    @total_games.each do |game|
      count_games_by_season_list[game.season] += 1
    end
    return count_games_by_season_list
  end

  def average_goals_per_game
    total_goals = 0
    @total_games.each do |game|
      total_goals += game.home_goals
      total_goals += game.away_goals
    end
    (total_goals / @total_games.count.to_f).round(2)
  end

  def away_team_goals
    team_away_goal = 0
    away_team_goal_count = @total_games.each do |game|
      # require "pry"; binding.pry
      game.team_id == team_id
      team_away_goal += game.away_goals
    end
  end

  def group_by_team_id_and_goals
    away_team_groups = @total_games.flat_map { |game| game.away_team_id}
    away_team_goals = @total_games.flat_map { |game| game.away_goals}
    away_team_id_goals = away_team_groups.zip(away_team_goals)
    require "pry"; binding.pry
  end

  def average_goals_by_season
    season_list = count_of_games_by_season
    season_list.transform_values! do |total_season_games|
      [total_season_games, 0]
      # transforming hash so that..
      # Season (key value) = [total games of season, total goals of season]
      # transform again dividing goals/games to get average for each season
    end
    @total_games.each do |game|
      season_list[game.season][1] += game.home_goals
      season_list[game.season][1] += game.away_goals
    end
    season_list.transform_values do |total_season_games|
      (total_season_games[1] / total_season_games[0].to_f).round(2)
    end
  end

end
