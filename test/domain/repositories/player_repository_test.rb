require "test_helper"

module Domain
  module Repositories    
    class PlayerRepositoryTest < Minitest::Test
      
      def test_return_player_by_id
        repository = Domain::Repositories::PlayerRepository.new
            
        
        rows = [
          ['playerID', 'birthYear', 'nameFirst', 'nameLast'],
          ['aaronto01', '1939', 'Tommie', 'Aaron'],
          ['aasedo01', '1954','Don', 'Aase']
        ]
        
        csv = mock()
        csv.stubs(:read).returns(rows)
        repository.csv = csv
        
        player = repository.find('aasedo01')
        
        assert_equal 'aasedo01', player.id
        assert_equal '1954', player.birth_year
        assert_equal 'Don', player.first_name
        assert_equal 'Aase', player.last_name
        
      end      
      

    end      
  end
end
 