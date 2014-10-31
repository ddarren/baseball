module Domain
  module Commands   
     
    class OutputTripleCrownWinner
      attr_writer :get_trip_crown_winner
      
      def execute(league, year)
        player = get_trip_crown_winner.execute(league, year)
        winner = player.nil? ? "(No winner)" : "#{player.first_name} #{player.last_name}"
        puts "#{year} #{league} Triple Crown Winner: #{winner}"
      end 
      
      private
      def get_trip_crown_winner
        @get_trip_crown_winner ||= Domain::Queries::GetTripleCrownWinner.new
      end
           
    end
  end
end
        