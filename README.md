# bondrix-resource
A lightweight and optimized economy system for FiveM servers. Combines in-memory transaction handling with periodic MySQL syncing for high performance and reliable data persistence.

## Features
- Designed to support servers of any size, from small communities to large-scale roleplay environments.
- Combines in-memory handling for frequent transactions with MySQL syncing.

## Dependencies
- [oxmysql](https://github.com/overextended/oxmysql/)

## Installation
### Manual
- Follow [OxMySQL](https://overextended.dev/oxmysql#installation)'s installation guide.
- Download the script and put it in the `[bondrix]` or `resources` directory.
- Add the following code to your `server.cfg`.
```
ensure bondrix-economy
```

## Configuration
Every configuration option along with its explainations can be found in [config.lua](https://github.com/bondrix/economy/blob/main/src/shared/config.lua).