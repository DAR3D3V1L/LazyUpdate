# LazyUpdate

A bash script to automate system updates on Debian/Ubuntu systems.

## What it does

- Updates package lists
- Upgrades all packages
- Removes unused dependencies
- Cleans apt cache

## Requirements

- Debian/Ubuntu based system
- `figlet` (auto-installed if not found)
- `sudo` access

## Usage

```bash
chmod +x update.sh
./update.sh
```

## Note

Tested on Ubuntu. May not work on non-apt based distros.
