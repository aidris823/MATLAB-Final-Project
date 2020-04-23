% Anand Idris, Anis Idrizovic, and Cruz B. Garcia
% Optics 211
% Saturday, April 18, 2020
% Final Project, Part 1
% Aperture Simulator

% Define Aperture field
apL = 5000; % Size of the aperture field
ap = zeros(apL); % Define actual aperture plane

% Define Square Dimensions
% sqL = 500; % Define square length
% for i = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
%     for j = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
%         ap(i,j) = 1;
%     end
% end

%Define Single Slit Dimensions
% slW = 200;
% slH = 2500;
% for i = round(1 + apL./2 - slH./2):round(1 + apL./2 + slH./2)
%     for j = round(1 + apL./2 - slW./2):round(1 + apL./2 + slW./2)
%         ap(i,j) = 1;
%     end
% end

%Define Double Slit Dimensions
% slW2 = 175;
% slSp = 500;
% for i = round(1 + apL./2 - slH./2):round(1 + apL./2 + slH./2)
%     for j = round(1 + apL./2 - (slW2+(slSp./2))):round(1 + apL./2 + slSp./2 + slW2)
%         if(j > round(1 + apL./2 - (slSp./2)) && j < round(1 + apL./2 + slSp./2))
%             continue
%         end
%         ap(i,j) = 1;
%     end
% end

% %Defining Circle Dimensions
% r = 275;
% [x,y] = meshgrid((1:apL)-round(apL./2),(1:apL)-round(apL./2)); % Creates an x and y meshgrid that identifies the distance from the center of the circle aperture
% ap(sqrt(x.^2 + y.^2) <= r) = 1; % Finds the points within the radius of the aperture

% Define Half-Square Dimensions
% sqL = 1500; % Define square length
% x1 = round(((apL./2)+1)-(sqL./2));
% y1 = round(((apL./2)+1)-(sqL./2));
% x2 = round(((apL./2)+1)+(sqL./2));
% y2 = round(((apL./2)+1)+(sqL./2));
% m = (y2-y1)./(x2-x1);
% for i = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
%     for j = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
%         if(j <= m*i)
%             ap(i,j) = 1;
%         end
%     end
% end

% Plot the aperture field
figure
imagesc(ap) % Plot image of the aperture field
title("Aperture")
xlabel("x [Pixels]")
ylabel("y [Pixels]")
colormap gray % Set the color of the aperture field plot
axis equal % Set the display scale of the axes
axis([0 apL 0 apL]) % Set axes limits to size of aperture field

% Do a Fourier transform of the aperture
ap_trans = fft(ap); % Apply the transform to the aperture
real_trans = real(ap_trans); % Take the real part
Io = real_trans.^2; % Square the real part to obtain irradiance
I = Io.^0.2; % Re-scale the real part

figure(2); clf % Create a new figure
imagesc(I) % Plot the irradiance pattern
title('Fraunhofer Diffraction Pattern') % Set the title
xlabel('x [Pixels]') % Label x-axis
ylabel('y [Pixels]') % Label y-axis
colormap gray % Set the color of the field plot

