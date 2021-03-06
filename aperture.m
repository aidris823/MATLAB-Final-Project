% Anand Idris, Anis Idrizovic, and Cruz B. Garcia
% Optics 211
% Saturday, April 18, 2020
% Final Project, Part 1
% Aperture Simulator

% This script plots the far-field (Fraunhofer) diffraction pattern arising
% from a given aperture. To run it, aperture(argument) should be inserted into the
% command window where argument can be 'square', 'single slit', 'double
% slit' or 'circle' depending on which shape of the slit is desired. The
% output should include four plots: a plot representing the aperture, two
% plots of the far-field diffraction with different scales and a figure
% with plots of side cross sections of the diffraction patterns.

function aperture(shape)

% Define Aperture field
apL = 5000; % Size of the aperture field
ap = zeros(apL); % Define actual aperture plane


if strcmp(shape, 'square') == 1
%Define Square Dimensions
    sqL = 500; % Define square length
    for i = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
        for j = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
            ap(i,j) = 1;
        end
    end
elseif strcmp(shape, 'single slit') == 1
    % Define Single Slit Dimensions
    slW = 200;
    slH = 2500;
    for i = round(1 + apL./2 - slH./2):round(1 + apL./2 + slH./2)
        for j = round(1 + apL./2 - slW./2):round(1 + apL./2 + slW./2)
            ap(i,j) = 1;
        end
    end
elseif strcmp(shape, 'double slit') == 1
    % Define Double Slit Dimensions
    slW2 = 175;
    slSp = 500;
    for i = round(1 + apL./2 - slH./2):round(1 + apL./2 + slH./2)
        for j = round(1 + apL./2 - (slW2+(slSp./2))):round(1 + apL./2 + slSp./2 + slW2)
            if(j > round(1 + apL./2 - (slSp./2)) && j < round(1 + apL./2 + slSp./2))
                continue
            end
            ap(i,j) = 1;
        end
    end
elseif strcmp(shape, 'circle') == 1
    %Defining Circle Dimensions
    r = 275;
    [x,y] = meshgrid((1:apL)-round(apL./2),(1:apL)-round(apL./2)); % Creates an x and y meshgrid that identifies the distance from the center of the circle aperture
    ap(sqrt(x.^2 + y.^2) <= r) = 1; % Finds the points within the radius of the aperture
elseif strcmp(shape, 'half-square') == 1
    % Define Half-Square Dimensions
    sqL = 1500; % Define square length
    x1 = round(((apL./2)+1)-(sqL./2));
    y1 = round(((apL./2)+1)-(sqL./2));
    x2 = round(((apL./2)+1)+(sqL./2));
    y2 = round(((apL./2)+1)+(sqL./2));
    m = (y2-y1)./(x2-x1);
    for i = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
        for j = round(1 + apL./2 - sqL./2):round(1 + apL./2 + sqL./2)
            if(j <= m*i)
                ap(i,j) = 1;
            end
        end
    end
end

% Aperture Field Figure Details 
figure (1)
imagesc(ap) % Plot image of the aperture field
title("Aperture")
xlabel("x [Pixels]")
ylabel("y [Pixels]")
colormap gray % Set the color of the aperture field plot
axis equal % Set the display scale of the axes
axis([0 apL 0 apL]) % Set axes limits to size of aperture field

% Do a Fourier transform of the aperture
ap_trans = fftshift(fft2(ap)); % Apply the transform to the aperture
real_trans = real(ap_trans); % Take the real part
Io = real_trans.^2; % Square the real part to obtain irradiance
I = Io.^0.3; % Re-scale the real part of the irradiance

%Diffraction Pattern Figure Details
figure(2) % Create a new figure
imagesc(I) % Plot the irradiance pattern
title('Fraunhofer Diffraction Pattern') % Set the title
xlabel('x [Pixels]') % Label x-axis
ylabel('y [Pixels]') % Label y-axis
colormap gray % Set the color of the field plot

%Central Diffraction Pattern Figure
figure(3)
I2 = I(round(1+apL/2-125):round(1+apL/2+125),round(1+apL/2-125):round(1+apL/2+125));
imagesc(I2) % Plot the irradiance pattern
title('Fraunhofer Diffraction Pattern') % Set the title
xlabel('x [Pixels]') % Label x-axis
ylabel('y [Pixels]') % Label y-axis
colormap gray % Set the color of the field plot

frI = Io(apL./2,:);
sdI = Io(:,apL./2);
x4 = linspace(1,apL,apL);

%Cross Section Figure Details
figure (4)
sgtitle('Cross Sections')

%Front Cross Section Subplot
subplot(2,1,1)
    plot(x4,frI)
    title('"Front"') % Set the title
    xlabel('x [Pixels]') % Label x-axis
    ylabel('y [Pixels]') % Label y-axis
    xlim([2300 2700])

%Side Cross Section Subplot
subplot(2,1,2)
    plot(x4,sdI)
    title('"Perpendicular Side"') % Set the title
    xlabel('x [Pixels]') % Label x-axis
    ylabel('y [Pixels]') % Label y-axis
    xlim([2300 2700])