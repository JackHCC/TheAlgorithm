function netplot(city,n)        %���߸����У���·�߻�����
    hold on;
    for i=1:n-1
        plot(city(i).x,city(i).y,'r*');  
        line([city(i).x city(i+1).x],[city(i).y city(i+1).y]);  %ֻ���ߵ�ǰ���к��¼ҳ���     
    end

    plot(city(n).x,city(n).y,'r*');  
    line([city(n).x city(1).x],[city(n).y city(1).y]);     %���һ�ҳ������ߵ�һ�ҳ���
    hold off;
end