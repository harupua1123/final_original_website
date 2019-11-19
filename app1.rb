require 'sinatra'
require 'sinatra/reloader'
require 'will_paginate_mongoid'
require 'pg'

enable :sessions

def client
PG::connect(
    host: '',
    user: 'codebase',
    password: 'pass',
    dbname:'ec_site')
end

get '/index'do
    'message me!'
end

get '/form' do
    erb :message_form
end


post '/form_output' do
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]


  # ファイルに保存する
  File.open("form.txt", mode = "a"){|f|
    f.write("#{@name},#{@email},#{@content}\n")
  }
  erb :message_form_output
end

get '/sent' do
    erb :message_sent
end

get '/login' do
    erb :login
  end
  
  
  $users = [
    { email: "kinjo@mail.com", password: "kinjopass", name: "kinjo"},
    { email: "higa@mail.com", password: "higapass", name: "higa"},
    { email: "sabo@mail.com", password: "sabopass", name: "sabo"}
  ]
  
  post '/login' do
    mail = params[:email]
    pass = params[:password]
    $users.each do |user|
      if user[:email] == mail
        if user[:password] == pass
          @user = user
          return erb :mypage
        end
      end
    end
    redirect to('/login')
  end
  
  get '/mypage' do
    @user = "No User"
    $users.each do |user|
      if user[:name] == cookies[:name]
        @user = user
      end
    end
    erb :mypage
  end
  
  get '/mypage' do
    @user = { name: "No User" }
    $users.each do |user|
      if user[:name] == cookies[:name]
        @user = user
      end
    end
    erb :mypage
  end


get '/signup' do
    erb :signup
end

get '/maypage' do
  erb :mypage
end


get '/checkout' do
    erb :checkout
end

get '/purchase' do
  erb :purchase 
end


get '/items_earrings' do
    erb :items_earrings
end

get '/items_necklaces' do
  erb :items_necklaces
end
