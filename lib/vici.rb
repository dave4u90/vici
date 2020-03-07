require_relative 'required'

class Vici
  include Validations

  attr_accessor :placed, :currentx, :currenty, :current_direction

  def placed?
    placed == true
  end
  
  def place(xposition:, yposition:, direction:)
    if valid_positions?(xposition: xposition, yposition: yposition) && valid_direction?(direction: direction)
      self.currentx, self.currenty, self.current_direction = xposition.to_i, yposition.to_i, direction
      self.placed = true
    else
      false
    end
  end

  def move
    return unless placed?
    
    send current_direction.downcase.to_sym
  end

  def left
    return unless placed?
    
    case current_direction
    when 'NORTH'
      self.current_direction = 'WEST'
    when 'WEST'
      self.current_direction = 'SOUTH'
    when 'SOUTH'
      self.current_direction = 'EAST'
    when 'EAST'
      self.current_direction = 'NORTH'
    end
  end

  def right
    return unless placed?

    case current_direction
    when 'NORTH'
      self.current_direction = 'EAST'
    when 'EAST'
      self.current_direction = 'SOUTH'
    when 'SOUTH'
      self.current_direction = 'WEST'
    when 'WEST'
      self.current_direction = 'NORTH'
    end
  end

  def report
    p [currentx, currenty, current_direction].join(',')
  end

  private

  def north
    if validy?(yposition: currenty + 1)
      self.currenty +=1
      true
    else
      false
    end
  end

  def south
    if validy?(yposition: currenty - 1)
      self.currenty -= 1 
      true
    else
      false
    end
  end

  def east
    if validx?(xposition: currentx + 1)
      self.currentx += 1
      true
    else
      false
    end
  end

  def west
    if validx?(xposition: currentx - 1)
      self.currentx -= 1
      true
    else
      false
    end
  end
end
