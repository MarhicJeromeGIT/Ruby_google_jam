# This is my submission for gjam 2010 1C Problem B. Load Testing
# https://code.google.com/codejam/contest/619102/dashboard#s=p1
#
# ruby gjam_2010_1C_B input.txt output.txt


def solve(l,p,c)
	if( l*c >= p )
		return 0
	else 
		#the optimal strategy is to pick the
		#geometric mean and not the average
		mean = Math.sqrt(l*p)
		# pick a = c * l :
		val1 = solve(mean,p,c)
		# pick a = p / c :
		val2 = solve(l,mean,c)
		
		return 1 + [val1,val2].max
	end
end

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

cases = in_file.gets.to_i
for i in 1..cases
	l,p,c = in_file.gets.split(' ').map(&:to_i)
	
	# we are looking for a so that
	# l < a and
	# a * c < p
	# 
	# 1 load Test -> 1 potential as 
	out_file.write "Case ##{i}: #{solve(l,p,c)} \n"
end



