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

close all; clear variables;

    IZ = 40 ; % Ice Zone (25 40 70)
    T_Ice = 60 ; % Target Ice Concentration
    WP = 07 ; % Wave Period(07 08 09 10)
    
    img_M = imread(['IZ',num2str(IZ,'%.2d'),'-IC',num2str(T_Ice,'%.2d'),'-T',num2str(WP,'%.2d'),'-TR01_Masked','.png']);
 

    img_gray_M = rgb2gray(img_M);               % Color image --> grayscale image

    img_binarized_M = imbinarize(img_gray_M); % grayscale image --> mono image (1 or 0)

    C_Ice_M = (sum(sum(img_binarized_M))/(size(img_binarized_M,1)*size(img_binarized_M,2)))*100; % ice concentration(%)
  %%
    figure(1);
    
    imshow(img_binarized_M)
    text(10, 50, ['TargetIce concentration : ',num2str(T_Ice,'%.2d'),'%'], 'FontSize', 16, 'FontWeight', 'bold','Color', 'gr')
    text(10, 100, ['Cal.Ice concentration : ',num2str(C_Ice_M,'%.1f'),'%'], 'FontSize', 16, 'FontWeight', 'bold','Color', 'gr')
    title(['Ice zone : ', num2str(IZ/10, '%.1f'),'m /', ' Wave period : ', num2str(WP, '%.1f'), 's'],'FontSize', 18, 'FontWeight', 'bold','Color', 'bl')
     