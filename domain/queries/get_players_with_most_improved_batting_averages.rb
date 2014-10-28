require "CSV"

module Domain
  module Queries    
    class GetPlayersWithMostImprovedBattingAverages
      attr_writer :csv
      
      def execute(from_year, to_year)
        csv.foreach("#{$DATA_PATH}/batting.csv") do |row|
          puts row.to_s
        end
      end
      
      private
      def csv
        @csv ||= CSV
      end
    end      
  end
end
