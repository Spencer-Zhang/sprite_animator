helpers do

  Bounds = Struct.new(:x, :y, :width, :height) do

    def test(image, transparent, direction)

        changed = false

        case direction
        when :left
          horiz_range = [x]
          vert_range = (y...y+height)
        when :right
          horiz_range = [x+width-1]
          vert_range = (y...y+height)
        when :up
          horiz_range = (x...x+width)
          vert_range = [y]
        when :down
          horiz_range = (x...x+width)
          vert_range = [y+height-1]
        end

        horiz_range.each do |ix|
          vert_range.each do |iy|

            if changed == false && image[ix, iy] != transparent
              changed = true if self.lengthen(direction, image) == true
            end

          end
        end

        return changed

    end


    def lengthen(direction, image)

      case direction
      when :up
        return false if self.y <= 0
        self.y -= 1
        self.height += 1
      when :down
        return false if self.y + self.height >= image.height
        self.height += 1
      when :left
        return false if self.x <= 0
        self.x -= 1
        self.width += 1
      when :right
        return false if self.x + self.width >= image.width
        self.width += 1
      end
      true
    end

  end

  def get_bounds(image, x, y)
    transparent = image[0,0]
    return nil if image[x,y] == transparent

    bounds = Bounds.new(x, y, 1, 1)

    changed = true
    while(changed == true)
      changed = false
      changed = true if bounds.test(image, transparent, :left)
      changed = true if bounds.test(image, transparent, :down)
      changed = true if bounds.test(image, transparent, :right)
      changed = true if bounds.test(image, transparent, :up)
    end

    response = {
      x: bounds.x,
      y: bounds.y, 
      width: bounds.width, 
      height: bounds.height,
      transparent: transparent
    }

    return response
  end

end