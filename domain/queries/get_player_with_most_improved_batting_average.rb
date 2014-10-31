module Domain
  module Queries   
     
    class GetPlayerWithMostImprovedBattingAverage
      attr_writer :statistic_repository
      attr_writer :player_repository
      
      ImprovementPercentage = Struct.new(:player_id, :percentage)
      YearCalculation =  Struct.new(:player_id, :hits, :at_bats, :batting_average)
      
      def execute(from_year, to_year)
        
        statistics = statistic_repository.all
        
        from_year_calculations = get_calculations(statistics, from_year)
        to_year_calculations = get_calculations(statistics, to_year)
        
        calculate_batting_averages!(from_year_calculations)
        calculate_batting_averages!(to_year_calculations)
        
        improvement_percentage = get_highest_improvement_percentage(from_year_calculations, to_year_calculations)
        
        player = player_repository.find(improvement_percentage.player_id)
        
        return player

      end
      
      private
      def statistic_repository
        @statistic_repository ||= Domain::Repositories::StatisticRepository.new
      end
      
      def player_repository
        @player_repository ||= Domain::Repositories::PlayerRepository.new
      end
      
      def get_calculations(statistics, year)

        calculations = []
        statistics.each do |statistic|
          unless statistic.year == year
            next
          end
            
          calculation = get_calculation(statistic.player_id, calculations)
          
          if calculation.nil?
            calculation = YearCalculation.new(statistic.player_id, statistic.hits, statistic.at_bats, nil)
            calculations << calculation
          else
            calculation.hits = statistic.hits
            calculation.at_bats = statistic.at_bats
          end 
          
        end  
        
        return calculations      
      end
      
      def get_calculation(player_id, calculations)
        calculations.each do |calculation|
          if calculation.player_id == player_id
            return calculation
          end
        end
        
        return nil
      end
      
      def calculate_batting_averages!(calculations)
        calculations.each do |calculation|
          
          calculation.batting_average = (calculation.hits.to_f / calculation.at_bats.to_f)
        end
      end
      
      def get_highest_improvement_percentage(from_year_calculations, to_year_calculations)

        highest_improvement_percentage = nil
        
        from_year_calculations.each do |from_year_calculation|
          to_year_calculation = get_calculation(from_year_calculation.player_id, to_year_calculations)
          
          if to_year_calculation.nil?
            next
          end
          
          unless at_least_two_hundred_at_bats?(from_year_calculation, to_year_calculation)
            next
          end
          
          improvement_percentage = get_improvement_percentage(from_year_calculation, to_year_calculation)
        
          if highest_improvement_percentage.nil? or improvement_percentage.percentage > highest_improvement_percentage.percentage
            
            highest_improvement_percentage = improvement_percentage
          end

        end
        
        return highest_improvement_percentage     
      end
      
      
      def at_least_two_hundred_at_bats?(from_year_calculation, to_year_calculation)
        return (from_year_calculation.at_bats >= 200 and to_year_calculation.at_bats >= 200)
      end
      
      def get_improvement_percentage(from_year_calculation, to_year_calculation)
        player_id = from_year_calculation.player_id
        
        percentage_change = (to_year_calculation.batting_average - from_year_calculation.batting_average) / from_year_calculation.batting_average
        
        return  ImprovementPercentage.new(player_id, percentage_change)

      end
      

    end    
  end
end
