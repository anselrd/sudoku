function printboard( board )
% takes a 9-by-9 matrix and prints it as a sudoku board, printing zeros as
% empty spaces

% check input
if ~isa(board,'double')
    error('coordinates must be in a matrix')
elseif size(board,1) ~= 9 || size(board,2) ~= 9
    error('coordinates must be in a 9-by-9 matrix')
end

% print board
numprinted = 0; % count how many we've printed
board = board'; % flip so indexing goes through original rows
while numprinted < 81
    toprint = board(numprinted+1); % next entry
    if toprint == 0
        toprint = ' '; % don't print zeros
    else
        toprint = num2str(toprint);
    end
    % beginning of block?
    if mod(numprinted,27) == 0 && numprinted > 0
        fprintf('\n----------------------------------------------\n');
        fprintf('   %s',toprint);
    % new line?
    elseif mod(numprinted,9) == 0 && numprinted > 0
        fprintf('\n   %s',toprint);
    % new new block column?
    elseif mod(numprinted,3) == 0 && numprinted > 0
        fprintf('   |   %s',toprint);
    else % middle of a block
        fprintf('   %s',toprint);
    end
    % increment counter
    numprinted = numprinted + 1;
end
fprintf('\n\n%%\n\n'); % finish

end