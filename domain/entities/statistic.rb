module Domain
  module Entities
    class Statistic
      attr_accessor :player_id
      attr_accessor :year
      attr_accessor :league
      attr_accessor :team_id
      attr_accessor :at_bats
      attr_accessor :hits
      attr_accessor :doubles
      attr_accessor :triples
      attr_accessor :home_runs
      attr_accessor :runs_batted_in

      def initialize(params={})
        params.each do |key, value|
          self.instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
    
  end
end