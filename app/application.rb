
module App
  class Application
    def run
      output_player_with_most_improved_batting_average
      print "\n"
      output_slugging_percentages
      print "\n"
      output_triple_crown_winners
    end
    
    private
    
    def output_player_with_most_improved_batting_average
      command = Domain::Commands::OutputPlayerWithMostImprovedBattingAverage.new
      command.execute(2009, 2010)
    end
    
    def output_slugging_percentages
      command = Domain::Commands::OutputPlayerSluggingPercentages.new
      command.execute("OAK", 2007)
    end
    
    def output_triple_crown_winners
      command = Domain::Commands::OutputTripleCrownWinner.new
      command.execute("AL", 2011)
      command.execute("NL", 2011)
      command.execute("AL", 2012)
      command.execute("NL", 2012)
    end
  end
end
