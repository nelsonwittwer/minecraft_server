require '/Users/nelson/minecraft_server/support/compass.rb'

class TunnelPlugin
  include Purugin::Plugin
  description 'Tunnel', 0.1

  def on_enable
    public_command('tunnel', 'Will clear a tunnel as far as you tell me to.', '/tunnel {depth}') do |player, *args|
      depth = error? args[0].to_i, "Must specify an integer size"
      error? depth > 0, "Size must be an integer >0"

      build_tunnel(player, depth)
    end
  end

  private

  def build_tunnel(player, depth)
    compass = Compass.new(player)
    block = error? player.target_block, "No block targeted"

    depth.times do
      right_block = block.block_at(compass.right)
      left_block = block.block_at(compass.left)
      carve_blocks(block)
      carve_blocks(right_block)
      carve_blocks(left_block)

      block = block.block_at(compass.direction)
    end
  end

  def carve_blocks(block)
    3.times do
      block.change_type(:air)
      block = block.block_at(:up)
    end
  end
end
