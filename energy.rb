require 'sinatra'
require 'sinatra/reloader'


configure do
  enable :sessions
end

get '/' do
	data = Array.new
	negdata = Array.new
	posdata = Array.new
	college = Array.new
	File.open('data.tsv', 'r'){ |file|
		file.each_line do |line|
			line= line.split("\t")
			if negdata == []
				#this is what gives the dataset its name
				negdata.push("Negative Values")
			end
			if posdata == []
				posdata.push("Positive Values")#same as above
			end
			#in theory, there should never be a case where there is a 0% 
			#change in energy because the chance of them using the EXACT 
			#SAME AMOUNT is almost 0
			if line[1].to_f <0 
				data.push(line[1].to_f.round(3)) #pushes values less than 0
			elsif line[1].to_f >0
				data.push(line[1].to_f.round(3)) #pushes values greater than 0
			end
			college.push(line[0])
		end
	}
	data.sort!{|x,y| y.to_f<=>x.to_f}
	negdata.unshift("Worst Colleges")
	posdata.unshift("Best Colleges")
	college.shift
	college.reverse!
	erb :"index", :locals =>{:negdata => negdata, :posdata => posdata, :data => data, :college => college}
end	

get '/about' do
	# title = ""
	# data = {'BERKELEY COLLEGE' =>[], 'BRANFORD COLLEGE' =>[], 
	# 'CALHOUN COLLEGE,JOHN'=>[], 'DAVENPORT COLLEGE'=>[], 
	# 'EZRA STILES COLLEGE'=>[], 'JONATHAN EDWARDS COL'=>[], 
	# 'MORSE COLLEGE'=>[], 'PIERSON COLLEGE'=>[], 'SAYBROOK COLLEGE'=>[],
	# 'SILLIMAN COLLEGE'=>[], 'TIMOTHY DWIGHT COLL.'=>[], 'TRUMBULL COLLEGE'=>[]}
	# File.open('adjusted.txt', 'r'){ |file|
	# 	file.each_line do |line|
	# 		puts line
	# 		line = line.split(",")
	# 		puts line[0].strip.chomp.to_s != nil
	# 		if data.index(line[0].strip.chomp.to_s) != nil
	# 			title = line.strip.chomp.to_s
	# 			puts title.to_s + 'AAHAAKJLSKJDLKSJDLKJALKJDF'
	# 		elsif line[0].strip.chomp.to_s != 'newline'
	# 			data[title].push(line[2].to_s)
	# 		end
				
	# 	end
	# }
	# puts data
	erb :"about"
end

get '/leaderboard' do
	erb :"leaderboard"
end




get '/data/:name' do
	finaldates = Array.new
	grab = false
	dates = Array.new
	data = Array.new
	college_name = ""
	colleges = {"bk" => 'BERKELEY COLLEGE', 'br' => 'BRANFORD COLLEGE', 'cc' => "CALHOUN COLLEGE,JOHN", 'dc' => 'DAVENPORT COLLEGE', 'es' => 'EZRA STILES COLLEGE', 'je' => "JONATHAN EDWARDS COL", 'mc'=> "MORSE COLLEGE", 'pc' => 'PIERSON COLLEGE', 'sm' => "SILLIMAN COLLEGE", 'sy'=> "SAYBROOK COLLEGE", 'tc' => 'TRUMBULL COLLEGE', 'td' => 'TIMOTHY DWIGHT COLL.' }
	File.open('adjusted.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(",")
			college_name = params[:name]
			if line[0].strip.chomp.to_s == 'newline'
				grab = false
			end	
			if grab == true
				#in theory, there should never be a case where there is a 0% 
				#change in energy because the chance of them using the EXACT 
				#SAME AMOUNT is almost 0
				data.push(line[2].to_f.round(3)) #pushes values less than 0
				dates.push(line[0])
			end
			if line[0].strip.chomp.to_s == colleges[college_name.strip.chomp.to_s]
				grab = true
			end	
				
		end
	}
	dates.each do |date|
		date = date.split('/')
		finaldates.push(date[1].to_s + "-" + date[0]+"-01")
	end
dates.unshift('x')
finaldates.unshift('x')
data.unshift(colleges[college_name].strip.chomp.to_s)
	erb college_name.to_sym, :locals => {:dates => dates, :finaldates => finaldates, :data => data}
end

