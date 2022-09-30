# Prodoku
A Sudoku solver in Prolog, created for Paris VIII University.

A 9x9 sudoku grid contains 9 rows and 9 columns, the goal of the game is
to fill the empty cells with a number from 1 to 9 which must be unique in the row, in the column, and unique in its square of 3x3 cells.
In other words, a perfect game for Prolog.

This program will solve 4x4 grids and 9x9 ones.

#### Example 1 (4x4):
```
?- sudoku4x4(3, 4, 1, _,
_, 2, _, _,
_, _, 2, _,
_, 1, 4, 3).
```
#### Result:
```
3 | 4 | 1 | 2
1 | 2 | 3 | 4
4 | 3 | 2 | 1
2 | 1 | 4 | 3
true ;
false.
```

#### Example 2 (9x9):
```
sudoku9x9(9, _, 3, _, _, _, _, _, 8,
_, 6, _, _, _, _, _, 1, _, 
_, 5, _, 2, _, _, _, 9, _, 
_, _, _, 1, 6, 4, 5, _, 2, 
_, _, _, _, 3, _, _, _, _, 
6, _, 1, 5, 8, 7, _, _, _, 
_, 4, _, _, _, 6, _, 8, _, 
_, 8, _, _, _, _, _, 2, _,
2, _, _, _, _, _, 3, _, 7).
```

#### Result:
```
9 | 1 | 3 | 6 | 7 | 5 | 2 | 4 | 8
4 | 6 | 2 | 8 | 9 | 3 | 7 | 1 | 5
7 | 5 | 8 | 2 | 4 | 1 | 6 | 9 | 3
8 | 3 | 9 | 1 | 6 | 4 | 5 | 7 | 2
5 | 7 | 4 | 9 | 3 | 2 | 8 | 6 | 1
6 | 2 | 1 | 5 | 8 | 7 | 9 | 3 | 4
3 | 4 | 5 | 7 | 2 | 6 | 1 | 8 | 9
1 | 8 | 7 | 3 | 5 | 9 | 4 | 2 | 6
2 | 9 | 6 | 4 | 1 | 8 | 3 | 5 | 7
true ;
false.
