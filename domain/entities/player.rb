module Domain
  module Entities
    class Player
      attr_accessor :id
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :birth_year
      attr_accessor :slugging_percentage
      
      def initialize(params={})
        params.each do |key, value|
          self.instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end