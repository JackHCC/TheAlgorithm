clear all;close all;clc

n=20;                   %城市个数
temperature=100*n;      %初始温度
iter=100;               %内部蒙特卡洛循环迭代次数

%随机初始化城市坐标---------------------------------
city=struct([]);
for i=1:n
    city(i).x=floor(1+100*rand()); 
    city(i).y=floor(1+100*rand());
end

l=1;                            %统计迭代次数
len(l)=computer_tour(city,n);   %每次迭代后的路线长度  
netplot(city,n);                %初始旅行路线

while temperature>0.001     %停止迭代温度
    
    for i=1:iter     %多次迭代扰动，一种蒙特卡洛方法，温度降低之前多次实验
        len1=computer_tour(city,n);         %计算原路线总距离
        tmp_city=perturb_tour(city,n);      %产生随机扰动
        len2=computer_tour(tmp_city,n);     %计算新路线总距离
        
        delta_e=len2-len1;  %新老距离的差值，相当于能量
        if delta_e<0        %新路线好于旧路线，用新路线代替旧路线
            city=tmp_city;
        else                        %温度越低，越不太可能接受新解；新老距离差值越大，越不太可能接受新解
            if exp(-delta_e/temperature)>rand() %以概率选择是否接受新解
                city=tmp_city;      %可能得到较差的解
            end
        end        
    end
    l=l+1;
    len(l)=computer_tour(city,n);   %计算新路线距离
    temperature=temperature*0.99;   %温度不断下降
  
end  
figure;
netplot(city,n);    %最终旅行路线

figure;
plot(len)