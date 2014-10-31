module Domain
  module Entities
    class PlayerSluggingPercentage
      attr_accessor :player
      attr_accessor :percentage
      attr_accessor :year
      
      def initialize(params={})
        params.each do |key, value|
          self.instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end