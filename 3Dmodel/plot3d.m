global folder;
global folder2;
folder = uigetdir();
img = struct(dir(fullfile(folder,'*.jpg')));  
A = []; % create the matrix
C = [];
nameNum = [];
for k = 1: length(img) % makes the names numerical 
    nameNum = [nameNum [str2num(erase(img(k).name, '.jpg'))]];
end;
sortedNameNum = sort(nameNum); % order the numbers
for k = 1: length(sortedNameNum) %iterate through the images
    %'select' a particular image in the file 
    image = sortedNameNum(k);
    imageString = strcat(num2str(image), '.jpg'); 
    % get the x,y coords of each red/orange pixel 
    B = red_pixel_coordinates(imageString);
    A = [A; B]; % vertically concat the two matrices 
end

folder2 = uigetdir();
img2 = struct(dir(fullfile(folder2,'*.jpg')));  
nameNum2 = [];
for k = 1: length(img2) % makes the names numerical 
    nameNum2 = [nameNum2 [str2num(erase(img(k).name, '.jpg'))]];
end;
for k = 1: length(sortedNameNum) %iterate through the images
    %'select' a particular image in the file 
    image = sortedNameNum(k);
    imageString = strcat(num2str(image), '.jpg'); 
    % get the x,y coords of each red/orange pixel  
    D = template_pixel_coordinates(imageString);
    C = [C; D];
end
drawPlot(A, C);

%get the red/orange pixel coordinates
function B = red_pixel_coordinates(image)
    global folder;
    sliceDepth = 0.5; % subject to change
    % get the z-value
    imageNum = erase(image, '.jpg');
    nameNum = str2num(imageNum) * sliceDepth; % the z-value
    % set standard values for red/orange
    rMin = 50;
    rMax = 255;
    gMin = 0;
    gMax = 200;
    bMin = 0;
    bMax = 50;
    rgbImage = imread(fullfile(folder, image));
    [height, width, ~] = size(rgbImage);
    B = zeros(height, 3);
    count = 1;
    for col = 1: width
        for row = 1: height
            % get rgb values for a particular pixel
            redVal = rgbImage(row, col, 1);
            greenVal = rgbImage(row, col, 2);
            blueVal = rgbImage(row, col, 3);
            if (redVal >= rMin) && (redVal <= rMax) ...
                    && (greenVal >= gMin) && (greenVal <= gMax) ...
                    && (blueVal >= bMin) && (blueVal <= bMax)
                B(count, :) = [row col nameNum];
                count = count + 1;
            end
        end
    end
end

function D = template_pixel_coordinates(image)
    global folder;
    sliceDepth = 0.5; % subject to change
    % get the z-value
    imageNum = erase(image, '.jpg');
    nameNum = str2num(imageNum) * sliceDepth; % the z-value
    % set standard values for red/orange
    aMin = 100;
    aMax = 110;
    bMin = 100;
    bMax = 110;
    gMin = 100;
    gMax = 110;
    rgbImage = imread(fullfile(folder, image));
    [height, width, ~] = size(rgbImage);
    D = zeros(height, 3);
    count = 1;
    for col = 1: width
        for row = 1: height
            % get rgb values for a particular pixel
            blueVal = rgbImage(row, col, 3);
            if (blueVal >= bMin) && (blueVal <= bMax)
                D(count, :) = [row col nameNum];
                count = count + 1;
            end
        end
    end
end

function drawPlot(matrix1, matrix2) 
    % remove all the zero rows
    TF1 = matrix1(:,1)==0; 
    matrix1(TF1, :) = [];
    TF2 = matrix2(:,1)==0;
    matrix2(TF2, :) = [];
    s = scatter3(matrix2(:, 2), matrix2(:, 3), matrix2(:, 1), 'Filled');
    alpha(s, 0.05);
    hold on;
    scatter3(matrix1(:, 2), matrix1(:, 3), matrix1(:, 1), 'Filled');
    rotate3d on
end