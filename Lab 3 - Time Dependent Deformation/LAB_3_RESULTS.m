% Stanley Wang
% UC Berkeley Spring 2021
% Professor Komvopoulos ME 108
% LAB 3 Results

clear all; close all; clc;

%% Uniaxial Tensile Tests
[e_stress1, e_strain1] = import_tensile('test1.csv');
[e_stress2, e_strain2] = import_tensile('test2.csv');
[e_stress3, e_strain3] = import_tensile('test3.csv');

figure(1);
plot(e_strain1, e_stress1, 'linewidth', 1.5);
hold on;
plot(e_strain2, e_stress2, 'linewidth', 1.5);
plot(e_strain3, e_stress3, 'linewidth', 1.5);
grid on; axis([0 350 0 32]);
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
legend('Strain Rate = 15 mm/min', 'Strain Rate = 50 mm/min', 'Strain Rate = 500 mm/min',...
    'location', 'southeast', 'fontsize', 16);
legend boxoff;
print -dpng -r600 'uniaxial_tension'

%% Stress Relaxation Tests
[time4, e_stress4] = import_stress_relaxation('test4.csv');
[time5, e_stress5] = import_stress_relaxation('test5.csv');
[time6, e_stress6] = import_stress_relaxation('test6.csv');

figure(2)
plot(time4, e_stress4, 'linewidth', 1.5);
hold on;
plot(time5, e_stress5, 'linewidth', 1.5);
plot(time6, e_stress6, 'linewidth', 1.5);
grid on; axis([0 610 0 22]);
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Time (sec)'); ylabel('Engin. Stress \sigma (MPa)');
legend('Strain Rate = 50 mm/min', 'Strain Rate = 250 mm/min', ...
    'Strain Rate = 50 mm/min, hold at 100% strain',...
    'location', 'southeast', 'fontsize', 16);
legend boxoff;
print -dpng -r600 'stress_relaxation'

%% Curve Fitting of Test 4, 5, 6

fit4 = @(x) 8.055 + 4.161*exp(-x/14.31) + 3.563*exp(-x/188.2);
fit5 = @(x) 7.233 + 4.16*exp(-x/11.32) + 3.51*exp(-x/176.3);
fit6 = @(x) 10.89 + 4.856*exp(-x/16.94) + 4.454*exp(-x/189.2);

figure(3)

subplot(1, 3, 1)
plot(time4, e_stress4, '-b', 'linewidth', 1.5);
hold on;
plot(time4, fit4(time4), '-r', 'linewidth', 1.5);

subplot(1, 3, 2)
plot(time5, e_stress5, '-b', 'linewidth', 1.5);
hold on;
plot(time5, fit5(time5), '-r', 'linewidth', 1.5);

subplot(1, 3, 3)
plot(time6, e_stress6, '-b', 'linewidth', 1.5);
hold on;
plot(time6, fit6(time6), '-r', 'linewidth', 1.5);

% grid on; axis([0 610 0 22]);
% set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
% xlabel('Time (sec)'); ylabel('Engin. Stress \sigma (MPa)');

%% Tests 1,2,3 Strain Rate Trends
E_f = [max(e_strain1), max(e_strain2), max(e_strain3)];
UTS = [max(e_stress1), max(e_stress2), max(e_stress3)];
strain_rates = [15, 50, 500]; % mm/min

figure(4)
plot(strain_rates, UTS, '-ob');

%% FUNCTIONS: Import Data from CSV and output relevant data
function [engin_stress, engin_strain] = import_tensile(filename)
    % Import relevant data entries from CSV file
    data = readtable(filename);

    rate  = data.Var2(1); % [mm/min]
    l0 = data.Var2(2); % [mm]
    t0 = data.Var2(3); % [mm]
    w0 = data.Var2(4); % [mm]
    A0 = data.Var2(5); % [mm^2]
    
    data = data([8:end], :); % crop NaN header information in data
    
    time = data.Var1; % [sec]
    extension = data.Var2; % [mm]
    load = data.Var3; % [N] 
    tensile_strain = data.Var4; % [%]
    
    engin_stress = load / A0; % [N/mm^2 = MPa]
    engin_strain = tensile_strain; % [%]
end

function [time, engin_stress] = import_stress_relaxation(filename)
    % Import relevant data entries from CSV file
    data = readtable(filename);

    rate  = data.Var2(1); % [mm/min]
    l0 = data.Var2(2); % [mm]
    t0 = data.Var2(3); % [mm]
    w0 = data.Var2(4); % [mm]
    A0 = data.Var2(5); % [mm^2]
    
    data = data([8:end], :); % crop NaN header information in data
    
    time = data.Var1; % [sec]
    time = time - time(1); % ensure all times start at 0 sec after cropping
    extension = data.Var2; % [mm]
    load = data.Var3; % [N]
    tensile_strain = data.Var4; % [%]
    
    engin_stress = load / A0; % [N/mm^2 = MPa]
    engin_strain = tensile_strain; % [%]
end
