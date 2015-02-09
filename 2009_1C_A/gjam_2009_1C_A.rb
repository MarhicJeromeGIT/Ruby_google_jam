# This is my submission for gjam 2009 1C Problem A. All Your Base
# https://code.google.com/codejam/contest/189252/dashboard#s=p0
#
# ruby gjam_2009_1C input.txt output.txt

#find the minimum number 'arg' could represent and returns it
def f(arg)
	array = arg.split("")
	digits = array.length - 1
	puts "#{arg}"
	# how many different characters do we have (ie our base)
	uniqs = array.uniq
	# swap the second and first elements because the
	# first digit cannot be zero but the second can
	uniqs[0], uniqs[1] = uniqs[1], uniqs[0]
	b = uniqs.length
	
	#convert to base b
	result = 0
	array.each do |x|
		val = uniqs.index(x)	
		result += val * ( b**digits )
		digits = digits-1
	end

	return result
end

in_filename  = ARGV[0]
out_filename = ARGV[1]
in_file  = File.open in_filename
out_file = File.new out_filename, 'w'

i = 0
in_file.each_line do |line|
	if(i!=0) #skip the first line
		res = f(line.chomp) # remove end of line
		out_file.write "Case ##{i}: #{res} \n"
	end
	i = i +1
end


