require "test_helper"

module Domain
  module Queries    
    class GetTripleCrownWinnerTest < Minitest::Test
      
      def setup
        @query = Domain::Queries::GetTripleCrownWinner.new
        

        @statistic_repository_mock = mock()
        @query.statistic_repository = @statistic_repository_mock  
        
        @player_repository_mock = mock()
        @query.player_repository = @player_repository_mock    
        @player_repository_mock.stubs(:find).with("PlayerOne").returns(Domain::Entities::Player.new(id: "PlayerOne"))
        @player_repository_mock.stubs(:find).with("PlayerTwo").returns(Domain::Entities::Player.new(id: "PlayerTwo"))                   
      end
      
      def test_get_triple_crown_winner
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 200, doubles: 3, triples: 3, home_runs: 11, runs_batted_in: 6),
          
          Domain::Entities::Statistic.new(player_id: "PlayerThree", year: 2009, league: "AL", team_id: "LAN",
          at_bats: 600, hits: 110, doubles: 3, triples: 3, home_runs: 200, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 150, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),   
          
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2011, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 50, doubles: 3, triples: 3, home_runs: 16, runs_batted_in: 5),         
        ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        
        player = @query.execute('NL', 2009)
        
        assert_equal "PlayerTwo", player.id
      end
      
      def test_return_nil_if_no_winner
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 100, doubles: 3, triples: 3, home_runs: 15, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 600, hits: 200, doubles: 3, triples: 3, home_runs: 11, runs_batted_in: 6),
                 
        ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        
        player = @query.execute('NL', 2009)
        
        assert_nil player
      end
      
      def test_require_mimimum_of_400_at_bats
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 400, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 399, hits: 200, doubles: 3, triples: 3, home_runs: 11, runs_batted_in: 6),      
        ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        
        player = @query.execute('NL', 2009)
        
        assert_equal "PlayerOne", player.id        
      end
    end
  end
end