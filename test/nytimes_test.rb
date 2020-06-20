require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/nytimes'

class NytimesTest < Minitest::Test
  attr_reader :hash

  def setup
    @hash = Nytimes::DATA
  end

  def test_it_can_get_copyright
    assert @hash[:copyright], "Copyright (c) 2018 The New York Times Company. All Rights Reserved."
  end

  def test_it_can_get_array_of_stories
    assert @hash[:results].is_a? (Array)
    assert_equal 44, @hash[:results].count
  end

  def test_it_can_get_all_stories_with_subsection_of_politics
    politics = []
    @hash[:results].each do |result|
      if result[:subsection]== "Politics"
        politics << result
      end
    end
    assert politics.is_a? (Array)
    assert_equal 6, politics.count
    assert_equal "Congressional G.O.P. Agenda Quietly Falls Into Place Even as Trump Steals the Spotlight",
      politics.first[:title]
    assert_equal "Conspiracy Theories Made Alex Jones Very Rich. They May Bring Him Down.",
      politics.last[:title]
  end

end
