#!/usr/bin/env ruby

def naked_tuple_eliminate_block x, y, cands
		xOffset = find_offset(x)
		yOffset = find_offset(y)
		xOffset.upto(xOffset+2){
			|x|
			yOffset.upto(yOffset+2){
				|y|
				if @board[x,y].candidates != cands 
					cands.each {
						|cand|
						@board[x,y].remove_candidate cand
					}
				end		
			}
		}
	end

	def naked_tuple_block x, y
		xOffset = find_offset(x)
		yOffset = find_offset(y)
		xOffset.upto(xOffset+2){
			|x|
			yOffset.upto(yOffset+2){
				|y|
				cands = @board[x,y].candidates
				counter = @board[x,y].candidates.size 
				xOffset.upto(xOffset+2){
					|x2|
					yOffset.upto(yOffset+2){
						|y2|
						if @board[x2,y2].candidates == cands
							counter = counter - 1
							if counter == 0
								naked_tuple_eliminate_block x2, y2, cands
							end
						end
					}
				}
			}
		}
	end

	def naked_tuple_eliminate_col x, cands
		0.upto(8) {
			|y|
			if @board[x,y].candidates != cands 
				cands.each {
					|cand|
					@board[x,y].remove_candidate cand
				}
			end
		}
	end

	def naked_tuple_col x
		0.upto(7) {
			|y|
			cands = @board[x,y].candidates
			counter = @board[x,y].candidates.size - 1
			(y+1).upto(7) {
				|y2|
				if @board[x,y2].candidates == cands
					counter = counter - 1
					if counter == 0
						naked_tuple_eliminate_col x, cands
					end
				end
			}
		}
	end

	def naked_tuple_eliminate_row y, cands
		0.upto(8) {
			|x|
			if @board[x,y].candidates != cands
				cands.each {
					|cand|
					@board[x,y].remove_candidate cand
				}
			end
		}
	end

	def naked_tuple_row y
		0.upto(7) {
			|x|
			cands = @board[x,y].candidates
			counter = @board[x,y].candidates.size - 1
			(x+1).upto(7) {
				|x2|
				if @board[x2,y].candidates == cands
					counter = counter - 1
					if counter == 0
						naked_tuple_eliminate_row y, cands
					end
				end
			}
		}
	end