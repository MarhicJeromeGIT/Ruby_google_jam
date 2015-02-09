# This is my submission for gjam 2010 1A Problem A. File Fix-it
# https://code.google.com/codejam/contest/635101/dashboard#s=p0
#
# ruby gjam_2010_1B input.txt output.txt

#expand the directory into the (unique) list
#of subdirectories : 
#a/b/c -> a/ + a/b + a/b/c
#return the number of subdirectories needed
def expand(directories)
	result = []
	directories.each do |path|
		splt = path.split('/')
		splt.shift # removing the leading "/"
		current_path = ""
		splt.each do |dir|
			current_path = current_path + "/" + dir
			result << current_path
		end
	end
	result = result.uniq
	return result
end

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

cases = in_file.gets.to_i
for i in 1..cases #cases
	nm = in_file.gets
	n = nm.split(' ').first.to_i;
	m = nm.split(' ').last.to_i;
	existing = Array.new
	for j in 0..n-1
		existing.push( in_file.gets.chomp )
	end
	newdir = Array.new
	for j in 0..m-1
		newdir.push( in_file.gets.chomp )
	end
	
	unique_dir = expand( newdir )
	needed_dir = unique_dir - existing
	
	out_file.write "Case ##{i}: #{needed_dir.length}\n"
end

