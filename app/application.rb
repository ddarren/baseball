
module App
  class Application
    def run
      output_player_with_most_improved_batting_average
      puts ""
      output_slugging_percentages
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
  end
end
