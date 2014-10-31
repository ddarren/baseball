
module App
  class Application
    def run
      print_player_with_most_improved_batting_average
      puts ""
      print_slugging_percentages
    end
    
    private
    
    def print_player_with_most_improved_batting_average
      query = Domain::Queries::GetPlayerWithMostImprovedBattingAverage.new
      player = query.execute(2009,2010)
      puts "Player with most improved batting average is: #{player.first_name} #{player.last_name}"
    end
    
    def print_slugging_percentages
      query = Domain::Queries::GetPlayerSluggingPercentages.new
      
      puts "Slugging percentages for all players on the Oakland A's in 2007"
      player_slugging_percentages = query.execute("OAK", 2007)
      
      player_slugging_percentages.each do |psp|
        puts "#{psp.player.first_name} #{psp.player.last_name}: #{psp.percentage * 100}%"
      end
    end
  end
end
