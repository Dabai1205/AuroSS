function [indarc,arc,arctheta,np]=arcfinding(image,theta)

simage=smooth(image,5);        % ������ƽ������һЩС����ȥ��
ind=find(abs(theta)<70);       % �����Ǳ߽總��������
image1=simage(ind);
[m,n]=size(image1);           % mΪ���������n=1
peak0=zeros(10,1);
indpeak0=zeros(10,1);          % ��Ϊ����������������������10��
np=0;                          % ���������ĸ���
for i=2:(m-1)
    np0=0;                 % sign��0��ʾû�����������ķ����
    % -------------���жϣ� �����߶��󣻷��ֵ�����0.1��-------------
    if (image1(i)>image1(i-1)) & (image1(i)>=image1(i+1))           
        peak1=image1(i);
        j=i-2;
        while (j>0) & (image1(j)<=peak1 & np0==0)          
            di=peak1-image1(j);
            j=j-1;
            if di>0.1                                       % �������ڱ���С0.1��ֵ
                np0=1;
                j=0;
            end
            clear di
        end
        if np0==1
            np0=0;
            j=i+2;
            while (j<=m) & (image1(j)<=peak1 & np0==0)
                di=peak1-image1(j);
                j=j+1;
                if di>0.1
                    np0=1;
                    j=m+1;
                end
                clear di
            end
        end
        clear j
    end
    if np0==1                   % ����������������ķ壬�ҵ���λ�úͷ�ֵ�����ü�����1
        np=np+1;
        peak0(np)=peak1;
        indpeak0(np)=i+ind(1)-1;
    end
    clear np0
end
   

if np~=0
    indp=find(peak0>0);
    peak=peak0(indp);
    indpeak=indpeak0(indp);
    ptheta=theta(indpeak);    % �ѷ�0�Ļ���ֵ��������
    clear indp peak0 indpeak0
    if np>1
        i=2;
        while i<=np
            valley=min(simage(indpeak(i-1):indpeak(i)));
            if peak(i)<=peak(i-1)
                if peak(i)-valley<peak(i)/4.0
                    if np>2
                        peak(i:(np-1))=peak((i+1):np);
                        indpeak(i:(np-1))=indpeak((i+1):np);
                    end
                    peak(np)=0;
                    indpeak(np)=0;
                    np=np-1;
                end
            else
                if peak(i-1)-valley<peak(i-1)/4.0
                    peak((i-1):(np-1))=peak(i:np);
                    indpeak((i-1):(np-1))=indpeak(i:np);
                    peak(np)=0;
                    indpeak(np)=0;
                    np=np-1;
                end
            end
            i=i+1;
        end
    end
    arc(1:np)=peak(1:np);
    indarc(1:np)=indpeak(1:np);
    arctheta(1:np)=theta(indarc(1:np));
    
else
    arc=0;
    indarc=0;
    arctheta=0;
end



