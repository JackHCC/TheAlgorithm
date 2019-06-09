a = [0 2 6 4;
    inf 0 3 inf;
    7 inf 0 1 ;
    5 inf 12 0];
    
[d,r]=floyd(a)


disp('--------------------------')

for i = 1 : 4
  for j = 1 : 4
   DisplayPath(r, i, j);
  end
end
