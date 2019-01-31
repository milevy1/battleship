# Battleship

_Matt Levy, William Peterson_

## Current To-Do List

- Add `has_an_unsunk_ship` test / method to `Board`
  - ?Give Board array of ships?
- Accept user-input `quit` to end game
- Develop `ComputerPlayer`'s' `smart_shot`
- Add `fire_upon` to `Board`
- Move `player_shot_feedback` from `Game`-- Make it return coordinate and feedback
- Make 2-Player
- Add Difficulty - settings to start menu

- Add custom ship options (With list of default ships?)  

- **Refactor Board Placement Methods**
  - Refactor `valid_placement?` in `Board`
  - Refactor `find_potential_placements` in `ComputerPlayer`
  - Refactor `adjacent_coordinates` in `ComputerPlayer`
  - Accept reverse input for coords

- ?Change rows to integers with conversion methods?
- ?Change Cell render method to more-static?

- Create Default inputs for default game

- **Create Tests For Game**  
  - Test that one more cell `fired_upon?` in each board after each turn
  - More

- **Questions**
  - Scope of methods (e.g. in `valid_placement?`)
  - How many methods (e.g. in `valid_placement`)
