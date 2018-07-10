function [ solved ] = solvepuzzle( clues )
%todo: write a description here

% initialize board with given clues
pen = clues;
pencil = cell(9);
for k = 1:81
    if pen(k) == 0
        pencil{k} = 1:9;
    else
        pencil{k} = pen(k);
    end
end
% determine how many knowns are in each row and column and how many options
% there are for each square on the board
lengths = clues./clues;
lengths(isnan(lengths)) = 9;

% set the sub-box bounds
sub = [1 1 1 4 4 4 7 7 7; 3 3 3 6 6 6 9 9 9]';

% iterate until solved
while 1
    
    % look at every element that hasn't been solved yet, starting by
    % looping through rows, then columns
    for k = 1:9
        for j = 1:9
            
            % ignore solved entries
            if pen(k,j) == 0
                
                if lengths(k,j) == 1
                    
                    % if process of elimination has identified the
                    % solutions for this box, write it in
                    pen(k,j) = pencil{k,j}(1);
                    
                else
                    
                    % get the known entries in the row, column, and sub-box
                    % corresponding to the current element
                    row = pen(k,:)';
                    column = pen(:,j);
                    sub_box = pen(sub(k,1):sub(k,2),sub(j,1):sub(j,2));
                    
                    % the intersection of these three can be eliminated
                    % from the pencil list of this element
                    eliminations = unique([row; column; sub_box(:)]);
                    
                    % loop through the pencil list removing any list
                    % entries that match an entry in 'eliminations'
                    removed = 0;
                    for n = 1:lengths(k,j)
                        if any(eliminations==pencil{k,j}(n-removed))
                            pencil{k,j} = pencil{k,j}(pencil{k,j}~=pencil{k,j}(n-removed));
                            removed = removed + 1;
                        end
                    end
                    lengths(k,j) = length(pencil{k,j});
                    
                end
                
            end
            
            % check for a finished puzzle
            if all(all(lengths==1))
                break
            end
            
        end
    end
    
end

% check validity of puzzle solution
if checkpuzzle(pen)
    solved = pen;
else
    error('solution incorrect')
end

end