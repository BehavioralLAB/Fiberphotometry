%input filename, output 3 figure,the Gcamp mean for different position, and mouse motive track,and
%track hearmap.
%data(:,1) and data(:,2) are x and y corrdinary of mice,data(:,3) is Gcamp
%CWQ,190618
%eg. filename='1.csv'
file=dir('*.csv')
for i=1:length(file)
    filename=file(i).name;
    data=importdata(filename);
    %data=data.Sheet1;
    n=strfind(filename,'.');
    fn=filename(1:n-1);
    d(:,1)=data(:,1);
    d(:,2)=data(:,2);
    udata=unique(d,'rows');
    xa=max(data(:,1));
    xb=min(data(:,1));
    ya=max(data(:,2));
    yb=min(data(:,2));
    x=xa-xb+2;
    y=ya-yb+2;
    h=zeros(x,y);
    f=zeros(x,y);
   for ii=1:length(udata)
       M=udata(ii,1);
       N=udata(ii,2);
       [a]=find(data(:,1)==M & data(:,2)==N);%寻找相同坐标位置的数量，并将其储存至相应的坐标区
       n=length(a)/30;% 转化为时间
       M=udata(ii,1)-xb+1;
       N=udata(ii,2)-yb+1;
       temp=data([a],3);
       gcamp=mean(temp);
       udata(ii,3)=gcamp;
       h(M,N)=gcamp;
       f(M,N)=n;
       [b]=find(f==0);
       f([b])=nan;
       h([b])=nan;%将动物未到达的地方设置为NAN
   end
   temp=h';
   %h=smoothdata(temp,1,'gaussian',4);;%高斯平滑
   %h=smoothdata(h,2,'gaussian',4)
   h=temp;
   figure
   set(gcf,'position',[100,100,500,450]);
   set(gcf,'name','Gcamp');
   H=heatmap(h);
   H.Colormap=jet;
   H.ColorScaling='log'
   H.GridVisible='off'
   %H.MissingDataLabel=[0.00,0.00,0.00];
   %H.ColorLimits = [10e-5 10e-3]
%    for j=1:length(H.XDisplayLabels)
%         H.XDisplayLabels{j}=' ';
%    end
%    for j=1:length(H.YDisplayLabels)
%        H.YDisplayLabels{j}=' ';
%    end
   fn1=strcat(fn,'-Gcamp.fig');
   saveas(gcf,fn1)
   temp=f';
   f=temp;
   %f=smoothdata(temp,1,'gaussian',4);%高斯平滑
   %f=smoothdata(f,2,'gaussian',4);
   figure
   set(gcf,'position',[100,100,500,450])
   set(gcf,'name','Track_heatmap')
  F=heatmap(f)
  F.Colormap=jet;
  F.ColorScaling='log'
  F.GridVisible='off'
  %F.MissingDataLabel=[0.00,0.00,0.00];
  %F.ColorLimits = [0.1 0.1]
%    for j=1:length(F.XDisplayLabels)
%       F.XDisplayLabels{j}=' ';
%    end
%    for j=1:length(F.YDisplayLabels)
%       F.YDisplayLabels{j}=' ';
%    end
   fn2=strcat(fn,'-Track_heatmap.fig');
   saveas(gcf,fn2);
   figure
   set(gcf,'position',[100,100,500,450])
   set(gcf,'name','Track')
   x=data(:,1);
   y=data(:,2);
   plot(x,y)
   set(gca,'YDir','reverse')
   axis off;
   fn3=strcat(fn,'-Track.fig');
   saveas(gcf,fn3)
  clear d data
  close all
end