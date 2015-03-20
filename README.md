#Tic Tac Toe API
##Install the Dependences
```
cpanm --installdeps .
```
##Run the Tests
```
prove -lvr
```

##Run the API Service
```
./api.pl daemon
```

##General
All API requests return JSON.
"success" will always be returned as a boolean.
"message" will contain a description of the results if applicable.
Players are 0 and 1, with 0 being equivalent to X and 1 being equivalent to O.
Player 0 or X always goes first.
Valid moves are 1 through 9, with the board arranged as follows:
```
123
456
789
```

##Start a new game:
```
http://127.0.0.1:3000/api/newgame
```
Returns:
```JSON
{
    game_id: 1,
    success: true
}
```

##Placing your moves
You may play multiple games at the same time using the game_id.
You do not have to specify which player is making the move.
The system always starts with player zero and alternates with player one.

Place a move at the center of the board in game 1:
```
http://127.0.0.1:3000/api/move/1/5
```
Returns:
```JSON
{
    game_id: 1,
    message: "No winner yet",
    success: true
}
```
##Possible Message Values
###Success: true
* No winner yet
* Player: 0 wins
* Board is full with no winner. Cat's game.

###Success: false
* Invalid Move
* Move already taken
* Game is already over: Player: 0 wins
* Invalid game_id