require "CSV"

module Domain
  module Repositories    
    class PlayerRepository
      attr_writer :csv
      
      def find(id)
        rows = csv.read("#{$DATA_PATH}/players.csv")
        rows.shift
        
        player = nil
        
        rows.each do |row|
          if row[0] == id
            player = Domain::Entities::Player.new(id: row[0], birth_year: row[1], first_name: row[2], last_name: row[3])         
            break
          end
        end
        
        return player
      end
      
      private
      def csv
        @csv ||= CSV
      end
    end      
  end
end
 