defmodule Dennis.ChallengeFinisher do
	alias Dennis.Challenge

	@a_day :calendar.time_to_seconds({24, 0, 0}) * 1000
	# :timer.sleep receives miliseconds

	def set_finisher do
	  {_, now} = :calendar.universal_time
	  now = :calendar.time_to_seconds(now) * 1000
	  until_midnight = @a_day - now
	  :timer.sleep(until_midnight)
	  finish
	end

	def finish do
  	  Challenge.finish_challenges
  	  :timer.sleep(@a_day)
  	  finish
	end
end