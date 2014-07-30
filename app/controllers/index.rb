get '/' do
  erb :index
end



post '/' do
  spritesheet = Spritesheet.new
  spritesheet.file = params[:file]
  spritesheet.save!

  redirect '/'
end