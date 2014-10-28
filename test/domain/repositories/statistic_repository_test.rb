require "test_helper"

module Domain
  module Repositories    
    class StatisticRepositoryTest < Minitest::Test
      def test_return_all_statisitcs
        repository = Domain::Repositories::StatisticRepository.new
            
        
        rows = [
          ['playerID','yearID','league','teamID','G','AB','R','H','2B','3B','HR','RBI','SB','CS'],
          ['abreubo01','2008','AL','NYA','156','609','100','180','39','4','20','100','22','11']
        ]
        
        csv = mock()
        csv.stubs(:read).returns(rows)
        repository.csv = csv
        
        statistics = repository.all
        
        assert_equal 'abreubo01', statistics[0].player_id
        assert_equal 2008, statistics[0].year
        assert_equal 'AL', statistics[0].league
        assert_equal 'NYA', statistics[0].team_id
        assert_equal 609, statistics[0].at_bats
        assert_equal 180, statistics[0].hits
        assert_equal 39, statistics[0].doubles
        assert_equal 4, statistics[0].triples
        assert_equal 20, statistics[0].home_runs
        assert_equal 100, statistics[0].runs_batted_in
      end      
    end      
  end
end
 