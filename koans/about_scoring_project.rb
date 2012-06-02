require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)

	# score 5 single
	def score_5
		return 50
	end

	# score 1 single
	def score_1
		return 100
	end

	# score 3 set except if 1
	def score_3_set(side = 0)
  	return side * 100
	end

	# score 1 3 set, greed
	def score_greed(the_roll = 0, roll_score = 0)
		return 1000
	end

	# intialize an empty dice by nesting arrays into a hash
  the_roll = Hash.new

	# create the dice, see dice dump below block
  (1...7).map { |side| the_roll["#{side}"] = [] }
   the_roll.each { |side,amount|
    dice.select { |value| the_roll["#{value}"].push(value) if value == side.to_i }
  }
	print "Dice init  ", the_roll.inspect, "\n"

  roll_score = 0
  roll_total = 0
	# check how many times they rolled
	print the_roll.inspect, "\n"
  the_roll.each { |side,roll| roll_total += roll.count }

    the_roll.each { |side,rolled|
			if rolled.count >= 3 and (side.to_i != 1)
				roll_score += score_3_set(side.to_i)
				3.times { the_roll["#{side}"].pop }
			elsif rolled.count >= 3 and (side.to_i == 1)
				roll_score += score_greed(side.to_i)
				3.times { the_roll["1"].pop }
			end

			if rolled.count >= 1 and side.to_i == 1
				while not the_roll['1'].empty?
					roll_score += score_1
					the_roll['1'].pop
				end
			end

			if rolled.count >= 1 and side.to_i == 5
				while not the_roll['5'].empty?
					roll_score += score_5
					the_roll['5'].pop
				end
			end

			print "Side ", side,"\n"
			print "Rolled ", rolled,"\n"
			print "The Roll", the_roll.inspect, "\n"
			print "Score ", roll_score, "\n\n"
    }
    print roll_score
    return roll_score
	
end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
