## Class `game`

#### Initialize
game is passed rows/columns, list of ships

game creates 2 board; one for comp, one for human

#### Setup
method `setup` asks if want to play; place player ships; `setup` also places comp ships

In `setup` call `Messages` if invalid placements given  

#### Playing the game
method `start`

Loop while both players have at least one ship not sunk. (method to check)

- Display boards `board.render` (both)
- Solicit player shot coordinate `player_turn` -> gets coordinate
  - `comp_board.cells[coordinate].fire_upon` (or write `fire_upon` in board)
- Determine computer shot coordinate
  - Figure coordinate, then do same as with player shot

- Display shot results (pass comp/player coordinates) `display_results(coord_comp, coord_player)`
