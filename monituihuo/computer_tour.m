function len=computer_tour(city,n)   %计算路线总长度，每个城市只计算和下家城市之间的距离。
    len=0;
    for i=1:n-1
        len=len+sqrt((city(i).x-city(i+1).x)^2+(city(i).y-city(i+1).y)^2);        
    end
    len=len+sqrt((city(n).x-city(1).x)^2+(city(n).y-city(1).y)^2);
end

