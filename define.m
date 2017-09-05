
%%
%�������ݵ���ɢͼ,fig.1
figure
fidtx = fopen('tag_static_3');
readData = fread(fidtx, 'float');
fclose(fidtx);
readData = reshape(readData, 2, length(readData)/2).';
Origin = readData(:, 1) + 1j .* readData(:, 2);

rxdata = abs(Origin);
len=floor(length(rxdata)/10^5)*10^5;
data=rxdata(1:len,1);
%data=rxdata(1:3.7*10^6,1);
plot(data);
hold on;



%%
%moving average�� smooth ����50, fig.2
% figure
sm_len=50;
aver=zeros(length(data),1);
for i=1:1:(length(data)-sm_len)
    su=sum(data(i:i+sm_len,1));
    aver(i,1)=su/sm_len;
end
% plot(aver,'.'); 
%��50��average�����Ͻ���trace,�൱����һ��moving aver��fig3, fig.4
% figure
tra_len=100;
trace=zeros(length(aver)/tra_len,1);
for j=1:1:length(aver)/tra_len
    a=sum(aver((j-1)*tra_len+1:(j-1)*tra_len+tra_len,1));
    trace(j,1)=a/tra_len;
end
% plot(trace,'.'); 
% figure
% plot(trace);

%%
%Ϊ�˵õ�����fig.5
figure
data_aver_1=aver;
a_1=trace(1,1);  
n=1;
n_1=1;
% aver_2=(trace(1,1)+trace(2,1))/2;
aver_2=trace(1,1);
for x_1=2:1:length(trace)-1
     if(abs(trace(x_1,1)-aver_2)<0.07)
     %if(abs(trace(x_1,1)-trace(x_1-1,1))<5*abs((trace(x_1+1,1)-trace(x_1,1))))
        a_1=a_1+trace(x_1,1);
        n=n+1;
        aver_2=a_1/n;
    else
        aver_1=a_1/n;
        n=1;
        data_aver_1((n_1-1)*tra_len+1:(x_1-1)*tra_len,1)=aver_1;
        n_1=x_1;
        a_1=trace(x_1,1);
        aver_2=trace(x_1,1);
        x_1=x_1-1;
    end
    
end
plot(data_aver_1);

%%

%ȡ����, fig.6
%����ķ��Ⱥ���Ҫ��֮����������ķ���ֵ�������и���������am
data_aver_1=data_aver_1/max(data_aver_1);
figure
y=reshape(data_aver_1,500,length(data_aver_1)/500);
y=max(y);
for m=1:1:length(data_aver_1)/500
    data_aver_1((m-1)*500+1:(m-1)*500+500,1)=y(m);
end
plot(data_aver_1);
hold on;
am=data_aver_1;

%%
data_aver=data_aver_1;%֮���������ֵ��Ŀ����ϣ���ڷ�����ֱ�ӿ��и����

%%
%���켣�����磩,���������linspace
hold on
data_aver_1=data_aver_1(1:floor(length(data_aver_1)/12000)*12000);
y1=reshape(data_aver_1,12000,round(length(data_aver_1)/12000));
y1=min(y1);
for m1=1:1:round(length(data_aver_1)/12000)
    if (m1<round(length(data_aver_1)/12000))
    x=linspace(y1(m1),y1(m1+1),12000);
    data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=x;
    else
       data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=y1(m1);   
    end   
end
plot(data_aver_1,'r');
% figure
% plot(data_aver_1,'r');
% hold on

%%
%���µ�Ŀ�����и�
%�Թ켣�������ƽ��
sm=100000;
a1=data_aver_1(1,1);

%b1=zeros(floor(length(data_aver_1)/sm)-1,1);

for m2=1:1:floor(length(data_aver_1)/sm)
    s1=sum(data_aver_1((m2-1)*sm+1:sm*m2,1));
    x1=s1/sm;
    %b1(m2,1)=(x1-a1)/sm;
    x2=linspace(a1,x1,sm);
    a1=x1;
    data_aver_1((m2-1)*sm+1:(m2-1)*sm+sm,1)=x2; 
end
 figure
% plot(data_aver_1,'g');
% 
% %b1=b1/max(b1);
% 
% hold on

%%
%�Թ켣���������ν���ƽ��
sm=100000;
a1=data_aver_1(1,1);

%b1=zeros(floor(length(data_aver_1)/sm)-1,1);

for m2=1:1:floor(length(data_aver_1)/sm)
    s1=sum(data_aver_1((m2-1)*sm+1:sm*m2,1));
    x1=s1/sm;
    %b1(m2,1)=(x1-a1)/sm;
    x2=linspace(a1,x1,sm);
    a1=x1;
    data_aver_1((m2-1)*sm+1:(m2-1)*sm+sm,1)=x2; 
end
plot(data_aver_1,'b');
% hold on;
%%
%�ٴ�ƽ��
sm=150000;
a1=data_aver_1(1,1);

b1=zeros(floor(length(data_aver_1)/sm)-1,1);

for m2=1:1:floor(length(data_aver_1)/sm)
    s1=sum(data_aver_1((m2-1)*sm+1:sm*m2,1));
    x1=s1/sm;
    b1(m2,1)=(x1-a1)/sm;
    x2=linspace(a1,x1,sm);
    a1=x1;
    data_aver_1((m2-1)*sm+1:(m2-1)*sm+sm,1)=x2; 
end
% figure
% plot(data_aver_1,'r');
figure
plot(data_aver_1,'r');
a3=b1;
b1=b1*10^6;%��������������˹�һ��
%%
%���б��ֵ
hold on
a2=zeros(length(b1)*sm,1);
for m3=1:1:length(b1)
    a2((m3-1)*sm+1:(m3-1)*sm+sm,1)=b1(m3);
end
hold on
plot(a2)
hold on
% figure
% plot(a2)
%%
%�и�
seg=zeros(20,1);
seg(1,1)=1;
i=0;
n2=2;
for n1=1:1:length(b1)
    if(abs(b1(n1))<=0.12)%�и�����0.3
        i=i+1;
        if (n1==length(b1)&&(i>=3))
             seg(n2-1,1)=n1-i;
             seg(n2,1)=n1;
        end
    elseif (i>=3)
        seg(n2-1,1)=n1-i-1;
        seg(n2,1)=n1-1;
        n2=n2+2;
        i=0;
    else
        i=0;
    end
end
n=0;
for i=1:1:length(seg)
     if (seg(i,1)~=0)
       n=n+1;
    end
end
seg_1=seg(1:n+1,1);
seg_1(1,1)=0;
seg_1=sm*seg_1;
for i=1:1:length(seg_1)
    if (seg_1(i,1)~=0)
        seg_1(i,1)=seg_1(i,1)-sm;
    end
end
for i=1:1:length(seg_1)
   plot([seg_1(i,1),seg_1(i,1)],[-1,1])
   hold on
end
figure
plot(data_aver)
hold on
for i=1:1:length(seg_1)
   plot([seg_1(i,1),seg_1(i,1)],[0,1])
   hold on
end
%�и����и��ȫ��seg_1��




%%
%�ж�
%����ȡ���и������η���
sta_be=am(1:seg_1(2,1),1);
sta_af=am(seg_1(3,1):seg_1(4,1),1);
%���ú���sq_aver
% figure
data_aver_1=sta_be;

% plot(data_aver_1);

%%
%����ȡ�ķ������󷽲�
figure

a_1=data_aver_1(1,1);  
n=1;
n_1=1;

aver_2=data_aver_1(1,1);
for x_1=2:1:length(data_aver_1)-1
     if(abs(data_aver_1(x_1,1)-aver_2)<0.05)
     
        a_1=a_1+data_aver_1(x_1,1);
        n=n+1;
        aver_2=a_1/n;
    else
        aver_1=a_1/n;
        n=1;
        data_aver_1(n_1:x_1-1,1)=aver_1;
        n_1=x_1;
        a_1=data_aver_1(x_1,1);
        aver_2=data_aver_1(x_1,1);
        x_1=x_1-1;
    end
    
end
plot(data_aver_1);
hold on
% am_sq=data_aver_1(1:1.8*10^6,1);
% plot(am_sq,'r');
%%
%ȡ����, fig.7
%figure
a=data_aver_1;

%�°���
data_aver_1=data_aver_1(1:floor(length(data_aver_1)/12000)*12000);
y1=reshape(data_aver_1,12000,round(length(data_aver_1)/12000));
y1=min(y1);
for m1=1:1:round(length(data_aver_1)/12000)
    data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=y1(m1);
end
plot(data_aver_1,'r');
baoluo_down=data_aver_1;
hold on;
% figure
% plot(data_aver_1,'r');
%plot(data_aver_1,'.');

%�ϰ���
data_aver_1=a;
data_aver_1=data_aver_1(1:floor(length(data_aver_1)/12000)*12000);
y1=reshape(data_aver_1,12000,round(length(data_aver_1)/12000));
y1=max(y1);
for m1=1:1:round(length(data_aver_1)/12000)
    data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=y1(m1);
end
plot(data_aver_1,'g');
baoluo_up=data_aver_1;
am_var=abs(baoluo_up-baoluo_down);
am_var_aver_1=sum(am_var/length(am_var))


%%
%�ڶ������ݵ���
% figure
data_aver_1=sta_af;

% plot(data_aver_1);

%%
%����ȡ�ķ������󷽲�
figure

a_1=data_aver_1(1,1);  
n=1;
n_1=1;

aver_2=data_aver_1(1,1);
for x_1=2:1:length(data_aver_1)-1
     if(abs(data_aver_1(x_1,1)-aver_2)<0.05)
     
        a_1=a_1+data_aver_1(x_1,1);
        n=n+1;
        aver_2=a_1/n;
    else
        aver_1=a_1/n;
        n=1;
        data_aver_1(n_1:x_1-1,1)=aver_1;
        n_1=x_1;
        a_1=data_aver_1(x_1,1);
        aver_2=data_aver_1(x_1,1);
        x_1=x_1-1;
    end
    
end
plot(data_aver_1);
hold on
% am_sq=data_aver_1(1:1.8*10^6,1);
% plot(am_sq,'r');
%%
%ȡ����, fig.7
%figure
a=data_aver_1;

%�°���
data_aver_1=data_aver_1(1:floor(length(data_aver_1)/12000)*12000);
y1=reshape(data_aver_1,12000,round(length(data_aver_1)/12000));
y1=min(y1);
for m1=1:1:round(length(data_aver_1)/12000)
    data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=y1(m1);
end
plot(data_aver_1,'r');
baoluo_down=data_aver_1;
hold on;
% figure
% plot(data_aver_1,'r');
%plot(data_aver_1,'.');

%�ϰ���
data_aver_1=a;
data_aver_1=data_aver_1(1:floor(length(data_aver_1)/12000)*12000);
y1=reshape(data_aver_1,12000,round(length(data_aver_1)/12000));
y1=max(y1);
for m1=1:1:round(length(data_aver_1)/12000)
    data_aver_1((m1-1)*12000+1:(m1-1)*12000+12000,1)=y1(m1);
end
plot(data_aver_1,'g');
baoluo_up=data_aver_1;
am_var=abs(baoluo_up-baoluo_down);
am_var_aver_2=sum(am_var/length(am_var))

%%
%�ж���
def=abs(20*log10(am_var_aver_2/am_var_aver_1))
if(def<2)
    disp('No!off-body');
else
    disp('Yes!on-body');
end