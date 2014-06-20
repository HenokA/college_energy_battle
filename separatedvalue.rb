colleges = ['BERKELEY COLLEGE', 'BRANFORD COLLEGE', 
	'CALHOUN COLLEGE,JOHN', 'DAVENPORT COLLEGE', 
	'EZRA STILES COLLEGE', 'JONATHAN EDWARDS COL', 
	'MORSE COLLEGE', 'PIERSON COLLEGE', 'SAYBROOK COLLEGE',
	'SILLIMAN COLLEGE', 'TIMOTHY DWIGHT COLL.', 'TRUMBULL COLLEGE']
data = Hash.new
currentCollege = ""
counter = 0
File.open('adjusted.txt', 'r'){ |file|
	file.each_line do |line|
		if colleges.index(line.strip.chomp.to_s)!=nil
			#Store the college value
			data[line.to_s] = Array.new
			currentCollege = line.to_s
			counter = 0
		else
			#look for the Common value
			if counter !=2
				line = line.split(',')
				data[currentCollege].push(line[2])
				counter +=1
			end
		end
	end
}
puts data