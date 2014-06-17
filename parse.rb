require 'spreadsheet'
# require 'parseexcel'
###READING TO FILE
Spreadsheet.client_encoding = 'UTF-8'
colleges = ['BERKELEY COLLEGE', 'BRANFORD COLLEGE', 
	'CALHOUN COLLEGE,JOHN', 'DAVENPORT COLLEGE', 
	'EZRA STILES COLLEGE', 'JONATHAN EDWARDS COL', 
	'MORSE COLLEGE', 'PIERSON COLLEGE', 'SAYBROOK COLLEGE',
	'SILLIMAN COLLEGE', 'TIMOTHY DWIGHT COLL.', 'TRUMBULL COLLEGE']
book = Spreadsheet.open 'total_data.xls'
sheet = book.worksheet 'index'
data = Hash.new
sheet.each do |row|
	break if row[0].nil? # if first cell empty
	if row[3] == 'Cogen Electricity'
		data[row[2].to_sym] ||= []
		data[row[2].to_sym].unshift([row[4], row[5]])
		# puts row[2].to_s+ " "+ data[row[2].to_sym].to_s
	end
end
colleges.each do |college|
	puts college + ":" +data[college.to_sym].to_s + "\n\n"
end
File.open('data.txt', 'w'){ |file|
	colleges.each do |college|
		file.write(college.to_s + "\n")
		data[college.to_sym].each do |values|
			file.write(values[0].to_s + ',' + values[1].to_s + "\n")
		end
		file.write("\n")
	end
}

# ### WRITING TO FILE
# book1 = Spreadsheet.open 'Cogen_Electricity.xls'
# sheet1 = book1.worksheet 'Cogen_Electricity'
# count = 0
# sheet.each do |row|
# 	break if row[0].nil?
# 	count +=1 #count for new row
# end
# minicount=0
# colleges.each do |college|
# 	sheet1.rows[count][minicount] = college.to_s
# 	minicount+=1
# 	data[college.to_sym].each do |values|
# 		sheet1.rows[count][minicount] = values[0]
# 		minicount+=1
# 		sheet1.rows[count][minicount] = values[1]
# 		minicount +=1
# 	end
# 	minicout = 0
# end

