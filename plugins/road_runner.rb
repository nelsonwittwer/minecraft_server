require '/Users/nelson/minecraft_server_2/support/compass'

class RoadRunnerPlugin
  include Purugin::Plugin
  description 'Road Runner', 0.1
  ROAD_RUNNER = {}

  def on_enable
    public_command('road_runner', 'Builds a road under your feet as you walk', '/road_runner {block_type}') do |player, *args|
      type = args.first.nil? ? :stone : args.first.to_sym

      if type == :off
        ROAD_RUNNER.delete(player.name)
        player.msg "Road Runner has been turned off."
      else
        ROAD_RUNNER[player.name] = type
        player.msg "#{player.name} is layin' down the #{ROAD_RUNNER[player.name]} pavement!"
        player.msg "Type /road_runner off to turn this off."
      end
    end

    event(:player_move) do |event|
      build_road(event) if ROAD_RUNNER[event.player.name]
    end
  end

  private

  def build_road(event)
    blocks_to_change = []
    compass = Compass.new(event.player)
    block_at_feet = event.to.block.block_at(:down)

    blocks_to_change << event.to.block.block_at(:down)
    blocks_to_change << block_at_feet.block_at(compass.right)
    blocks_to_change << block_at_feet.block_at(compass.left)

    blocks_to_change.each do |block|
      block.change_type(ROAD_RUNNER[event.player.name])
    end
  end
end
