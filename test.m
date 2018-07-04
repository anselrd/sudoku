testvec = 1:7;
r = [2 6 9];
c = [3 4];

removed = 0;
for n = 1:7
    if any(r==testvec(n-removed)) || any(c==testvec(n-removed))
        testvec = testvec(testvec~=testvec(n-removed));
        removed = removed + 1;
    end
end

testvec