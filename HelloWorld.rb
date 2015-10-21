require 'sinatra'

get '/' do
  'Greetings from Houston TX!'
end

get '/Nemacolin' do
	'Mined Minds remoting is awesome!'
end

get '/hotel/:name' do
	"Hello #{params['name']}" 
end

get '/add/:name/:number1/:number2' do |name,num1,num2|
	sum = num1.to_i + num2.to_i
	"Hello #{name},these values ="  + sum.to_s
end

get '/details' do
	erb :username
end


post '/details' do
	"Hello #{params['username']}"
	erb :age,:locals => {:name => params[:username]}
end

post '/age' do
	plusten = params[:age].to_i + 10
	if plusten < 70
		erb :numbers
	else 
		"In ten years you will be: #{plusten}"
	end
end

post '/numbers' do
	sum = params[:num1].to_i + params[:num2].to_i + params[:num3].to_i
	"The sum of your 3 favorite numbers is #{sum}"
end

get '/login' do
	erb :login ,:locals => {:message => "Enter username and password"}
	
end

before do
	@username = params[:username]
	@password = params[:password]
end

def un_pw_auth
	file = File.open('public/usernames_passwords.csv', 'r')
	
	file.each do |user|
		username_password = user.split(",")
		username = username_password[0]
		password = username_password[1].chomp
	if  username == @username && password == @password
		@auth = 1
	end
end
end

post '/login' do
un_pw_auth
	if @auth == 1
		erb :main
	else erb:login, :locals => {:message => "Logon Failure"}
	end 
end
	