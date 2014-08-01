get '/editor/animation/:animation_id' do
  animation = Animation.find(params[:animation_id])
  @image_url = animation.spritesheet.file.url
  @frames = animation.frames.to_a
  
  erb :editor
end

get '/editor/:sheet_id' do
  @image_url = Spritesheet.find(params[:sheet_id]).file.url
  erb :editor
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

  if response
    content_type :json
    response.to_json
  else
    status 400
  end
end



get '/frame' do
  puts params

  erb :'partials/frame', locals:{frame:params}
end