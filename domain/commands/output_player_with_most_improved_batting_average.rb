module Domain
  module Commands   
     
    class OutputPlayerWithMostImprovedBattingAverage
      attr_writer :get_player_with_most_improved_batting_average
      
      def execute(year_from, year_to)
        player = get_player_with_most_improved_batting_average.execute(year_from, year_to)
        puts "Player with most improved batting average is: #{player.first_name} #{player.last_name}"
      end 
      
      private
      def get_player_with_most_improved_batting_average
        @get_player_with_most_improved_batting_average ||= Domain::Queries::GetPlayerWithMostImprovedBattingAverage.new
      end
           
    end
  end
end
        