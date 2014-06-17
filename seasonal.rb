data = Hash.new(Hash.new(0))
colleges = ['BERKELEY COLLEGE', 'BRANFORD COLLEGE', 
	'CALHOUN COLLEGE,JOHN', 'DAVENPORT COLLEGE', 
	'EZRA STILES COLLEGE', 'JONATHAN EDWARDS COL', 
	'MORSE COLLEGE', 'PIERSON COLLEGE', 'SAYBROOK COLLEGE',
	'SILLIMAN COLLEGE', 'TIMOTHY DWIGHT COLL.', 'TRUMBULL COLLEGE']
count = 0
college = colleges[count]
File.open('data.txt', 'r'){ |file|
	file.each_line do |line|
		if line != "newline\n"
			data[college.to_s][line[0..1].to_s] = data[college][line[0..1]].to_f + line[8..-1].to_f
			# puts data[college.to_s][line[0..1].to_s]
			if line[0..1].to_s == '04' && college == 'BERKELEY COLLEGE'
					puts line[8..-1]
			end
		else
			count+=1
			college = colleges[count]
		end
	end
}
puts data['BERKELEY COLLEGE']['04']
