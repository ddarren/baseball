require "test_helper"

module Domain
  module Commands    
    class OutputTripleCrownWinnerTest < Minitest::Test

      def setup
        $stdout = StringIO.new
      end

      def test_should_output_triple_crown_winner
        command = Domain::Commands::OutputTripleCrownWinner.new
        query_mock = mock()
        query_mock.stubs(:execute).with("AL",2010).returns(Domain::Entities::Player.new(first_name: "Homer", last_name: "Simpson"))
        command.get_trip_crown_winner = query_mock
        
        command.execute("AL", 2010)
        
        assert $stdout.string.include?("Homer Simpson")
        assert $stdout.string.include?("2010")
        assert $stdout.string.include?("AL")
      end
    end
  end
end