function  [Mag,MagX,MagY]=hatching1(Img,angle,x0,y0)
% 图像矩阵的行相当于图像坐标轴中的Y，图像矩阵中的列相当于图像坐标轴中的X
% 从全天空图像中过中心取剖线，角度为angle
% MagNS:    中国北极站全天空图像剖线数组
% img:      中国北极站全天空图像矩阵（512*512）
% band:     图像波段: 'V','G','R'
% 4278：
% 中心为（257，255），半径为r=246
% 中国站－地磁北极连线与y=255的夹角为：27.3682°
% 5577：
% 中心为（261，257），半径为r=246
% 中国站－地磁北极连线与y=257的夹角为：28.8664°
% 6300：
% 中心为（256，257），半径为r=246
% 中国站－地磁北极连线与y=257的夹角为：27.8340°
r=246;
angle=deg2rad(angle);%转化为弧度
n=0;
for x=512:-1:1
    y=round(y0-tan(angle)*(x-x0));
    if (x-x0)^2+(y-y0)^2<(r+1)^2
        n=n+1;
        MagX(n)=x;
        MagY(n)=y;
        Mag(n)=Img(y,x);
    end
end
%     [m0,n0]=size(Mag);
%     for i=1:n0/2
%         temp=MagY(i);
%         MagY(i)=MagY(n0+1-i);
%         MagY(n0+1-i)=temp;
%     end
 