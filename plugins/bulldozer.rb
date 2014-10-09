class BulldozerPlugin
  include Purugin::Plugin
  description 'Bulldozer', 0.1

  def on_enable
    public_command('bulldozer', 'clear out a flat space for building a structure', '/bulldozer {x} {y} {z} {base_block_type}') do |player, *args|
      x = error? args[0].to_i, "Must specify an integer size"
      y = error? args[1].to_i, "Must specify an integer size"
      z = error? args[2].to_i, "Must specify an integer size"
      error? x > 0, "X must be an integer > 0"
      error? y >= 0, "Y must be an integer >= 0"
      error? z > 0, "Z must be an integer > 0"
      type = args.length > 3 ? args[3].to_sym : :air
      z_block = error? player.target_block, "No block targeted"

      player.msg "Clearing foundation of #{x} x #{y} x #{z} with foundation layer of #{type}"
      clear_layer(x, y, z, z_block, type)

      y.times do
        z_block = z_block.block_at(:up)
        clear_layer(x, y, z, z_block, :air)
      end

      player.msg "Done bulldozing foundation!"
    end
  end

  private

  def clear_layer(x, y, z, z_block, type = :air)
    x.times do
      x_block = z_block
      z.times do
        x_block.change_type type
        x_block = x_block.block_at(:north)
      end
      z_block = z_block.block_at(:east)
    end
  end
end
