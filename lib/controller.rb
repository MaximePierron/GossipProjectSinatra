require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/gossips/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/gossips/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {gossip: Gossip.find("#{params["id"]}")}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.find("#{params["id"]}")}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params["id"], params["new_gossip_author"], params["new_gossip_content"])
    redirect '/gossips/'
  end

end
