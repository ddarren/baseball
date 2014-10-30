require "test_helper"

module Domain
  module Queries    
    class GetPlayerWithMostImprovedBattingAverageTest < Minitest::Test
      
      def setup
        @query = Domain::Queries::GetPlayerWithMostImprovedBattingAverage.new
        

        @statistic_repository_mock = mock()
        @query.statistic_repository = @statistic_repository_mock  
        
        @player_repository_mock = mock()
        @query.player_repository = @player_repository_mock             
             
      end
      
      def test_return_player_with_most_improved_batting_average
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 110, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 150, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),   
          
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2011, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 50, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),         
        ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        player = Domain::Entities::Player.new(id: "PlayerTwo")
        @player_repository_mock.stubs(:find).with("PlayerTwo").returns(player)
        
        player = @query.execute(2009, 2010)     
        
        assert_equal "PlayerTwo", player.id
      end
      
      def test_only_include_players_with_at_last_200_at_bats
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 199, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 110, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 199, hits: 180, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5)        
        ]      
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        player = Domain::Entities::Player.new(id: "PlayerOne")
        @player_repository_mock.stubs(:find).with("PlayerOne").returns(player)
        
        
        player = @query.execute(2009, 2010)     
        
        assert_equal "PlayerOne", player.id
                
      end
      
      def test_assign_zero_for_batting_average_if_at_bats_are_zero
        
        
      end
      
    end      
  end
end
