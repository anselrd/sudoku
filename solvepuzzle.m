function [ solved ] = solvepuzzle( clues )

% initialize board
pen = clues; % answers we know
pencil = cell(9); % options for each other square
for k = 1:81
    if pen(k) == 0
        pencil{k} = 1:9;
    else
        pencil{k} = pen(k);
    end
end
lengths = clues./clues; 
lengths(isnan(lengths)) = 9; % number of options for each square??
r = mod(sum(lengths,2),9); % number in each row that are known??
c = mod(sum(lengths,1),9); % number in each column that are known??

% solved flag
solved = 0;

% sum of 1-9
S = sum(1:9); % cool way of writing 45 lol

while ~solved
    % look at every element
    for k = 1:9 % k = ROWS
        for j = 1:9 % j = COLUMNS
            if lengths(k,j) == 1 
                % if this entry has been solved
                if pen(k,j) == 0 
                    % if we haven't written the solution, write it
                    pen(k,j) = pencil{k,j}(1);
                else
                    % otherwise leave it alone
                    continue
                end
            else
                if r(k) == 8
                    % if this is the last element in its row, fill it in
                    lengths(k,j) = 1;
                    pen(k,j) = S - sum(pen(k,:));
                    r(k) = 9;
                elseif c(j) == 8
                    % if this is the last element in its column, fill it in
                    lengths(k,j) = 1;
                    pen(k,j) = S - sum(pen(:,j));
                    c(j) = 9;
                elseif lengths(k,j) + length(unique([pen(k,:) pen(:,j)'])) ~= 9
                    % if we haven't used this element's column and row to
                    % eliminate possibilities, do that
                    removed = 0;
                    for n = 1:lengths(k,j)
                        % if a pencil mark appears in row k or column j for
                        % this element, erase it
                        if any(pen(k,:)==pencil{k,j}(n-removed)) || any(pen(:,j)==pencil{k,j}(n-removed))
                            pencil{k,j} = pencil{k,j}(pencil{k,j}~=pencil{k,j}(n-removed));
                            removed = removed + 1;
                        end
                    end
                    lengths(k,j) = length(pencil{k,j});
                end
            end
        end
    end
    
    solved = all(all(lengths==1));
end

if checkpuzzle(pen)
    solved = pen;
else
    error('solution incorrect')
end

end