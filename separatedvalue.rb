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
			data[line.strip.chomp.to_s] = Array.new
			currentCollege = line.strip.chomp.to_s
			counter = 0
		else
			#look for the Common value
			if counter !=2
				line = line.split(',')
				data[currentCollege].push(line[2].strip.chomp.to_s)
				counter +=1
			end
		end
	end
}
pushing = 0
finaldata = Array.new
#this finds the percent change of the current month vs the previous month
data.each do |key, value|
	pushing = (value[1].to_f - value[0].to_f).to_f / value[1].to_f
	pushing = pushing*100
	finaldata.push([key.to_s, pushing.to_s])
end
finaldata.sort_by!{|i| i[1]}
puts finaldata
#this writes the data into a tab separated file 
File.open('data.tsv', 'w'){ |file|
	file.write("college\tvalue\n")
	finaldata.each do |key, value|
		file.write(key.to_s + "\t" + value.to_s + "\n")
	end
}