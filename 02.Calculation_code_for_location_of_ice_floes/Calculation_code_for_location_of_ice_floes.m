% Copyright 2020 Sung Boo Park
%
% you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This code is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this code.  If not, see <http://www.gnu.org/licenses/>.

% clear data
clear all;
close all;

% load data
fileInfo = dir;
extractedFileInfo = fileInfo(contains({fileInfo.name},'.mat'));
extractedFileName = erase({extractedFileInfo.name},'.mat');

len = length(extractedFileName);
cal = 0.0039432176656151;

% load data
for ii=1:len
    load([cell2mat(extractedFileName(ii)) '.mat']);
    dataTable(ii).name = extractedFileName(ii);
    dataTable(ii).time = str2double(extractBetween(dataTable(ii).name,'time', 's'));
    dataTable(ii).ICL = str2double(extractBetween(dataTable(ii).name,'ICL', '_IC'));
    dataTable(ii).IC = str2double(extractBetween(dataTable(ii).name,'_IC', '_'));
    dataTable(ii).period = str2double(extractBetween(dataTable(ii).name,'WP', '_'));
    dataTable(ii).xpix = pts(:,1);
    dataTable(ii).ypix = pts(:,2);
    dataTable(ii).x = (-dataTable(ii).xpix+1920)*cal;
    dataTable(ii).y = dataTable(ii).ypix*cal;
    dataTable(ii).mean_x = mean(dataTable(ii).x);
    dataTable(ii).mean_y = mean(dataTable(ii).y);
    dataTable(ii).std_x = std(dataTable(ii).x);
    dataTable(ii).std_y = std(dataTable(ii).y);
    dataTable(ii).iceQuantity = length(dataTable(ii).x);
end

%% Plot specific case image and selected point
% 
figure
for kk=8 % 1 and 4  / 5 and 8
    %     kk = 1;
    img = imread([cell2mat(extractedFileName(kk)) '.jpg']);
    imshow(img);
    hold on
    plot(dataTable(kk).xpix, dataTable(kk).ypix, 'o','MarkerSize',15,'MarkerFaceColor','g');
    %     plot(dataTable(kk).x, abs(dataTable(kk).y-4), 'o','MarkerSize',15,'MarkerFaceColor','g');
    line([dataTable(kk).mean_x dataTable(kk).mean_x], [0 1080], 'Color', 'r');
    line([0 1920], [dataTable(kk).mean_y dataTable(kk).mean_y],  'Color', 'r');
    title(kk)
    box on
    grid on
   
    hold off

end

%% Plot specific case image and selected point

for kk= 8 % 1 and 4  / 5 and 8
    figure(100+kk)
%     yyaxis right
    plot(dataTable(kk).x, abs(dataTable(kk).y-4), 'o','MarkerSize',15,'MarkerFaceColor','g');
    ax= gca;
    ax.YAxisLocation = 'right';
    box on
    grid on
    xlabel('Position-X (m)');
    ylabel('Position-Y (m)');
    set(gca, 'FontSize',18,'XDir','reverse');%'YDir','reverse'
    axis([0 7 0 4])
    line([dataTable(kk).mean_x dataTable(kk).mean_x], [0 1080], 'Color', 'b','Linewidth',4);
        
    hold off
end
