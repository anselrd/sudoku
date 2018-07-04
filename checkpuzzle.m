function [ valid, varargout ] = checkpuzzle( solution )
% takes a 9-by-9 matrix and makes sure every row and column have a unique
% 1:9
% Inputs:
%        solution - a 9-by-9 matrix of a solved puzzle
% Outputs: valid - boolean for a fully solved puzzle
%          varargout
%          rf - number of rows that fail to have 1:9
%          cf - number of columns that fail to have 1:9
%          sf - number of 3x3 squares that fail to have 1:9


% the new puzzle checking logic should account for this
% % THIS LOGIC MIGHT NOT WORK I HAVEN'T TESTED IT
% % check to make sure all numbers are integers between 1 and 9
% if sum(sum((solution < 1)+(solution > 9)+(mod(solution,1) ~= 0))) ~= 0
%     valid = 0;
%     error("Cannot continue checking - numbers in solution are not integers between 1 and 9")
%     return
% end

% initialize outputs
valid = 1;
rf = 0;
cf = 0;
sf = 0;

% check puzzle
for k = 1:9
    % get unique row and column values
    rk = sort(unique(solution(k,:)));
    ck = sort(unique(solution(:,k)));
    % get unique square values
    rid = ceil(k/3);
    cid = mod(k-1,3) + 1;
    disp(solution(rid*3-2:rid*3,cid*3-2:cid*3))
    sk = sort(unique(solution(rid*3-2:rid*3,cid*3-2:cid*3)));
    
    switch valid
        case 1
            if length(rk) ~= 9 || ~all(rk == 1:9)
                valid = 0;
                rf = rf + 1;
            elseif length(ck) ~= 9 || ~all(ck == 1:9)
                valid = 0;
                cf = cf + 1;
            elseif length(ck) ~= 9 || ~all(sk'==1:9)
                valid = 0;
                sf = sf + 1;
            end
        case 0
            if length(rk) ~= 9 || ~all(rk == 1:9)
                rf = rf + 1;
            elseif length(ck) ~= 9 || ~all(ck == 1:9)
                cf = cf + 1;
            elseif length(sk) ~= 9 || ~all(sk'==1:9)
                sf = sf + 1;
            end
    end
end

% return the number of faults
varargout{1} = rf;
varargout{2} = cf;
varargout{3} = sf;

end