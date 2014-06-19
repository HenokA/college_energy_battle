require 'pry'
data = Hash.new("") #hash to hold all data points
sums = Hash.new("") #hash to hold all of the sums per month per college per datatype
colleges = ['BERKELEY COLLEGE', 'BRANFORD COLLEGE', 
	'CALHOUN COLLEGE,JOHN', 'DAVENPORT COLLEGE', 
	'EZRA STILES COLLEGE', 'JONATHAN EDWARDS COL', 
	'MORSE COLLEGE', 'PIERSON COLLEGE', 'SAYBROOK COLLEGE',
	'SILLIMAN COLLEGE', 'TIMOTHY DWIGHT COLL.', 'TRUMBULL COLLEGE']
datapoints = ['Native', 'Common', 'Global', 'SQFT']
month = [] #empty array to be filled with month values in the table
fill = true #boolean used to fill the month array on the first run
#this goes through each college in the colleges array and creates a key per college
#in the data and sum hash. It then goes into the data and sum hash and makes a hash
#for all of the months
colleges.each do |college|
	sums[college] = Hash.new
	data[college] = Hash.new
	datapoints.each do |title|
		sums[college][title] = Hash.new
		data[college][title] = Hash.new
	end
end
count = 0
college = colleges[count]
#opens file data.txt for us to read from
File.open('data.txt', 'r'){ |file|
	file.each_line do |line|
		# puts colleges[count]
		if line != "newline\n" #how we decided to separate the colleges in the datafile, can be changed if needed
			line = line.split(',') #makes the line pulled from the text file into an array organized into columns
			if fill #If it is our first run through, add the months to the month array
				month.push(line[0].to_s)
			end
			#adds the datapoints into the data array from the data.txt file
			data[college.to_s]['Native'][line[0].to_s] = line[1].to_s
			data[college.to_s]['Common'][line[0].to_s] = line[2].to_s
			data[college.to_s]['Global'][line[0].to_s] = line[3].to_s
			data[college.to_s]['SQFT'][line[0].to_s] = line[4].to_s
			########################################
			#sums up the data per datatype per college by month
			sums[college.to_s]['Native'][line[0][0..1].to_s] = sums[college.to_s]['Native'][line[0][0..1].to_s].to_f+ line[1].to_f
			sums[college.to_s]['Common'][line[0][0..1].to_s] = sums[college.to_s]['Common'][line[0][0..1].to_s].to_f+ line[2].to_f
			sums[college.to_s]['Global'][line[0][0..1].to_s] = sums[college.to_s]['Global'][line[0][0..1].to_s].to_f+ line[3].to_f
			sums[college.to_s]['SQFT'][line[0][0..1].to_s] = sums[college.to_s]['SQFT'][line[0][0..1].to_s].to_f+ line[4].to_f
		else
			fill=false #used to get a list of months
			count+=1
			college = colleges[count] #changes to the next month from the month array created using fill
		end
	end
}
counter = 0 #how we go through the months array to add the updated values without re-opening the data.txt
divide=0 #there are not an equal number of datapoints per month (some are two, some are three for now)
string="" #just to modularize our work, string is going to be the month string from the month array
#this is what averages and normalizes the data based on a 100,000 root value
data.each do |residential, datatypes|
	datatypes.each do |name, time|
		while counter < time.length
			string = month[counter].to_s
			if string[0..1] == '05' || string[0..1] == '06' || string[0..1] == '07'
				divide =  2
			else 
				divide = 3
			end
			#Line below divides the sum by the number of datapoints used to make the sum. it then
			#then divides 100,000 by that number to get a "pivot" value and then multiplies the
			#data point saved in data with that to monthly adjust it
			data[residential][name][month[counter].to_s] = data[residential][name][string].to_f * 100000 / (sums[residential][name][string[0..1]].to_f / divide.to_f).to_f
			counter+=1
		end
		counter = 0 #restarts the months for every datatype in every college
	end
end
counter = 1
File.open('adjusted.txt', 'w'){ |file|
	data.each do |residential, datatypes|
		file.write(residential.to_s + "\n")
		while counter < month.length
			string = month[counter].to_s
			file.write(data[residential]['Native'][string].to_s + "," + data[residential]['Common'][string].to_s + ","+\
						data[residential]['Global'][string].to_s+ "," + data[residential]['SQFT'][string].to_s+"\n")
			counter+=1
		end
		file.write("newline\n")
		counter = 1
	end
}