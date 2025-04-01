clc; clear; close all; 
  
% ================ Represent s1(t) and s2(t) 
ts = 0.05;  % The sample time 
t1 = 0:   ts: 0.5 - 0.05; 
t2 = 0.5: ts: 1 - 0.05; 
t_1bit = [t1 t2];  % Time of 1 bit 
L = length(t_1bit); % The number of samples of 1 bit 
  
s1_t1 = 1.5*ones(1,length(t1)); 
s1_t2 = 0.5*ones(1,length(t2)); 
s1 = [s1_t1   s1_t2];  % s1(t) 
  
s2_t1 = 0*ones(1,length(t1)); 
s2_t2 = -2*ones(1,length(t2)); 
s2 = [s2_t1    s2_t2];  % s2(t) 
  
  
% ================ The transmitted signal  
Ntry = 10^1; % The total transmitted bits 
Bit = randsrc(1,Ntry,[0 1]) ;% Transmission with P1 = P2 = 0.5 
  
s = []; % The transmitted signal s(t) 
t = []; % The time of s(t) 
for i = 1:Ntry 
    if Bit(i) == 0 
        s = [s   s1]; 
    else 
        s = [s   s2]; 
    end 
     
    t_ibit = t_1bit + (i-1); % Time of i-bit 
    t = [t  t_ibit]; 
end 
  
% ================= The AWGN channel 
N0_2 = 0.05; % The noise power spectrum desity (W/Hz) N0/2 
B = 1/ts;    % Bandwidth of signals 
Power_noise = B*N0_2; % The power of noise  
w = sqrt(Power_noise)*randn(1,length(s)); 
  
% ================= The received signal 
r = s+w; 
  

 
figure(1) 
subplot(5,1,1) 
plot(t_1bit,s1,'b-','linewidth',1.8); hold on; 
xlabel('t (s)'); ylabel('s_1(t)'); 
axis([0 1.1 -1 1.6]) 
  
subplot(5,1,2) 
plot(t_1bit,s2,'r-','linewidth',1.8); 
xlabel('t (s)'); ylabel('s_2(t)') 
axis([0 1.1 -2.2 1]) 
  
x_note = 0.5 :1 :Ntry - 0.5; 
y_note = 2.4 *ones(1,Ntry); 
Text = string(Bit); 
subplot(5,1,3) 
plot(t,s,'g-','linewidth',1.8); 
text(x_note, y_note, Text); 
xlabel('t (s)'); ylabel('s(t)') 
axis([0 Ntry -3 3]) 
  
subplot(5,1,4) 
plot(t,w,'k-','linewidth',1.4); 
text(x_note, y_note, Text); 
xlabel('t (s)'); ylabel('w(t)') 
axis([0 Ntry -4 4]) 
  
subplot(5,1,5) 
plot(t,r,'m-','linewidth',1.8); 
text(x_note, y_note, Text); 
xlabel('t (s)'); ylabel('s(t)') 
axis([0 Ntry -3.2 3.2])
