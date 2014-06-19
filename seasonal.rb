data = Hash.new("")
colleges = ['BERKELEY COLLEGE', 'BRANFORD COLLEGE', 
	'CALHOUN COLLEGE,JOHN', 'DAVENPORT COLLEGE', 
	'EZRA STILES COLLEGE', 'JONATHAN EDWARDS COL', 
	'MORSE COLLEGE', 'PIERSON COLLEGE', 'SAYBROOK COLLEGE',
	'SILLIMAN COLLEGE', 'TIMOTHY DWIGHT COLL.', 'TRUMBULL COLLEGE']
colleges.each do |college|
	data[college] = Hash.new
end

count = 0
college = colleges[count]
File.open('data.txt', 'r'){ |file|
	file.each_line do |line|
		puts colleges[count]
		if line != "newline\n"
			data[college.to_s][line[0..1].to_s] = data[college.to_s][line[0..1].to_s].to_f \
			+ line[8..-1].to_f
			# puts data[college.to_s][line[0..1].to_s]
			if line[0..1].to_s == '04'
					# puts college.to_s
			end
		else
			data[college.to_s][line[0..1].to_s] = data[college.to_s][line[0..1].to_s]/100000
			count+=1
			college = colleges[count]
		end
	end
}
puts data['BERKELEY COLLEGE']
