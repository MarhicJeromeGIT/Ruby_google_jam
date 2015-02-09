# This is my submission for gjam 2010 1A
# https://code.google.com/codejam/contest/544101/dashboard#s=p0
#
# ruby gjam_2010_1A input.txt output.txt

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

#rotate an array
def rotate(array)
	n = array.length
	a = Array.new(n) { Array.new(n, '.') }
	for i in 0..n-1
		#lines become columns
		column = array.map {|row| row[i]}
		a[i] = column.reverse
	end
	return a
end

#apply gravity to an array
def gravity(array)
	n = array.length
	a = Array.new(n) { Array.new(n, '.') }
	for i in 0..n-1
		c = array.map{|row| row[i]}
		d = c.delete_if{|x| x == '.'}
		# pad the beginning ('top') of the array with '.'
		nbdot = n - d.length
		#d = d.unshift('.'*nbdot)
		nbdot.times { d.unshift('.') }
		
		# write the results to the column of a
		for col in 0..n-1
			a[col][i] = d[col]
		end
	end
	
	for i in 0..n-1
		for j in 0..n-1
			print a[i][j]
		end
		print "\n"
	end
	
	return a
end

#helper function, return true if there is a succession of k
# 'x' elements in the array :
def success(array1D,x,k)
	n = array1D.length
	if n < k 
		return false
	end
	
	for i in 0..n-k+1
		if array1D[i] == x 
			s = true
			# check if the following k-1 elements are identical
			for j in 1..k-1
				if array1D[i+j] != x
					s = false
					break
				end
			end
			if s == true
				return true
			end
		end
	end
	return false
end

#return the winner as a string(ie "Neither", "Both", "Red" or "Blue")
def winner(array,k)
	blue = false
	red  = false
	n = array.length
	#check all the potential winning conditions...
	for i in 0..n-1
		# check columns and rows
		blue |= success( array[i], 'B', k)
		blue |= success( array.map{|row| row[i]}, 'B', k)
		red  |= success( array[i], 'R', k)
		red  |= success( array.map{|row| row[i]}, 'R', k)
		#check the diagonals
		# ie [0,0], ([0,1],[2,0]), etc
		d = Array.new(i,'.')
		e = Array.new(i,'.')
		f = Array.new(i,'.')
		g = Array.new(i,'.')
		for j in 0..i
			# diagonals to the right
			d[j] = array[j][i-j]
			e[j] = array[n-1-j][i-j]
			# diagonals to the left
			f[j] = array[j][n-1-(i-j)]
			g[j] = array[n-1-j][n-1-(i-j)]
		end
		
		blue |= success( d, 'B', k)
		red  |= success( d, 'R', k)
		blue |= success( e, 'B', k)
		red  |= success( e, 'R', k)
		blue |= success( f, 'B', k)
		red  |= success( f, 'R', k)
		blue |= success( g, 'B', k)
		red  |= success( g, 'R', k)

	end
	
	if( !red && !blue )
		return "Neither"
	elsif( red && blue )
		return "Both"
	elsif( red )
		return "Red"
	elsif( blue )
		return "Blue"
	end
end

cases = in_file.gets.to_i
for i in 1..cases
	nk = in_file.gets
	n = nk.split(' ').first.to_i
	k = nk.split(' ').last.to_i
	
	#create and fill a n*n array
	array = Array.new(n){ in_file.gets.chomp.split('') }
	r = gravity( rotate(array) )
	out_file.write "Case ##{i}: #{winner(r,k)} \n"
end

