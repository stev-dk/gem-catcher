Gem Catcher

My first game in Love2d. It's based of section 3 of Richard Allbert's udemy course
Learn 2D Game Development: Godot 4.3+ & C# from Scratch.

In progress / todo
- Rename references to gems to collectibles, to be consistent.
- Add a "start-state", which is loaded initially, and loaded when the player runs out of lives.
- Rework loading of graphics. Now a new image is loaded into memory every time a collectible is spawned.
- Starting working on scoreManager

Versions:
0.3.2 - Refactoring
- Refacotered newly spanwed collectibles to have a key / id in the table, instead of an index.
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
