# Battleship

_Matt Levy, William Peterson_

## Current To-Do List
- Refactor render for larger than size 9
- Add `has_an_unsunk_ship` test / method to `Board`
  - ?Give Board array of ships?
  - Add `unplaced_ships?` method to board
  - Add `fire_upon` to `Board`

- Accept user-input `quit` to end game
  - Create `input` class?
- Develop `ComputerPlayer`'s' `smart_shot`

- Make 2-Player
- Add Difficulty - settings to start menu

- Add custom ship options (With list of default ships?)  

- **Refactor Board Placement Methods**
  - Refactor `find_potential_placements` in `ComputerPlayer`
  - Refactor `adjacent_coordinates` in `ComputerPlayer`
  - Accept reverse input for coords

- ?Change rows to integers with conversion methods?
- ?Change Cell render method to more-static?

- Create Default inputs for default game

- **Create Tests For Game**  
  - Test that one more cell `fired_upon?` in each board after each turn
