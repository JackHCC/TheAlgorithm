function len=computer_tour(city,n)   %����·���ܳ��ȣ�ÿ������ֻ������¼ҳ���֮��ľ��롣
    len=0;
    for i=1:n-1
        len=len+sqrt((city(i).x-city(i+1).x)^2+(city(i).y-city(i+1).y)^2);        
    end
    len=len+sqrt((city(n).x-city(1).x)^2+(city(n).y-city(1).y)^2);
end

