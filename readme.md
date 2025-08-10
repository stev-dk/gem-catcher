Gem Catcher

My first game in Love2d. It's based of section 3 of Richard Allbert's udemy course
Learn 2D Game Development: Godot 4.3+ & C# from Scratch.

TODO
- A lot of refactoring...
- A saved highscore from current session, and perhaps a highscore that is saved from previous sessions

KNOWN BUGS
- If two collectibles are picked up to soon after each other, the second wont play a pickup sound, as the first
one is still playing. Same applies to explode sounds.

Versions:
0.5 - Added collision
- Removed the use of globals in the game. Now even the GameManager is a local and is required where needed
- Added simple collision, check the entire outline of the collectible (as a square), and not its actual footprint
- Added background image and music
- Added collect sound
- Added explosion sound when a collectible is not picked up
- Added score
- Slightly refined restart and load methods
- Removed ScoreManager, as GameManager handles this

0.4 - Added player class
- Added paddle.lua with a Paddle table
- Loading paddle sprite in memory, and drawing it on screen using global GameManager width and height to
place the paddle.
- Added paddle movement, restricting moving off screen using global GameManager widht and height.

0.3.3 - Mostly refactoring, small optimization
- Renamed gem to collectible to be consistent througout the code
- Added a restart method to GameManager, and call it when the player runs out of lives.
- Created a spriteCache to hold already loaded images instead of loading the same image in memory multiple times
- Added a width property to collectibles, to stop them from spawning outside the screen to the right.
- Added dynamic screen dimensions, instead of hard coded values (magic numbers)

0.3.2 - Refactoring
- Refactored newly spanwed collectibles to have a key / id in the table, instead of an index.
This makes it easier to delete collectibles from the table, instead of looping over the entire table
every time a collectible needs to be removed.
- Added methods in GameManager to add and remove collectibles within the class, instead
of the collectibles modifying data in GameManager

0.3.1 - Refactoring
- Made GameManager globel instead of passing it into every instance of gems
0.3 - Adding GameManager
- Added a game manager to handle game state
- Refactored main and collectibles to use game manager
- Added logic to delete gems from the game when they reach
a certain y position
- Added lives

0.2 - First commit
- Seperated code into multiple files
- Refactored using local in appropriate places
- Seperated fall() method into update() and draw() methods
- Added readme

0.1 - No commit of this.
- Creating a Collectibles class and RedGem subclass
- Creating methods for loading, updating and drawing the collectibles
- Creating a timer to spawn gems at a fixed interval
- Spawn gems at a random x position
- Created a table to hold all spawned collectibles
- Looping over the collectibles to update and draw position
