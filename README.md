# TicTacToe for iOS
*Will Oakley - April 5, 2019*

A simple game of TicTacToe for iPhone. The game will allow the user to select a cell and mark that cell with either an X or an O. The game is over when a player has 3 in a row of their mark. The user is also able to reset the game and play another. The app also senses when a game has no winner and will allow the user to reset and play again. Small animations are implemented on the game cells when the game is won or lost. No significant outside libraries or frameworks were used. 

### Class Structure
* **GameViewController** - Controller that manages the game state and each cell view.
* **GameCell** - Representation of the cell object that a user is able to select. Handles state and animation of cell. 
* **Player** - A simple enum representing a player (either X, O or None).

## Screenshots

![](https://i.ibb.co/P54g4dJ/Simulator-Screen-Shot-i-Phone-8-Plus-2019-04-05-at-12-08-53.png)

![](https://i.ibb.co/DRfzgkD/Simulator-Screen-Shot-i-Phone-8-Plus-2019-04-05-at-12-19-22.png)

![](https://i.ibb.co/6rPs3Pc/Simulator-Screen-Shot-i-Phone-8-Plus-2019-04-05-at-12-19-43.png)
