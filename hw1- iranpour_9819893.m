clc;
clear;
close all;

a=20;
b=40;
V1=0;
V2=1000;
V3=0;
V4=0;

g=@(x,y) 1/(y^2+x^2);
h=1;

Nx=b/h-1;
Ny=a/h-1;
N=Nx*Ny;

row_ind=[];
col_ind=[];
A=[];

r=zeros(N,1);

for nn=1:N
    [i,j]=ind2sub([Nx,Ny],nn);
    row_ind=[row_ind nn];
    col_ind=[col_ind nn];
    A=[A -4];
    
    r(nn)=h^2*g(i*h,j*h);
    
    
    %if (j==Ny/2 && i==2)
     %   r(nn)=r(nn)-V4;
    %end
        

    
    if j==Ny
        r(nn)=r(nn)-V3;
    else
        nu=sub2ind([Nx Ny],i,j+1);
        row_ind=[row_ind nu];
        col_ind=[col_ind nn];
        A=[A 1];
    end
    
    
    if j==1
        r(nn)=r(nn)-V1;
    else
        nd=sub2ind([Nx Ny],i,j-1);
        row_ind=[row_ind nd];
        col_ind=[col_ind nn];
        A=[A 1];
    end
    
    
    
   if i==Nx
        r(nn)=r(nn)-V2;
    else
        nr=sub2ind([Nx Ny],i+1,j);
        row_ind=[row_ind nn];
        col_ind=[col_ind nr];
        A=[A 1];
    end 
    
    
    
    if i==1
        r(nn)=r(nn)-V4;
    else
        nl=sub2ind([Nx Ny],i-1,j);
        row_ind=[row_ind nn];
        col_ind=[col_ind nl];
        A=[A 1];
    end
    
end

As=sparse(row_ind,col_ind,A,N,N);

V=As\r;

x=0:h:b;
y=0:h:a;

phi=zeros(Nx+2,Ny+2);
phi(1,:)=V4;
phi(:,1)=V1;
phi(Nx+2,:)=V2;
phi(:,Ny+2)=V3;
%phi(1:3,9:10)=0;

V(352)=0;
V(353)=0;
V(390)=1000;
V(389)=1000;

for nn=1:N
    [i,j]=ind2sub([Nx,Ny],nn); 
    phi(i+1,j+1)=V(nn);
end

figure
contourf(x,y,phi.',101,'Linestyle','none')
xlabel('x(cm)')
ylabel('y(cm)')
title('V(v)')
colorbar


