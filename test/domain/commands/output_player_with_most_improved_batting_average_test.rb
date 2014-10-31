require "test_helper"

module Domain
  module Commands    
    class OutputPlayerWithMostImprovedBattingAverageTest < Minitest::Test

      def setup
        $stdout = StringIO.new
      end

      def test_should_output_player
        command = Domain::Commands::OutputPlayerWithMostImprovedBattingAverage.new
        query_mock = mock()
        query_mock.stubs(:execute).with(2009,2010).returns(Domain::Entities::Player.new(first_name: "Homer", last_name: "Simpson"))
        command.get_player_with_most_improved_batting_average = query_mock
        
        command.execute(2009, 2010)
        
        assert $stdout.string.include?("Homer Simpson")
      end
    end
  end
end