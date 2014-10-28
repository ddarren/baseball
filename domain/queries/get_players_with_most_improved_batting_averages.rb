require "CSV"

module Domain
  module Queries    
    class GetPlayersWithMostImprovedBattingAverages
      
      def execute(from_year, to_year)
        CSV.foreach("#{$DATA_PATH}/batting.csv") do |row|
          puts row.to_s
        end
      end
      
    end      
  end
end
