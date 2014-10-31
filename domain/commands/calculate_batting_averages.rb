module Domain
  module Commands   
     
    class CalculateBattingAverages
      
      def execute(calculations)
        calculations.each do |calculation|
          calculation.batting_average = (calculation.hits.to_f / calculation.at_bats.to_f)
        end       
      end
      
    end
  end
end
        