module Domain
  module Commands   

    class OutputPlayerSluggingPercentages
      attr_writer :get_player_slugging_percentages
      
      def execute(team_id, year)
        puts "Slugging percentages for all players on the #{team_id} in #{year}"
        player_slugging_percentages = get_player_slugging_percentages.execute(team_id, year)
      
        player_slugging_percentages.each do |psp|
          puts "#{psp.player.first_name} #{psp.player.last_name}: #{(psp.percentage * 100).round(2)}%"
        end
      end 
      
      private
      def get_player_slugging_percentages
        @get_player_slugging_percentages ||= Domain::Queries::GetPlayerSluggingPercentages.new
      end
           
    end
  end
end
        