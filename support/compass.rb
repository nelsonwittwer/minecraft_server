class Compass
  attr_accessor :direction, :yaw

  def initialize(player)
    self.yaw = player.location.yaw
    self.direction = current_direction
  end

  def current_direction(modified_yaw = yaw)
    rotation = modified_yaw.round / 90;

    if rotation == -4 || rotation == 0 || rotation == 4
      return :south
    elsif rotation == -1 || rotation == 3
      return :east
    elsif rotation == -2 || rotation == 2
      return :north
    elsif rotation == -3 || rotation == 1
      return :west
    end
  end

  def right
    current_direction(yaw + 90)
  end

  def left
    current_direction(yaw - 90)
  end

  def opposite_direction
    if direction == :north
     return :south
    elsif direction == :south
      return :north
    elsif direction == :east
      return :west
   elsif direction ==:west
      return :east
    end
  end
end
