# Knox Blacklisted Script

A comprehensive FiveM script that automatically detects and removes blacklisted objects, vehicles, and weapons from your server. The script sends Discord webhook notifications when violations are detected.

## Features

- **Object Detection**: Automatically detects and removes blacklisted objects within 50 units of players
- **Vehicle Detection**: Automatically detects and removes blacklisted vehicles within 100 units of players  
- **Weapon Detection**: Automatically detects and removes blacklisted weapons from players
- **Discord Integration**: Sends detailed webhook notifications to Discord channels
- **ESX Framework Support**: Fully integrated with ESX framework
- **Configurable**: Easy-to-configure blacklists for objects, vehicles, and weapons

## Installation

1. Download the script and place it in your `resources` folder
2. Add `ensure knox_blacklisted` to your `server.cfg`
3. Configure the Discord webhooks in `config/config.lua`
4. Restart your server

## Dependencies

- **ESX Framework**: Required for player management
- **ox_lib**: Required for shared functionality
- **oxmysql**: Required for database operations

## Configuration

### Discord Webhooks

Edit `config/config.lua` to set up your Discord webhooks:

```lua
Config.WebhookObject = 'YOUR_DISCORD_WEBHOOK_URL_FOR_OBJECTS'
Config.WebhookVehicles = 'YOUR_DISCORD_WEBHOOK_URL_FOR_VEHICLES'  
Config.WebhookWeapons = 'YOUR_DISCORD_WEBHOOK_URL_FOR_WEAPONS'
```

### Blacklisted Items

#### Objects
Add object models to the `Config.ObjectList`:

```lua
Config.ObjectList = {
    'prop_gas_pump_1a',
    'prop_example_object',
    -- Add more objects here
}
```

#### Vehicles
Add vehicle models to the `Config.VehicleList`:

```lua
Config.VehicleList = {
    'technical',
    'technical2', 
    'technical3',
    'khanjali',
    'minitank',
    'rhino',
    'cerberus',
    'cerberus2',
    'cerberus3',
    'phantom2',
    -- Add more vehicles here
}
```

#### Weapons
Add weapon hashes to the `Config.WeaponList`:

```lua
Config.WeaponList = {
    'WEAPON_SNOWLAUNCHER',
    'WEAPON_COMPACTLAUNCHER',
    'WEAPON_MINIGUN',
    'WEAPON_GRENADELAUNCHER_SMOKE',
    'WEAPON_HOMINGLAUNCHER',
    'WEAPON_RAILGUN',
    'WEAPON_FIREWORK',
    'WEAPON_GRENADELAUNCHER',
    'WEAPON_RPG',
    'WEAPON_RAYMINIGUN',
    'WEAPON_EMPLAUNCHER',
    'WEAPON_RAILGUNXM3',
    'WEAPON_AUTOSHOTGUN',
    -- Add more weapons here
}
```

## How It Works

### Object Detection
- Continuously scans for blacklisted objects in the game world
- When a blacklisted object is detected within 50 units of a player, it:
  - Sends a Discord webhook notification
  - Automatically deletes the object
  - Logs the player's FiveM name and identifier

### Vehicle Detection  
- Continuously scans for blacklisted vehicles in the game world
- When a blacklisted vehicle is detected within 100 units of a player, it:
  - Sends a Discord webhook notification
  - Automatically deletes the vehicle
  - Logs the player's FiveM name and identifier

### Weapon Detection
- Continuously checks if players have blacklisted weapons
- When a blacklisted weapon is detected, it:
  - Sends a Discord webhook notification
  - Automatically removes the weapon from the player
  - Logs the player's FiveM name and identifier

## Discord Webhook Format

The script sends structured Discord embeds with the following information:

### Object Detection Webhook
- **Title**: "Blacklisted Object Detected"
- **Player**: FiveM name + ESX identifier
- **Object Model**: The detected object model name
- **Timestamp**: When the detection occurred

### Vehicle Detection Webhook
- **Title**: "Blacklisted Vehicle Detected"  
- **Player**: FiveM name + ESX identifier
- **Vehicle Model**: The detected vehicle model name
- **Timestamp**: When the detection occurred

### Weapon Detection Webhook
- **Title**: "Blacklisted Weapon Detected"
- **Player**: FiveM name + ESX identifier  
- **Weapon**: The detected weapon name
- **Timestamp**: When the detection occurred

## Performance

- **Optimized Scanning**: Uses efficient game pool functions for minimal performance impact
- **Distance-Based Detection**: Only scans objects/vehicles within reasonable distances
- **Non-Blocking**: All detection runs in separate threads to avoid server lag

## Troubleshooting

### Common Issues

1. **Webhooks Not Working**
   - Verify your Discord webhook URLs are correct
   - Check that the webhook has proper permissions
   - Ensure the webhook channel exists and is accessible

2. **Items Not Being Detected**
   - Verify the model names in your config are correct
   - Check that the items are actually spawning in-game
   - Ensure the script is properly loaded and running

3. **Performance Issues**
   - Reduce the detection ranges if needed
   - Consider reducing the number of blacklisted items
   - Monitor server performance during peak times

### Debug Mode

To enable debug logging, you can add console output to track detections:

```lua
print("Detected blacklisted item: " .. itemName)
```

## Support

For support and updates, please contact the script author or check the documentation.

## License

This script is provided as-is. Please respect the terms of use for your FiveM server.

## Version History

- **v1.0.0**: Initial release with object, vehicle, and weapon detection
- **v1.0.1**: Updated webhook format to remove coordinates and use FiveM player names

---

**Author**: knox  
**Version**: 1.0.0  
**Framework**: ESX  
**Game**: GTA5