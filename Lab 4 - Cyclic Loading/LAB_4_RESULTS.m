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
plot(e_strain1, e_stress1, 'linewidth', 1.5);
hold on;
plot(e_strain2, e_stress2, 'linewidth', 1.5);
plot(e_strain3, e_stress3, 'linewidth', 1.5);
plot(e_strain4, e_stress4, 'linewidth', 1.5);
plot(e_strain5, e_stress5, 'linewidth', 1.5);
plot(e_strain6, e_stress6, 'linewidth', 1.5);
grid on; 
%axis([0 350 0 32]);
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Engin. Strain \epsilon (%)'); ylabel('Engin. Stress \sigma (MPa)');
legend('3% - 3.25% strain control', '6.75% - 6.85% strain control',...
    '6.75% - 7% strain control', '6.75% - 7.15% strain control', ...
    '40kN - 45kN load control', '20kN - 45kN load control', ...
    'location', 'southeast', 'fontsize', 16);
legend boxoff;
print -dpng -r600 'ROUGH_PLOT'



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