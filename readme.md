Gem Catcher

My first game in Love2d. It's based of section 3 of Richard Allbert's udemy course
Learn 2D Game Development: Godot 4.3+ & C# from Scratch.

In progress / todo
- Starting working on scoreManager

Versions:
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
