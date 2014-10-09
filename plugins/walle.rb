class WallePlugin
  include Purugin::Plugin
  description 'Walle', 0.1

  def on_enable
    @walle = {}

    public_command('walle', 'Make every block you place repeat to the given height.', '/walle {height}') do |player, *args|
      height = args.first.to_i || 1

      @walle[player.name] = height
      player.msg "#{player.name}'s building height has been set at #{@walle[player.name]}"
    end

    event(:block_place) do |event|
      return unless @walle[event.player.name]

      walle_height = @walle[event.player.name]
      absolute_walle_height = walle_height.abs

      absolute_walle_height.times do |counter|
        if walle_height > 0
          event.block_placed.block_at(:up, counter).change_type(event.block_placed.type)
        else
          event.block_placed.block_at(:down, counter).change_type(event.block_placed.type)
        end
      end
    end

    event(:block_break) do |event|
      return unless @walle[event.player.name]

      walle_height = @walle[event.player.name]
      absolute_walle_height = walle_height.abs


      absolute_walle_height.times do |counter|
        if walle_height > 0
          event.block.block_at(:up, counter).change_type(:air)
        else
          event.block.block_at(:down, counter).change_type(:air)
        end
      end
    end
  end
end
