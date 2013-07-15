#!/usr/bin/env ruby

require 'matrix'
require 'set'
require './cell.rb'
require './board.rb'

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