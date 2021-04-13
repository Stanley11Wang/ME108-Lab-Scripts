% Stanley Wang
% UC Berkeley Spring 2021
% Professor Komvopoulos ME 108
% LAB 1 Results

clear all; close all; clc;
data = xlsread('Rockwell 14.xlsx');

%% CALIBRATION PLOTS

% Data points are in the format of (test value, actual value)
test_479B = [data(1, 1:4)', ones(4,1)*47.9];
test_941B = [data(2, 1:3)', ones(3,1)*94.1];
test_278C = [data(4, 1:3)', ones(3,1)*27.8];
test_621C = [data(5, 1:3)', ones(3,1)*62.1];

% Rockwell B scale calibration
x = [test_479B(:,1); test_941B(:,1)];
y = [test_479B(:,2); test_941B(:,2)];
[Ba, Bb, BR2] = linearfit(x, y);

figure(1)
clf reset
plot(test_479B(:,1), test_479B(:,2), 'or', 'markersize', 16, 'linewidth', 1.2);
hold on;
plot(test_941B(:,1), test_941B(:,2), 'ob', 'markersize', 16, 'linewidth', 1.2);
xp = [0,1000];
plot(xp, Ba*xp + Bb, '--k', 'linewidth', 1.2);

grid on; axis([50 105 45 100]); yticks(50:10:100);
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Experimental Value'); ylabel('Actual Value'); title('Rockwell B Scale Calibration');
legend('Test Block 47.9 HRB', 'Test Block 94.1 HRB', 'Linear Regression Line', 'fontsize', 16, 'location', 'southeast');
legend boxoff;
txt1 = ['HRB_a = ',num2str(Ba,3),' HRB_e – ', num2str(abs(Bb))];
text(0.2, 0.7, txt1, 'unit', 'normalized', 'fontsize', 16, 'fontname', 'Times New Roman')
txt2 = ['R^2 = ',num2str(BR2,5)];
text(0.2, 0.64, txt2, 'unit', 'normalized', 'fontsize', 16, 'fontname', 'Times New Roman')

% Rockwell C scale calibration
x = [test_278C(:,1); test_621C(:,1)];
y = [test_278C(:,2); test_621C(:,2)];
[Ca, Cb, CR2] = linearfit(x, y);

figure(2)
clf reset
plot(test_278C(:,1), test_278C(:,2), 'or', 'markersize', 16, 'linewidth', 1.2);
hold on;
plot(test_621C(:,1), test_621C(:,2), 'ob', 'markersize', 16, 'linewidth', 1.2);
xp = [0,1000];
plot(xp, Ca*xp + Cb, '--k', 'linewidth', 1.2);

grid on; axis([25 65 25 65]);
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Experimental Value'); ylabel('Actual Value'); title('Rockwell C Scale Calibration');
legend('Test Block 27.8 HRC', 'Test Block 62.1 HRC', 'Linear Regression Line', 'fontsize', 16, 'location', 'southeast');
legend boxoff;
txt1 = ['HRC_a = ',num2str(Ca,3),' HRC_e – ', num2str(abs(Cb))];
text(0.2, 0.7, txt1, 'unit', 'normalized', 'fontsize', 16, 'fontname', 'Times New Roman')
txt2 = ['R^2 = ',num2str(CR2,5)];
text(0.2, 0.64, txt2, 'unit', 'normalized', 'fontsize', 16, 'fontname', 'Times New Roman')

figure(1)
print -depsc -r600 'B_calibrate'
figure(2)
print -depsc -r600 'C_calibrate'

%% RESCALING OF TEST DATA
NHT1045B = data(7, 1:3);
HT1045B = data(8, 1:3);
NHT1045C = data(10, 1:3);
HT1045C = data(11, 1:3);
NHTA36B = data(13, 1:3);
HTA36B = data(14, 1:3);
NHTA36C = data(16, 1:3);
HTA36C = data(17, 1:3);

B_data = [NHT1045B; HT1045B; NHTA36B; HTA36B];
C_data = [NHT1045C; HT1045C; NHTA36C; HTA36C];
B_data_scaled = Ba * B_data + Bb;
C_data_scaled = Ca * C_data + Cb;
B_means = mean(B_data_scaled, 2);
C_means = mean(C_data_scaled, 2);

C_vickers = [188.5 379.053 142.5 357.5316]; % [kgf/mm^2]
C_brinell = [176.5 359.3477 130.5 339.1392]; % [kgf/mm^2]
C_tensile = [661 1208.212 569 1121.772]; % [MPa]

B_vickers = [189.72 303.5586 156 296.3196]; % [kgf/mm^2]
B_brinell = [189.72 303.5586 156 296.3196]; % [kgf/mm^2]
B_tensile = [619.72 958.8965 530 940.799]; % [MPa]

% 1 kgf/mm^2 = 9.80665 MPa
C_yield = C_vickers * 9.80665 / 3; % [MPa]
B_yield = B_vickers * 9.80665 / 3; % [MPa]

%% FUNCTION: Linear Fit for Rockwell Scale Calibration
function [a, b, R2] = linearfit(x, y)
    % Linear regression in the form of y = ax + b
    x2 = x - mean(x);
    y2 = y - mean(y);
    a = mean(x2.*y2)/mean(x2.^2);
    b = mean(y) -  a*mean(x);
    R2 = (mean(x2.*y2))^2 / (mean(x2.^2) * mean(y2.^2));
end

