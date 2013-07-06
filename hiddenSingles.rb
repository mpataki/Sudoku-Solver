#!/usr/bin/env ruby

# Uses the same technique as in the simpler row and column versions below
	def hidden_singles_block x, y
		xOffset = find_offset(x)
		yOffset = find_offset(y)
		arr = Array.new
		xOffset.upto(xOffset+2){
			|x|
			yOffset.upto(yOffset+2){
				|y|
				if !@board[x,y].solved 
					@board[x,y].candidates.each {
						|elm|
						if arr[elm] == nil
							arr[elm] = [x,y]
						else  
							arr[elm] = -1
						end
					}
				end
			}
		}
		1.upto(9){
			|i|
			if arr[i] != nil && arr[i] != -1
				assign_value(i, arr[i][0], arr[i][1])
			end
		}
	end

	# The array is used as follows: Each index position represents a possible value,
	# and the value stored at that index is the y coordinate of where the value occurs.
	# If a value exists as a candidate in more than one y coordinate, the index position
	# will be set to -1 since we are only looking for singles. Once we have looked at the
	# whole row any array position not equal to nil or -1 are singles, and can be assigned.
	def hidden_singles_row y
		arr = Array.new
		0.upto(8) {
			|x|
			if !@board[x,y].solved
				@board[x,y].candidates.each {
					|elm|
					if arr[elm] == nil
						arr[elm] = x
					else  
						arr[elm] = -1
					end
				}
			end
		}
		1.upto(9){
			|i|
			if arr[i] != nil && arr[i] != -1
				assign_value(i, arr[i], y)
			end
		}
	end

	# Works the same as hidden_singles_row above.
	def hidden_singles_col x
		arr = Array.new
		0.upto(8) {
			|y|
			if !@board[x,y].solved
				@board[x,y].candidates.each {
					|elm|
					if arr[elm] == nil
						arr[elm] = y
					else  
						arr[elm] = -1
					end
				}
			end
		}
		1.upto(9){
			|i|
			if arr[i] != nil && arr[i] != -1
				assign_value(i, x, arr[i])
			end
		}
	end