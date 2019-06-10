clear
clc
%% MM1∞和单队列单通道—多服务台串联式
N=100;%乘客总数
M=4;%服务台总数
lambda0=4.65;%乘客的到达率（每分钟平均到达4.65人）
%%
%乘客的平均到达时间
l0=1/lambda0;
%每个区域的平均服务时间，时间单位均为分钟
lambda1=11.21/60;
lambda2=13.2/60;
lambda3=27/60;
lambda4=13.2/60;
%%
%按负指数分布产生各乘客到达的时间间隔
arr_interval= exprnd(l0,1,N);
%各乘客的到达时刻等于时间间隔的累积和
arr_moment= cumsum(arr_interval);
%按负指数分布产生每个乘客在各区域的服务时间serve(i,j)表示第i个乘客在第j个区域的服务时间
serve(:,1)=exprnd(lambda1,1,N)';
serve(:,2)=exprnd(lambda2,1,N)';
serve(:,3)=exprnd(lambda3,1,N)';
serve(:,4)=exprnd(lambda4,1,N)';
%%
%第i个乘客在第j个区域花费的时间为A(i,j)（i=1:100,j=1:4,花费的时间等于服务的时间加上等待的时间）
%第i个乘客离开第j个区域的时刻为B(i,j)
%在假设不计区域之间花费的时间的条件下有这样一个关系:到达第j个区域的时刻等于离开第j-1个区域的时刻
A=zeros(N,M);
%先计算第一个乘客的花费时间和离开时刻，然后采用迭代的方法计算出剩下所有乘客的花费时间
A(1,:)=serve(1,:);
B(1,1)=A(1,1)+arr_moment(1);
for j=2:4
   B(1,j)=B(1,j-1)+A(1,j);
end
for i=2:N
    for j=1:M
        
        if j==1
            if arr_moment(i)<B(i-1,j)%第i个乘客到达第1个区域的时刻在第i-1个乘客离开第1个区域之前
               A(i,j)=B(i-1,j)-arr_moment(i)+serve(i,j);
               B(i,j)=B(i-1,j)+serve(i,j);
            else
               A(i,j)=serve(i,j);
               B(i,j)=arr_moment(i)+serve(i,j);
            end
    
        else
            if B(i,j-1)<B(i-1,j)%第i个乘客到达第j（j为2:5）个区域的时刻在第i-1个乘客离开第j个区域之前
                A(i,j)=B(i-1,j)-B(i,j-1)+serve(i,j);
                B(i,j)=B(i-1,j)+serve(i,j);
            else
                A(i,j)=serve(i,j);
                B(i,j)=B(i,j-1)+serve(i,j);
            end
        end
    end
end
%%
%绘图
%第一张图：所有乘客在各个区域内花费的总时间
a=sum(A);
c=categorical({'A2','B1','B2','C'});
figure;
bar(c,a);
%%
%第二张图：在整个时间段内，各个区域包含的乘客人数的实时变化
C=[arr_moment' B];%第一列是所有乘客到达第1个区域的时刻
%画这个图需要先观察数据，而且不能在整个时间段都取一定的时间间隔，有的地方得取得细，有些地方可以取得宽一点,但是似乎也很麻烦
c1=floor(C(1,1));
c2=ceil(C(N,5));
c3=length(c1:0.1:c2);
D=zeros(5,c3);%D矩阵的第一行是各个时刻，2~4行记录的是该时刻前在每个区域内的乘客人数
D(1,:)=c1:0.1:c2;
for i=1:c3
    for j=1:M
        for k=1:N
            if D(1,i)<C(k,j)
                break
            elseif D(1,i)>C(k,j)&&D(1,i)<C(k,j+1)
                D(j+1,i)=D(j+1,i)+1;
            elseif D(1,i)>C(k,j+1)&&D(j+1,i)~=0    
                break
            end
        end
    end
end
figure
hold on
p1=plot(D(1,:),D(2,:),'r');
p2=plot(D(1,:),D(3,:),'g');
p3=plot(D(1,:),D(4,:),'b');
p4=plot(D(1,:),D(5,:),'y');
legend([p1 p2 p3 p4],'A2','B1','B2','C');






