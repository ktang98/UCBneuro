global folder;
folder = uigetdir();
img = struct(dir(fullfile(folder,'*.jpg')));  

nameNum = [];
for k = 1: length(img) % makes the names numerical 
    nameNum = [nameNum [str2num(erase(img(k).name, '.jpg'))]];
end
sortedNameNum = sort(nameNum); % order the numbers

sideViewMatrix = []; % [rowNum newCol redMax]
for k = 1: length(sortedNameNum) % iterate through the images
    % 'select' a particular image in the file 
    image = sortedNameNum(k);
    imageString = strcat(num2str(image), '.jpg'); 
    % get the x,y coords of each red/orange pixel 
    B = sideView(imageString);
    
    % just to replicate each slice 10 times to fill in space
    for k = 1:10
        sideViewMatrix = horzcat(sideViewMatrix, B); % horizontal concat the two matrices
    end
end
plotSideView(sideViewMatrix);

function sideViewMatrixCol = sideView(imageString)
    global folder;
    rgbImage = imread(fullfile(folder, imageString));
    
    sliceDepth = 0.5; % subject to change
    % get the z-value
    imageNum = erase(imageString, '.jpg');
    nameNum = str2num(imageNum) * sliceDepth; % the z-value
    
    redMatrix = rgbImage(:, :, 1);
    redMax = max(redMatrix, [], 2);
    
    
    sideViewMatrixCol = redMax;
end

% plot matrix of [rowNum colNum redVal]
function plotSideView(matrix)
   imshow(matrix);
end

% Note: to change colour map, use caxis
% TO DO: superimpose these images over the templates to create a more
% 'whole' picture
%
% Also need to get the Template files again...