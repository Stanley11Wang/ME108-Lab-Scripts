% Stanley Wang
% UC Berkeley Spring 2021
% Professor Komvopoulos ME 108
% LAB 4 Results

clear all; close all; clc;

%% Uniaxial Tensile Tests
[e_stress1, e_strain1] = import_tensile('test1.csv', 57.2, 79.74720);
[e_stress2, e_strain2] = import_tensile('test2.csv', 57.2, 79.62500);
[e_stress3, e_strain3] = import_tensile('test3.csv', 57.2, 79.62500);
[e_stress4, e_strain4] = import_tensile('test4.csv', 57.2, 78.54410);
[e_stress5, e_strain5] = import_tensile('test5.csv', 57.2, 78.67140);
[e_stress6, e_strain6] = import_tensile('test6.csv', 57.2, 77.64375); 

figure(1);

subplot(3, 2, 1)
plot(e_strain1, e_stress1, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 1: 3% - 3.25% strain control');

subplot(3, 2, 2)
plot(e_strain2, e_stress2, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 2: 6.75% - 6.85% strain control');

subplot(3, 2, 3)
plot(e_strain3, e_stress3, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 3: 6.75% - 7% strain control');

subplot(3, 2, 4)
plot(e_strain4, e_stress4, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 4: 6.75% - 7.15% strain control');

subplot(3, 2, 5)
plot(e_strain5, e_stress5, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 5: 40kN - 45kN load control');

subplot(3, 2, 6)
plot(e_strain6, e_stress6, '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('Test 6: 20kN - 45kN load control');

set(gcf, 'position', [236 51 1205 754]);
print -dpng -r600 'STRESS_STRAIN'

figure(2);
plot(e_strain1(end-300:end), e_stress1(end-300:end), '-r', 'linewidth', 1);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
title('3% - 3.25% strain control');
axis([2.9843 3.2610 30.2190  527.8467]);
print -dpng -r600 'test1_loop'

figure(3)
plot(e_strain2(end-110:end), e_stress2(end-110:end), 'linewidth', 1.2);
hold on;
plot(e_strain3(end-250:end), e_stress3(end-250:end), 'linewidth', 1.2);
plot(e_strain4(end-380:end), e_stress4(end-380:end), 'linewidth', 1.2);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
legend('6.75% - 6.85% strain control', '6.75% - 7% strain control', '6.75% - 7.15% strain control', ...
    'fontsize', 16, 'location', 'southeast');
legend boxoff;
axis([6.7 7.2 0 610]);
print -dpng -r600 'test345'

%% FUNCTION: Import Data from CSV and output relevant data
function [engin_stress, engin_strain] = import_tensile(filename, l0, A0)
    % Initial length (l0) and area (A0) manually entered in [mm] and [mm^2]
    % Import relevant data entries from CSV file
    data = readtable(filename);
    
    time = data.Time; % [sec]
    extension = data.Extension; % [mm]
    load = data.Load; % [N] 
    tensile_strain = data.TensileStrain_Strain1_; % [%]
    total_cycles = data.TotalCycleCount;
    
    engin_stress = load / A0; % [N/mm^2 = MPa]
    engin_strain = tensile_strain; % [%]
end