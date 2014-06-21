require 'sinatra'
require 'sinatra/reloader'


configure do
  enable :sessions
end

get '/' do
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
				negdata.push(line[1].to_f.round(3)) #pushes values less than 0
			elsif line[1].to_f >0
				posdata.push(line[1].to_f.round(3)) #pushes values greater than 0
			end
			college.push(line[0])
		end
	}
	posdata.sort!{|x,y| y.to_f<=>x.to_f}
	puts posdata
	negdata.unshift("Worst Colleges")
	posdata.unshift("Best Colleges")
	erb :"index", :locals =>{:negdata => negdata, :posdata => posdata, :college => college}
end	

get '/about' do
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
				negdata.push(line[1].to_f.round(3)) #pushes values less than 0
			elsif line[1].to_f >0
				posdata.push(line[1].to_f.round(3)) #pushes values greater than 0
			end
			college.push(line[0])
		end
	}
	posdata.sort!{|x,y| y.to_f<=>x.to_f}
	puts posdata
	negdata.unshift("Worst Colleges")
	posdata.unshift("Best Colleges")
	erb :"about", :locals =>{:negdata => negdata, :posdata => posdata, :college => college}
end

get '/leaderboard' do
	erb :"leaderboard"
end