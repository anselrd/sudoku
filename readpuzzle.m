function [ clues ] = readpuzzle( filename )
% reads in clue positions from txt file
% expected format:
% 
% #  ...
% #  comments
% #  ...
% 0 0 0 3 0 0 2 1 0
% 9 2 0 6 0 0 4 5 0
% .
% .
% .
% 0 2 7 0 0 8 0 0 0
% 
% The puzzle should appear as it does on paper, with empty cells
% represented by zeros

% open file
fid = fopen(filename);

% make variables
counter = 0;
clues = zeros(9); % creates nonempty struct

% get first line
line = fgetl(fid);

% read
while line ~= -1
    if line(1) ~= '#'
        % at a new line
        counter = counter + 1;
        if length(str2num(line)) ~= 9 % does not work with str2double
            error('lines must be 9 numbers long')
        end
        clues(counter,:) = str2num(line); % does not work with str2double
        if counter == 9
            break
        end
    end
    line = fgetl(fid);
end

% read again to check for extra lines
line = fgetl(fid);
while line ~= -1
    if line(1) ~= '#'
        % at a new line
        error('too many rows in puzzle')
    end
    line = fgetl(fid);
end

% number of clues
totalclues = sum(sum(clues > 0));

% final error check
if counter ~= 9
    error('there were not entries for all numbers 1-9')
elseif totalclues < 17
    error('the puzzle is not solvable uniquely')
end

end