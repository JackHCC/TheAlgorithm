clear
clc
%% MM1�޺͵����е�ͨ���������̨����ʽ
N=100;%�˿�����
M=4;%����̨����
lambda0=4.65;%�˿͵ĵ����ʣ�ÿ����ƽ������4.65�ˣ�
%%
%�˿͵�ƽ������ʱ��
l0=1/lambda0;
%ÿ�������ƽ������ʱ�䣬ʱ�䵥λ��Ϊ����
lambda1=11.21/60;
lambda2=13.2/60;
lambda3=27/60;
lambda4=13.2/60;
%%
%����ָ���ֲ��������˿͵����ʱ����
arr_interval= exprnd(l0,1,N);
%���˿͵ĵ���ʱ�̵���ʱ�������ۻ���
arr_moment= cumsum(arr_interval);
%����ָ���ֲ�����ÿ���˿��ڸ�����ķ���ʱ��serve(i,j)��ʾ��i���˿��ڵ�j������ķ���ʱ��
serve(:,1)=exprnd(lambda1,1,N)';
serve(:,2)=exprnd(lambda2,1,N)';
serve(:,3)=exprnd(lambda3,1,N)';
serve(:,4)=exprnd(lambda4,1,N)';
%%
%��i���˿��ڵ�j�����򻨷ѵ�ʱ��ΪA(i,j)��i=1:100,j=1:4,���ѵ�ʱ����ڷ����ʱ����ϵȴ���ʱ�䣩
%��i���˿��뿪��j�������ʱ��ΪB(i,j)
%�ڼ��費������֮�仨�ѵ�ʱ���������������һ����ϵ:�����j�������ʱ�̵����뿪��j-1�������ʱ��
A=zeros(N,M);
%�ȼ����һ���˿͵Ļ���ʱ����뿪ʱ�̣�Ȼ����õ����ķ��������ʣ�����г˿͵Ļ���ʱ��
A(1,:)=serve(1,:);
B(1,1)=A(1,1)+arr_moment(1);
for j=2:4
   B(1,j)=B(1,j-1)+A(1,j);
end
for i=2:N
    for j=1:M
        
        if j==1
            if arr_moment(i)<B(i-1,j)%��i���˿͵����1�������ʱ���ڵ�i-1���˿��뿪��1������֮ǰ
               A(i,j)=B(i-1,j)-arr_moment(i)+serve(i,j);
               B(i,j)=B(i-1,j)+serve(i,j);
            else
               A(i,j)=serve(i,j);
               B(i,j)=arr_moment(i)+serve(i,j);
            end
    
        else
            if B(i,j-1)<B(i-1,j)%��i���˿͵����j��jΪ2:5���������ʱ���ڵ�i-1���˿��뿪��j������֮ǰ
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
%��ͼ
%��һ��ͼ�����г˿��ڸ��������ڻ��ѵ���ʱ��
a=sum(A);
c=categorical({'A2','B1','B2','C'});
figure;
bar(c,a);
%%
%�ڶ���ͼ��������ʱ����ڣ�������������ĳ˿�������ʵʱ�仯
C=[arr_moment' B];%��һ�������г˿͵����1�������ʱ��
%�����ͼ��Ҫ�ȹ۲����ݣ����Ҳ���������ʱ��ζ�ȡһ����ʱ�������еĵط���ȡ��ϸ����Щ�ط�����ȡ�ÿ�һ��,�����ƺ�Ҳ���鷳
c1=floor(C(1,1));
c2=ceil(C(N,5));
c3=length(c1:0.1:c2);
D=zeros(5,c3);%D����ĵ�һ���Ǹ���ʱ�̣�2~4�м�¼���Ǹ�ʱ��ǰ��ÿ�������ڵĳ˿�����
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






