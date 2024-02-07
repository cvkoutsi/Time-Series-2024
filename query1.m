clear;
clc;
close all;

%% Load data and select the team data 

table_data = readtable('ContestData.txt');
data = table2array(table_data(:,8));

%% Plot data

figure()
plot(data,'.-')
hold on
xlabel('t')
ylabel('y(t)')
title('Initial time series with trend and seasonality')

%% 1.a) Remove trend using trend estimation function

mean_sqare_error = [];

for i=2:5
   mv = polynomialfit(data,i);
   error = data - mv; 
   mse = mean((error).^2);
   mean_sqare_error = [mean_sqare_error, mse];
   
   figure(i)
   
   subplot(2,1,1)
   hold on
   plot(mv,'.-')
   plot(data,'-');
   xlabel('t')
   ylabel('y(t)')
   title('Original Data and Trend Estimation')
   hold off;
   
   subplot(2,1,2) 
   plot(error,'-')
   xlabel('t')
   ylabel('y(t)')
   title('Estimation Error for Polynomial Fit')

   sgtitle(['[p = ',num2str(i),'] Trend Estimation with Polynomial Fit'])
   disp(['[p = ', num2str(i), '] MSE = ',num2str(mse)]);
end

% Remove trend for p = 2
close all;

p=2;
mv = polynomialfit(data,p);
detrend_data = data - mv;

figure()
subplot(2,1,1)
plot(data,'.-')
hold on
xlabel('t')
ylabel('y(t)')
title('Initial time series with trend and seasonality')

subplot(2,1,2)
plot(detrend_data,'.-')
xlabel('t')
ylabel('x(t)')
title('Detrended time series with trend estimation of polynomial fit, p=',num2str(p))


%% 1.b) Remove trend using a moving average filter
% 
% maorder = input('Remove trend: Give an order for the moving average filter: > ');
% mv = movingaveragesmooth2(data,maorder);
% figure(2)
% clf
% plot(data,'.-')
% hold on
% plot(mv,'.-r')
% xlabel('t')
% ylabel('y(t)')
% title('time series with trend and seasonality')
% legend('original',sprintf('MA(%d) smooth',maorder),'Location','Best')
% 
% xv = data - mv;
% figure(3)
% clf
% plot(xv,'.-')
% xlabel('t')
% ylabel('x(t)')
% title(sprintf('detrended time series by MA(%d) smooth',maorder))
% 

%% Previous code (tests)
% polorder = linspace(2,5,4);
% errors = [];
% for i=2:5
%    polorder = i;
%    mv = polynomialfit(data,polorder);
%    error = data - mv; 
%    
%    error_mean = mean((data - mv).^2);
%
%    errors = [error, error];
%    
%    figure(i)
%    clf
%    subplot(2,1,1)
%    hold on
%    plot(mv,'.-')
%    plot(data,'-');
%    xlabel('t')
%    ylabel('y(t)')
%%     subtitle('Original data and polynomial fit')
%    hold off;
    
%    subplot(2,1,2)
    
%    plot(error,'-')
%    xlabel('t')
%    ylabel('y(t)')
%%     subtitle('Error from data and polynomial fit')
%    
%    title(['time series with trend and seasonality with polynomial order = ',num2str(i)])
%%     printf(error_mean);
%end