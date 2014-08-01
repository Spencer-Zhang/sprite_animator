get '/editor/animation/:animation_id' do
  animation = Animation.find(params[:animation_id])
  @spritesheet = animation.spritesheet
  @image_url = @spritesheet.file.url
  @frames = animation.to_s
  
  erb :editor
end

get '/editor/:sheet_id' do
  @spritesheet = Spritesheet.find(params[:sheet_id])
  @image_url = @spritesheet.file.url
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

post '/animation' do
  animation = Animation.create(spritesheet_id: params[:spritesheetID].to_i)

  params[:list].each do |frame|
    animation.frames.create(x:        frame[1]['x'].to_i, 
                            y:        frame[1]['y'].to_i, 
                            width:    frame[1]['width'].to_i, 
                            height:   frame[1]['height'].to_i, 
                            offset_x: frame[1]['offX'].to_i, 
                            offset_y: frame[1]['offY'].to_i)
  end

  "test"
end