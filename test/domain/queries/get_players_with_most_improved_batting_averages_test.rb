require "test_helper"

module Domain
  module Queries    
    class GetPlayersWithMostImprovedBattingAveragesTest < Minitest::Test
      
      def test_return_players_with_most_improved_batting_average
        query = Domain::Queries::GetPlayersWithMostImprovedBattingAverages.new
        
        results = query.execute(2009, 2010)     
      end
      
    end      
  end
end
