require "test_helper"

module Domain
  module Queries    
    class GetPlayerSluggingPercentagesTest < Minitest::Test
      
      def setup
        @query = Domain::Queries::GetPlayerSluggingPercentages.new
        

        @statistic_repository_mock = mock()
        @query.statistic_repository = @statistic_repository_mock  
        
        @player_repository_mock = mock()
        @query.player_repository = @player_repository_mock  
        @player_repository_mock.stubs(:find).with("PlayerOne").returns(Domain::Entities::Player.new(id: "PlayerOne"))
        @player_repository_mock.stubs(:find).with("PlayerTwo").returns(Domain::Entities::Player.new(id: "PlayerTwo"))           
             
      end
      
      def test_return_correct_player_slugging_percentages
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 100, doubles: 3, triples: 4, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 296, hits: 100, doubles: 3, triples: 6, home_runs: 11, runs_batted_in: 5),
          
          Domain::Entities::Statistic.new(player_id: "PlayerThree", year: 2009, league: "NL", team_id: "ABC",
          at_bats: 300, hits: 110, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),
          Domain::Entities::Statistic.new(player_id: "PlayerTwo", year: 2010, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 150, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),   
          
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2011, league: "NL", team_id: "LAN",
          at_bats: 300, hits: 50, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5),         
        ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)

        
        player_sluggin_percentages = @query.execute("LAN", 2009)  
        
        assert 2, player_sluggin_percentages.length
       

         
        assert_equal "PlayerOne", player_sluggin_percentages[0].player.id
        # ((100 - 3 - 4 - 10) + (2 * 3) + (3 * 4) + (4 * 10)) / 300
        # (83 + 6 + 12 + 40) / 300 = 0.47
        assert_equal 0.47, player_sluggin_percentages[0].percentage
               
        # ((100 - 3 - 6 - 11) + (2 * 3) + (3 * 6) + (4 * 11)) / 300
        # 80 + 6 + 18 + 44 / 296 = .5      
        assert_equal "PlayerTwo", player_sluggin_percentages[1].player.id
        assert_equal 0.5, player_sluggin_percentages[1].percentage
        
        
      end
      
      def test_set_slugging_percentage_to_zero_if_there_are_no_at_bats
        statistics = [
          Domain::Entities::Statistic.new(player_id: "PlayerOne", year: 2009, league: "NL", team_id: "LAN",
          at_bats: 0, hits: 100, doubles: 3, triples: 3, home_runs: 10, runs_batted_in: 5) ]
        
        @statistic_repository_mock.stubs(:all).returns(statistics)
        
        player_sluggin_percentages = @query.execute("LAN", 2009)  
        
        assert_equal "PlayerOne", player_sluggin_percentages[0].player.id
        assert_equal 0, player_sluggin_percentages[0].percentage
        
        
      end
    end
  end
end