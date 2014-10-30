require "CSV"

module Domain
  module Repositories    
    class StatisticRepository
      attr_writer :csv
      
      def all
        statistics = []
        rows = csv.read("#{$DATA_PATH}/batting_statistics.csv")
        rows.shift
        
        rows.each do |row|
          s = Domain::Entities::Statistic.new
          s.player_id = row[0]
          s.year = row[1].to_i
          s.league = row[2]
          s.team_id = row[3]
          s.at_bats = row[5].nil? ? 0 : row[5].to_i
          s.hits = row[7].nil? ? 0 : row[7].to_i
          s.doubles = row[8].nil? ? 0 : row[8].to_i
          s.triples = row[9].nil? ? 0 : row[9].to_i
          s.home_runs = row[10].nil? ? 0 : row[10].to_i
          s.runs_batted_in = row[11].nil? ? 0 : row[11].to_i
          statistics << s
        end
        
        return statistics
      end
      
      private
      def csv
        @csv ||= CSV
      end
    end      
  end
end
 