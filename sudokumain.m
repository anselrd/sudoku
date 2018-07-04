% Ansel Rothstein-Dowden
% Sudoku Main Script

% clear workspace
ccc

% read and solve puzzle
%filename = input('Enter the name of the input file in single quotes: ');
%clues = readpuzzle(filename);
clues = readpuzzle('./puzzles/puzzle.txt');
printboard(clues)
solved = solvepuzzle(clues);
printboard(solved)