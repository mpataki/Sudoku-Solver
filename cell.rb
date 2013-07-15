#!/usr/bin/env ruby

require 'matrix'
require 'set'

class Cell
	def value
		@value
	end

	def value= value
		@value = value
		@candidates.clear
		@candidates << value.to_i
		@solved = true
	end

	def initialize
		@candidates = Set.new [1,2,3,4,5,6,7,8,9]
		@value = " "
		@solved = false
	end

	def solved
		@solved
	end

	# if only one candidate remains, return that value, 
	# otherwise return 0
	def remove_candidate k
		if !@solved
			@candidates.delete k
			if @candidates.size == 1
				return @candidates.to_a[0]
			end
		end
		return 0
	end

	def candidates
		@candidates.to_a
	end
end