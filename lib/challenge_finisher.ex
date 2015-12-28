defmodule Dennis.ChallengeFinisher do
	alias Dennis.ChallengeController

	@a_day :calendar.time_to_seconds({24, 0, 0}) * 1000
	# :timer.sleep receives miliseconds

	def set_finisher do
	  {_, now} = :calendar.local_time
	  now = :calendar.time_to_seconds(now) * 1000
	  until_midnight = @a_day - now
	  #:timer.sleep(until_midnight)
	  :timer.sleep(35000)
	  finish
	end

	def finish do
  	  ChallengeController.finish
  	  :timer.sleep(35000)
  	  finish
	end
end