get '/' do
  @spritesheets = Spritesheet.all.to_a
  erb :index
end

post '/spritesheet' do
  spritesheet = Spritesheet.new
  spritesheet.file = params[:file]
  puts params[:file]
  spritesheet.filename = params[:file][:filename]
  spritesheet.save!

  # Attempt to fix corrupted PNG files.
  image = MiniMagick::Image.open('public' + spritesheet.file.url)
  image.format('png')
  image.write('public' + spritesheet.file.url)

  redirect '/'
end