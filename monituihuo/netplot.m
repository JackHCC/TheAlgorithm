function netplot(city,n)        %连线各城市，将路线画出来
    hold on;
    for i=1:n-1
        plot(city(i).x,city(i).y,'r*');  
        line([city(i).x city(i+1).x],[city(i).y city(i+1).y]);  %只连线当前城市和下家城市     
    end

    plot(city(n).x,city(n).y,'r*');  
    line([city(n).x city(1).x],[city(n).y city(1).y]);     %最后一家城市连线第一家城市
    hold off;
end