module Domain
  module Queries   
     
    class GetTripleCrownWinner
      attr_writer :statistic_repository
      attr_writer :player_repository
    
      PlayerYearCalculation =  Struct.new(:player_id, :hits, :at_bats, :home_runs, :runs_batted_in, :batting_average)
      
      def execute(league, year)  
        statistics = get_statistics(league, year)
      
        player_year_calculations = get_calculations(statistics)
        player_year_calculations = get_calculations_with_at_least_400_at_bats(player_year_calculations)
        
        calculate_batting_averages.execute(player_year_calculations)
           
        return get_triple_crown_winner(player_year_calculations)
      end
      
      private
      def statistic_repository
        @statistic_repository ||= Domain::Repositories::StatisticRepository.new
      end
      
      def player_repository
        @player_repository ||= Domain::Repositories::PlayerRepository.new
      end
      
      def get_statistics(league, year)
        statistics = statistic_repository.all   
        return statistics.select { |s| s.league == league and s.year == year}.to_a
      end
      
      def calculate_batting_averages
        @calculate_batting_averages ||= Domain::Commands::CalculateBattingAverages.new
      end
      
      def get_calculations(statistics)

        calculations = []
        statistics.each do |s|
 
          calculation = get_calculation(s.player_id, calculations)
          
          if calculation.nil?
            calculation = PlayerYearCalculation.new(s.player_id, s.hits, s.at_bats, s.home_runs, s.runs_batted_in, nil)
            calculations << calculation
          else
            calculation.hits += s.hits
            calculation.at_bats += s.at_bats
            calculation.home_runs += s.home_runs
            calculation.runs_batted_in += s.runs_batted_in
          end 
          
        end  
        
        return calculations      
      end
      
      def get_calculations_with_at_least_400_at_bats(calculations)
        calculations.select { |c| c.at_bats >= 400 }
      end
      
      def get_calculation(player_id, calculations)
        calculations.each do |calculation|
          if calculation.player_id == player_id
            return calculation
          end
        end
        
        return nil
      end
      
      def get_triple_crown_winner(player_year_calculations)
        most_home_runs = 0
        most_runs_batted_in = 0
        highest_batting_average = 0
        
        player_year_calculations.each do |c|
          most_home_runs = c.home_runs if c.home_runs > most_home_runs
          most_runs_batted_in = c.runs_batted_in if c.runs_batted_in > most_runs_batted_in
          highest_batting_average = c.batting_average if c.batting_average > highest_batting_average
        end
        
        player_year_calculations.each do |c|
          if c.home_runs == most_home_runs and c.runs_batted_in == most_runs_batted_in and
             c.batting_average == highest_batting_average
             
             player = player_repository.find(c.player_id)
             return player
             
          end
        end
        
        return nil
        
      end
      
    end
  end
end