require "test_helper"

module Domain
  module Commands    
    class OutputPlayerSluggingPercentagesTest < Minitest::Test

      def setup
        $stdout = StringIO.new
      end

      def test_output_slugging_percentages
        command = Domain::Commands::OutputPlayerSluggingPercentages.new
        query_mock = mock()
        
        player1 = Domain::Entities::Player.new(first_name: "Homer", last_name: "Simpson")
        player2 = Domain::Entities::Player.new(first_name: "Ed", last_name: "Flanders")
        
        
        percentages = [
          Domain::Entities::PlayerSluggingPercentage.new(player: player1, percentage: 0.23),
          Domain::Entities::PlayerSluggingPercentage.new(player: player2, percentage: 0.87)
        ]
        
        query_mock.stubs(:execute).with("OAK",2010).returns(percentages)
        command.get_player_slugging_percentages = query_mock
        
        command.execute("OAK", 2010)
        
        assert $stdout.string.include?("Homer Simpson")
        assert $stdout.string.include?("Ed Flanders")
        assert $stdout.string.include?("23.0%")
        assert $stdout.string.include?("87.0%")
      end
    end
  end
end