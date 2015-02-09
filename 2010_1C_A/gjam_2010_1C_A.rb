# This is my submission for gjam 2010 1C Problem A. Rope Intranet
# https://code.google.com/codejam/contest/619102/dashboard#s=p0
#
# ruby gjam_2010_1C_A input.txt output.txt

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

cases = in_file.gets.to_i
for i in 1..cases #cases
	n = in_file.gets.to_i
	h = Hash.new
	for l in 0..n-1
		line = in_file.gets.split(' ')
		puts "line = #{line}"
		h[ line[0].to_i ] = line[1].to_i
	end

	nbCross = 0
	# count how many time each line intersects, ie
	# the left endpoint is below and the top endpoint is above
	h.each{ |left1,right1|
		h.each{ |left2,right2|
			if( left1 < left2 && right1 > right2 )
				nbCross = nbCross + 1
			end
		}
	}
	
	out_file.write "Case ##{i}: #{nbCross} \n"
end


