module Domain
  module Queries   
     
    class GetPlayerSluggingPercentages
      attr_writer :statistic_repository
      attr_writer :player_repository
      
      def execute(team_id, year)
        
        statistics = statistic_repository.all
        
        player_slugging_percentages = []
        
        statistics.each do |statistic|
          next if statistic.team_id != team_id or statistic.year != year 
     
          
          percentage = get_slugging_percentage(statistic)
          player = player_repository.find(statistic.player_id)
          
          player_slugging_percentages << Domain::Entities::PlayerSluggingPercentage.new(player: player, year: statistic.year, 
            percentage: percentage)
          
        end
        
        return player_slugging_percentages  
      end
      
      private
      def statistic_repository
        @statistic_repository ||= Domain::Repositories::StatisticRepository.new
      end
      
      def player_repository
        @player_repository ||= Domain::Repositories::PlayerRepository.new
      end
      
      def get_slugging_percentage(statistic)
        s = statistic
        
        return 0 if s.at_bats == 0
        percentage = ((s.hits - s.doubles - s.triples - s.home_runs) + (2 * s.doubles) + (3 * s.triples) + (4 * s.home_runs)).to_f / s.at_bats.to_f
        
        return percentage
      end
      
    end    
  end
end
