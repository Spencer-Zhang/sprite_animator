get '/' do
  @image_url = Spritesheet.first.file.url
  erb :index
end



post '/' do
  spritesheet = Spritesheet.new
  spritesheet.file = params[:file]
  spritesheet.save!

  redirect '/'
end

get '/image/colorpicker' do
  x = params[:x].to_i
  y = params[:y].to_i
  image_url = params[:imageURL]

  image = ChunkyPNG::Image.from_file('public' + image_url)

  color = image[x,y]
  response = ChunkyPNG::Color.to_hex(color)
  r = ChunkyPNG::Color.r(color)
  g = ChunkyPNG::Color.g(color)
  b = ChunkyPNG::Color.b(color)
  a = ChunkyPNG::Color.a(color)

  bg_color = "rgba(#{r}, #{g}, #{b}, #{a})"
  height = image.height


  content_type :json
  {response: response, bgColor: bg_color, height: height}.to_json
end



get '/image/bounds' do
  x = params[:x].to_i
  y = params[:y].to_i
  image_url = params[:imageURL]

  image = ChunkyPNG::Image.from_file('public' + params[:imageURL])

  response = get_bounds(image, x, y)

  content_type :json
  response.to_json
end