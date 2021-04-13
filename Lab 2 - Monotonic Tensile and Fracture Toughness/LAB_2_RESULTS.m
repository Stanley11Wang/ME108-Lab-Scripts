% Stanley Wang
% UC Berkeley Spring 2021
% Professor Komvopoulos ME 108
% LAB 2 Results

clear all; close all; clc;

%% Aluminum 6061 3 mm/min Tensile Tests

[e_stress1, e_strain1, t_stress1, t_strain1] = importspecimen('test1.csv', 57.2, 87.27750); % no extensometer
[e_stress2, e_strain2, t_stress2, t_strain2] = importspecimen('test2.csv', 57.2, 86.89450); % with extensometer
figure(1);
plot(e_strain1, e_stress1, 'linewidth', 1.5);
hold on;
plot(t_strain1, t_stress1, 'linewidth', 1.5);
plot(e_strain2, e_stress2, 'linewidth', 1.5);
plot(t_strain2, t_stress2, 'linewidth', 1.5);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
legend('\sigma_{eng}-\xi_{eng} (NO extensometer)', '\sigma_{tr}-\xi_{tr} (NO extensometer)', ...
    '\sigma_{eng}-\xi_{eng} (extensometer)', '\sigma_{tr}-\xi_{tr} (extensometer)', 'fontsize', 16, 'location', 'southeast');
legend boxoff;
title('Al 6061, 3 mm/min');

print -dpng -r600 'Al6061_3mm'

%% Aluminum 6061 6 mm/min Tensile Tests
[e_stress3, e_strain3, t_stress3, t_strain3] = importspecimen('test3.csv', 57.2, 86.23880); % no extensometer
[e_stress4, e_strain4, t_stress4, t_strain4] = importspecimen('test4.csv', 57.2, 86.82740); % with extensometer
figure(2);
plot(e_strain3, e_stress3, 'linewidth', 1.5);
hold on;
plot(t_strain3, t_stress3, 'linewidth', 1.5);
plot(e_strain4, e_stress4, 'linewidth', 1.5);
plot(t_strain4, t_stress4, 'linewidth', 1.5);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
legend('\sigma_{eng}-\xi_{eng} (NO extensometer)', '\sigma_{tr}-\xi_{tr} (NO extensometer)', ...
    '\sigma_{eng}-\xi_{eng} (extensometer)', '\sigma_{tr}-\xi_{tr} (extensometer)', 'fontsize', 16, 'location', 'southeast');
legend boxoff;
title('Al 6061, 6 mm/min');

print -dpng -r600 'Al6061_6mm'

%% AISI 1045 6 mm/min Tensile Tests
[e_stress5, e_strain5, t_stress5, t_strain5] = importspecimen('test5.csv', 57.2, 80.88300); % no extensometer
[e_stress6, e_strain6, t_stress6, t_strain6] = importspecimen('test6.csv', 57.2, 82.88180); % with extensometer
figure(3);
plot(e_strain5, e_stress5, 'linewidth', 1.5);
hold on;
plot(t_strain5, t_stress5, 'linewidth', 1.5);
plot(e_strain6, e_stress6, 'linewidth', 1.5);
plot(t_strain6, t_stress6, 'linewidth', 1.5);
grid on;
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
legend('\sigma_{eng}-\xi_{eng} (NO extensometer)', '\sigma_{tr}-\xi_{tr} (NO extensometer)', ...
    '\sigma_{eng}-\xi_{eng} (extensometer)', '\sigma_{tr}-\xi_{tr} (extensometer)', 'fontsize', 16, 'location', 'southeast');
legend boxoff;
title('AISI 1045, 6 mm/min');

print -dpng -r600 'AISI1045_6mm'

%% Finding Mechanical Properties

figure(4)
E2 = 275/0.003704;
plot(e_strain2, e_stress2, '-r', 'linewidth', 1.5);
hold on; 
plot(e_strain2, e_strain2*E2, '--b', 'linewidth', 1.5);
plot(e_strain2, (e_strain2-0.002)*E2, '--b', 'linewidth', 1.5);
grid on; axis([0 6.5e-3 0 400])
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
title('Al 6061, 3 mm/min Extensometer');
print -dpng -r600 'Al6061_3mm_extenso'

figure(5)
E4 = 270.3/0.003966;
plot(e_strain4, e_stress4, '-r', 'linewidth', 1.5);
hold on; 
plot(e_strain4, e_strain4*E4, '--b', 'linewidth', 1.5);
plot(e_strain4, (e_strain4-0.002)*E4, '--b', 'linewidth', 1.5);
grid on; axis([0 6.5e-3 0 400])
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
title('Al 6061, 6 mm/min Extensometer');
print -dpng -r600 'Al6061_6mm_extenso'

figure(6)
E6 = 387.7/0.00188;
plot(e_strain6, e_stress6, '-r', 'linewidth', 1.5);
hold on; 
plot(e_strain6, e_strain6*E6, '--b', 'linewidth', 1.5);
plot(e_strain6, (e_strain6-0.002)*E6, '--b', 'linewidth', 1.5);
grid on; axis([0 4.5e-3 0 500])
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman');
xlabel('Strain (mm/mm)'); ylabel('Stress (MPa)'); 
title('AISI 1045, 6 mm/min Extensometer');
print -dpng -r600 'AISI1045_6mm_extenso'

n1 = e_strain1((e_stress1 == max(e_stress1)));
n3 = e_strain3((e_stress3 == max(e_stress3)));
n5 = e_strain5((e_stress5 == max(e_stress5)));
RAf1 = 1 - exp(-max(t_strain1));
RAf3 = 1 - exp(-max(t_strain3));
RAf5 = 1 - exp(-max(t_strain5));
RAn1 = 1 - exp(-log(1+n1));
RAn3 = 1 - exp(-log(1+n3));
RAn5 = 1 - exp(-log(1+n5));
data = [E2 300 max(e_stress1) e_strain1(end) e_stress1(end) n1 t_strain1(end)*t_stress1(end)/(n1+1) RAn1 RAf1
    E4 300 max(e_stress3) e_strain3(end) e_stress3(end) n3 t_strain3(end)*t_stress3(end)/(n3+1) RAn3 RAf3
    E6 410 max(e_stress5) e_strain5(end) e_stress5(end) n5 t_strain5(end)*t_stress5(end)/(n5+1) RAn5 RAf5];

%% FUNCTION: Import Data from CSV and output stress-strain data
function [engin_stress, engin_strain, true_stress, true_strain] = importspecimen(filename, l0, A0)
    % Import relevant data entries from CSV file
    % Input starting gauge length in mm and starting area in mm^2
    data = readtable(filename);
    load = data.Load; % [N]
    try
        strain = data.Strain1; % [%]
        engin_strain = strain/100; 
    catch
        extension = data.Extension; % [mm]
        engin_strain = extension/l0;
    end
    % Calculate stress-strain parameters
    engin_stress = load / A0; % [MPa]
    true_stress = engin_stress .* (1 + engin_strain); % [MPa]
    true_strain = log(1 + engin_strain);
end
