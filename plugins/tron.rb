class TronPlugin
  include Purugin::Plugin
  description 'Tron', 0.1
  TRON = {}

  def on_enable
    public_command('tron', 'Make every block you step on turn into the specified block type.', '/tron {block_type}') do |player, *args|
      if args.first == "off"
        TRON.delete(player.name)
        player.msg "Tron has been turned off."
      else
        type = args.first.to_sym
        TRON[player.name] = type
        player.msg "Every block #{player.name} steps on will now turn to #{TRON[player.name]}"
        player.msg "Type /tron off to turn this off."
      end
    end

    event(:player_move) do |event|
      change_ground_tile(event) if TRON[event.player.name]
    end
  end

  private

  def change_ground_tile(event)
    event.to.block.block_at(:down).change_type(TRON[event.player.name])
  end
end
