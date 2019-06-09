clear all;close all;clc

n=20;                   %���и���
temperature=100*n;      %��ʼ�¶�
iter=100;               %�ڲ����ؿ���ѭ����������

%�����ʼ����������---------------------------------
city=struct([]);
for i=1:n
    city(i).x=floor(1+100*rand()); 
    city(i).y=floor(1+100*rand());
end

l=1;                            %ͳ�Ƶ�������
len(l)=computer_tour(city,n);   %ÿ�ε������·�߳���  
netplot(city,n);                %��ʼ����·��

while temperature>0.001     %ֹͣ�����¶�
    
    for i=1:iter     %��ε����Ŷ���һ�����ؿ��巽�����¶Ƚ���֮ǰ���ʵ��
        len1=computer_tour(city,n);         %����ԭ·���ܾ���
        tmp_city=perturb_tour(city,n);      %��������Ŷ�
        len2=computer_tour(tmp_city,n);     %������·���ܾ���
        
        delta_e=len2-len1;  %���Ͼ���Ĳ�ֵ���൱������
        if delta_e<0        %��·�ߺ��ھ�·�ߣ�����·�ߴ����·��
            city=tmp_city;
        else                        %�¶�Խ�ͣ�Խ��̫���ܽ����½⣻���Ͼ����ֵԽ��Խ��̫���ܽ����½�
            if exp(-delta_e/temperature)>rand() %�Ը���ѡ���Ƿ�����½�
                city=tmp_city;      %���ܵõ��ϲ�Ľ�
            end
        end        
    end
    l=l+1;
    len(l)=computer_tour(city,n);   %������·�߾���
    temperature=temperature*0.99;   %�¶Ȳ����½�
  
end  
figure;
netplot(city,n);    %��������·��

figure;
plot(len)