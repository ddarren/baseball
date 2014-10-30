
module App
  class Application
    def run
      query = Domain::Queries::GetPlayerWithMostImprovedBattingAverage.new
      player = query.execute(2009,2010)
      puts "Player with most improved batting average is: #{player.first_name} #{player.last_name}"
    end
  end
end
