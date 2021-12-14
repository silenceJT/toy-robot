class Table
	attr_reader :row, :col
	
	def initialize(row, col)
		if row.is_a? Integer and col.is_a? Integer
			@row = row - 1
			@col = col - 1
		else
			raise TypeError, 'Invalid row or col.' 
		end
	end
end