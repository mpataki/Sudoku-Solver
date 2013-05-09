#!/usr/bin/env ruby

require 'matrix'
require 'set'

class Cell
	def value
		@value
	end

	def value= value
		@value = value
	end

	def initialize()
		@possible_values = Set.new [1,2,3,4,5,6,7,8,9]
		@value = " "
	end

	# if only one possibility remains, return that value, otherwise return 0
	def remove_possibility(k)
		@possible_values.delete(k) 
		if @possible_values.size == 1 && @value == " "
			@possible_values.to_a[0]
		else 0 end
	end

	def possible_values
		@possible_values.to_a
	end
end

class Board 
	def initialize()
		@board = Matrix.build(9, 9) {Cell.new}
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

	def board
		@board
	end

	def assign_value val, x, y
		@board[x,y].value = val
		#remove linear possibilities
		0.upto(8){
			|k|
			val2 = @board[x, k].remove_possibility(val.to_i)
			if val2 != 0
				assign_value(val2, x, k)
			end
			val2 = @board[k, y].remove_possibility(val.to_i)
			if val2 != 0
				assign_value(val2, k, y)
			end
		}
		#remove square possibilities
		if x <= 2
			xOffset = 0
		elsif x <= 5
			xOffset = 3
		else
			xOffset = 6
		end
		if y <= 2
			yOffset = 0
		elsif y <= 5
			yOffset = 3
		else
			yOffset = 6
		end
		0.upto(2){
			|xPos|
			0.upto(2){
				|yPos|
				val2 = @board[xPos+xOffset, yPos+yOffset].remove_possibility(val.to_i)
				if val2 != 0
					assign_value(val2, xPos+xOffset, yPos+yOffset)
				end
			}
		}

	end

	def read_board
		x = 0
		y = 0
		puts "Enter a puzzle"
		STDIN.read.split(" " || "\n").each do |input|
			i = input.to_i
			if i >= 1 && i <= 9
				assign_value(input, x, y)
			end
   			x==8 ? y=(y+1)%9 : nil
   			x = (x+1)%9 
		end
	end
end

# MAIN PROGRAM
puzzle = Board.new
puzzle.read_board
puzzle.print_board