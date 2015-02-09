# This is my submission for gjam 2010 1C Problem A. Data Packing
# https://code.google.com/codejam/contest/3014486/dashboard
#

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

cases = in_file.gets.to_i
for i in 1..cases
	n,x = in_file.gets.split(' ').map(&:to_i)
	s = in_file.gets.split(' ').map(&:to_i)

	nbiter = 0
	s = s.sort
	j = n-1
	begin
		#print "j = #{j} \n"
		val = s[j] #this is the heaviest file I have
		# try to find a file I can put together with
		for k in (j-1).downto(0)
			val2 = s[k]
			if( val + val2 <= x )
				#we can put those two together
				s.delete_at(k)
				#print "#{s} \n"
				j = j-1
				break
			end
		end
		nbiter = nbiter + 1
		j = j-1
	end until j < 0
	print nbiter , "\n"
	out_file.write "Case ##{i}: #{nbiter} \n"
end



