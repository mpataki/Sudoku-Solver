#!/usr/bin/env ruby

require 'matrix'
require 'set'

class Cell
	def value
		@value
	end

	def value= value
		@value = value
		remove_possibility(value.to_i)
	end

	def initialize()
		@possible_values = Set.new [1,2,3,4,5,6,7,8,9]
		@value = " "
	end

	def remove_possibility(k)
		@possible_values.delete(k)
	end

	def possible_values
		@possible_values.to_a
	end
end

def print_board board
	0.upto(8) {
		|y|
		0.upto(8){
			|x|
			print board[x,y].value, " "
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

def read_board board
	x = 0
	y = 0
	puts "Enter a puzzle"
	STDIN.read.split(" " || "\n").each do |input|
		i = input.to_i
		if i >= 1 && i <= 9
			board[x,y].value = input
		end
   		x==8 ? y=(y+1)%9 : nil
   		x = (x+1)%9 
	end
end

# MAIN PROGRAM
board = Matrix.build(9, 9) {Cell.new}
read_board board
print_board(board)
print board[0,0].possible_values, "\n"


























