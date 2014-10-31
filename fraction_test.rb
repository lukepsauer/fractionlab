print "Fraction methods file name? "; file_path = './' + gets[/\w+/] + '.rb'

require file_path

def assert(statement)
	print "Testing: #{statement}... "
	begin
		if yield		
			puts "\tSuccess."
		else
			puts "\tFail!"
		end
	rescue
		puts "\tFail!"
	end
end

assert("Multiply") do
	print "\t1/2 * 2/3 == 1/3"
	[1, 3] == multiply(1, 2, 2, 3)
end

assert("Simplify") do
	print "\t4/12 == 1/3"
	if method(:simplify).parameters.count == 1
		[1, 3] == simplify([4, 12])
	else
		[1, 3] == simplify(4, 12)
	end
end

assert("Add") do 
	print "\t1/2 + 2/3 == 7/6"
	[7, 6] == add(1, 2, 2, 3)
end

assert("Subtract") do 
	print "\t1/2 - 1/5 == 3/10"
	[3, 10] == subtract(1, 2, 1, 5)
end

assert("Divide") do 
	print "\t1/2 / 2/3 = 3/4"
	[3, 4] == divide(1, 2, 2, 3)
end
