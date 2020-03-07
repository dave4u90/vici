module Validations
  def validx?(xposition: nil)
    return false if (xposition.present? && xposition.is_a?(String) && !xposition.is_integer?)

    xposition = xposition.to_i if xposition.present?
    xposition ||= currentx
    xposition >= 0 && xposition <= XMAX
  end

  def validy?(yposition: nil)
    return false if (yposition.present? && yposition.is_a?(String) && !yposition.is_integer?)

    yposition = yposition.to_i if yposition.present?
    yposition ||= currenty
    yposition >= 0 && yposition <= YMAX
  end

  def valid_direction?(direction: nil)
    direction ||= current_direction
    DIRECTIONS.include? direction
  end

  def valid_positions?(xposition: nil, yposition: nil)
    validx?(xposition: xposition) && validy?(yposition: yposition) 
  end

  def valid?(xposition: nil, yposition: nil, direction: nil)
    valid_positions?(xposition: xposition, yposition: yposition) && valid_direction?(direction: direction)
  end
end
