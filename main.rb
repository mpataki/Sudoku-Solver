#!/usr/bin/env ruby

require 'matrix'
require 'set'
require './hiddenSingles.rb'
require './nakedTuples.rb'

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

class Board 
	def initialize
		@board = Matrix.build(9, 9) {Cell.new}
		@solved_counter = 0
	end

	def print_board
		0.upto(8) {
			|y|
			0.upto(8){
				|x|
				print @board[x,y].value, " "
				if x == 2 || x == 5
					print "| "
				end
			}
			print "\n"
			if y == 2 || y == 5
				puts "---------------------"
			end
		}
	end

	def print_possibilities
		0.upto(8){
			|x|
			0.upto(8){
				|y|
				print "#{x},#{y}: ", @board[x,y].candidates, "\n"
			}
		}
	end

	def board
		@board
	end

	def solved?
		return @solved_counter >= 81
	end

	def find_offset num
		if num <= 2
			0
		elsif num <= 5
			3
		else
			6
		end
	end

	def remove_square_possibilities val, x, y
		xOffset = find_offset(x)
		yOffset = find_offset(y)
		xOffset.upto(xOffset+2){
			|xPos|
			yOffset.upto(yOffset+2){
				|yPos|
				if xPos != x || yPos != y
					val2 = @board[xPos, yPos].remove_candidate(val)
					if val2 != 0
						assign_value(val2, xPos, yPos)
					end
				end
			}
		}
	end

	def remove_linear_possibilities val, x, y
		0.upto(8){
			|k|
			if k != y 
				val2 = @board[x, k].remove_candidate(val)
				if val2 != 0
					assign_value(val2, x, k)
				end
			end
			if k != x
				val2 = @board[k, y].remove_candidate(val)
				if val2 != 0
					assign_value(val2, k, y)
				end
			end
		}
	end

# Find hidden singles and naked pairs
	def find_HS_NT
		0.upto(2) {
			|x|
			0.upto(2){
				|y|
				hidden_singles_block x*3, y*3
				naked_tuple_block x*3, y*3
			}
		}
		0.upto(8){
			|k|
			hidden_singles_row k
			hidden_singles_col k
			naked_tuple_row k
			naked_tuple_col k
		}
	end

	def assign_value val, x, y
		if !@board[x,y].solved
			@board[x,y].value = val
			remove_linear_possibilities val, x, y
			remove_square_possibilities val, x, y
			@solved_counter += 1
		end
	end

	def solved_counter
		@solved_counter
	end

	def read_board
		x = 0
		y = 0
		puts "Enter a puzzle"
		STDIN.read.split(" " || "\n").each do |input|
			i = input.to_i
			if @board[x, y].solved
				puts "read #{input} but was solved as #{@board[x,y].value}" 
			end
			if i >= 1 && i <= 9 && !@board[x, y].solved
				assign_value(input.to_i, x, y)
			end
   			x==8 ? y=(y+1)%9 : nil
   			x = (x+1)%9 
		end
	end
end

# MAIN PROGRAM
puzzle = Board.new
puzzle.read_board
0.upto(300) {
	puzzle.solved? ? break : nil
	puzzle.find_HS_NT
}
puzzle.print_board
puzzle.print_possibilities
puts puzzle.solved_counter