function varargout = brain_landmarks(varargin)
% BRAIN_LANDMARKS MATLAB code for brain_landmarks.fig
%      BRAIN_LANDMARKS, by itself, creates a new BRAIN_LANDMARKS or raises the existing
%      singleton*.
%
%      H = BRAIN_LANDMARKS returns the handle to a new BRAIN_LANDMARKS or the handle to
%      the existing singleton*.
%
%      BRAIN_LANDMARKS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAIN_LANDMARKS.M with the given input arguments.
%
%      BRAIN_LANDMARKS('Property','Value',...) creates a new BRAIN_LANDMARKS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before brain_landmarks_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to brain_landmarks_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help brain_landmarks

% Last Modified by GUIDE v2.5 25-Feb-2018 01:59:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @brain_landmarks_OpeningFcn, ...
                   'gui_OutputFcn',  @brain_landmarks_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before brain_landmarks is made visible.
function brain_landmarks_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to brain_landmarks (see VARARGIN)

% Choose default command line output for brain_landmarks
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes brain_landmarks wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = brain_landmarks_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_file.
function open_file_Callback(hObject, eventdata, handles)
% hObject    handle to open_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global folder;
global S;
if (~(exist('E:\kevin\Data.mat', 'file') == 2))
    %A = matfile('E:\kevin\Data.mat','Writable',true);
    A = fopen('E:\kevin\Data.mat', 'a+');
    S = cell(410, 1);
  % save('E:\kevin\Data.mat', 'S');
end
%A = matfile('Data.mat','Writable',true);
A = load('E:\kevin\Data.mat');
folder = uigetdir();
img = struct(dir(fullfile(folder,'*.jpg')));  
files = dir(folder);
%set(handles.data,'string',{img.name});
% convert the image names from string to num and set them
nameNum = [];
for k = 1: length(img)
    nameNum = [nameNum [str2num(erase(img(k).name, '.jpg'))]];
end;
sortedNameNum = sort(nameNum);
set(handles.data, 'String', {sortedNameNum});
% -------
cellX = length(img);
if isempty(A.S);
    S = cell(cellX, 1);
else;
    S = A.S;
end

 
% --- Executes on selection change in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data
global folder;
global item_selected;
global read1;
hold on;
index_selected = get(hObject,'Value');
list = get(hObject,'String');
item_selected = strcat(list{index_selected}, '.jpg');
axes(handles.axes1);
read1 = imread(fullfile(folder, item_selected));
hold on;
hImage = imshow(read1);
set(hImage, 'HitTest', 'off', 'PickableParts', 'none');
if (exist('Data.mat', 'file') == 2);
    S1 = load('Data.mat', 'S');
    S1Copy = repmat(S1.S{index_selected}, 1, 1);
    S1Copy(1, :) = [];
    [nRows, nCols] = size(S1Copy);
    axes(handles.axes1)
    for (k = 1:nRows);
        plot(S1Copy{k, 1}, S1Copy{k, 2}, '-xc', 'MarkerSize', 40)
        text(S1Copy{k, 1} + 0.5, S1Copy{k, 2} + 0.5, num2str(k), 'FontSize', 20, 'Color', 'r')
    end;
    set(handles.table, 'Data', S1.S{index_selected}, 'ColumnName', {'X - Coords', 'Y - Coords'});
end;

% --- Executes during object creation, after setting all properties.
function data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in open_file2.
function open_file2_Callback(hObject, eventdata, handles)
% hObject    handle to open_file2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global folder2;
global S2;
if (~(exist('E:\kevin\Data2.mat', 'file') == 2))
    %A = matfile('E:\kevin\Data2.mat','Writable',true);
    %A = fopen('E:\kevin\Data2.mat', 'a+');
    S2 = cell(21, 1);
    save('E:\kevin\Data2.mat', 'S2');
end
%A = matfile('E:\kevin\Data2.mat','Writable',true);
A = load('E:\kevin\Data2.mat');
folder2 = uigetdir();
img = dir(fullfile(folder2,'*.jpg'));   
%files = dir(folder2);
%set(handles.data2,'string',{img.name});
% convert the image names from string to num and set them
nameNum = [];
for k = 1: length(img)
    nameNum = [nameNum [str2num(erase(img(k).name, '.jpg'))]];
end;
sortedNameNum = sort(nameNum);
set(handles.data2, 'String', {sortedNameNum});
% -------
cellX = length(img);
if isempty(A.S2)
    S2 = cell(cellX, 1);
else
    S2 = A.S2;
end


% --- Executes on selection change in data2.
function data2_Callback(hObject, eventdata, handles)
% hObject    handle to data2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data2
global folder2;
global item_selected2;
global read2;
index_selected = get(hObject,'Value');
list = get(hObject,'String');
item_selected2 = strcat(list{index_selected}, '.jpg');
read2 = imread(fullfile(folder2, item_selected2));
axes(handles.axes2);
cla();
hold on;
hImage = imshow(read2);
set(hImage, 'HitTest', 'off','PickableParts','none');


% --- Executes during object creation, after setting all properties.
function data2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global item_selected;
global S;
global num1
global landmarknumber;
if (landmarknumber > 0);
    name = erase(item_selected, '.jpg');
    num1 = str2num(name); %getting index to allocate in new array
    coords = cell(landmarknumber, 2);
    coords{1, 1} = name;
    coords{1, 2} = num1;
    for k = 1:landmarknumber;
        hold on
        [x, y] = ginput(1)
        plot(x, y, '-xc', 'MarkerSize', 40)
        text(x + 0.5, y + 0.5, num2str(k), 'FontSize', 20, 'Color', 'r'); 
        coords{k+1, 1} = x
        coords{k+1, 2} = y
    end;
    set(handles.table, 'Data', coords, 'ColumnName', {'X - Coords', 'Y - Coords'});
    S{num1} = coords;
    if (exist('Data.mat', 'file') == 2);
        save('Data.mat', 'S', '-append');
    else;
        fopen('Data.mat', 'a+');
        save('Data.mat', 'S');
    end;
end;


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global item_selected2;
global S2;
global num2;
global landmarknumber;
if (landmarknumber > 0) ;
    name = erase(item_selected2, '.jpg');
    num2 = str2num(name); %getting index to allocate in new array
    coords = cell(landmarknumber, 2);
    coords{1, 1} = name
    coords{1, 2} = num2;
    for k = 1:landmarknumber;
        hold on
        [x, y] = ginput(1)
        plot(x, y, '-xc', 'MarkerSize', 40)
        text(x + 0.5, y + 0.5, num2str(k), 'FontSize', 20, 'Color', 'r');
        coords{k+1, 1} = x
        coords{k+1, 2} = y
    end;
    set(handles.table2, 'Data', coords, 'ColumnName', {'X - Coords', 'Y - Coords'});
    S2{num2} = coords;
    if (exist('E:\kevin\Data2.mat', 'file') == 2)
        save('E:\kevin\Data2.mat', 'S2', '-append');
    else
        fopen('E:\kevin\Data2.mat', 'a+');
        save('E:\kevin\Data2.mat', 'S2');
    end
        
    
end;


% --- Executes on button press in magic.
function magic_Callback(hObject, eventdata, handles)
% hObject    handle to magic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num2;
global read1;
global read2;
global imageNew;
global item_selected;
I = read1;
J = read2;
name = erase(item_selected, '.jpg');
num1 = str2num(name);
S1 = load('Data.mat', 'S');
S1Copy = repmat(S1.S{num1}, 1, 1);
S1Copy(1, :) = [];
[nRow, nCol] = size(S1Copy);
M1 = cell2mat(S1Copy);
S2 = load('Data2.mat', 'S2');
S2Copy = repmat(S2.S2{num2}, 1, 1);
S2Copy(1, :) = [];
[nRow2, nCol2] = size(S2Copy);
M2 = cell2mat(S2Copy);
fixedPoints = M1; 
movingPoints = M2; 
tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');
imageNew = imwarp(J,tform,'OutputView',imref2d(size(I)));
axes(handles.axes3);
imshowpair(I, imageNew);
axes(handles.axes4);
imshow(imageNew);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imageNew;
global item_selected2;
global item_selected;
global newimagefolder;
templatename = item_selected;
rawimage = erase(item_selected2, '.jpg');
filename = strcat(rawimage, '_', templatename);
imwrite(imageNew, fullfile(newimagefolder, filename));
axes(handles.axes1);
cla();
axes(handles.axes2);
cla();


% --- Executes on selection change in landmarknumber.
function landmarknumber_Callback(hObject, eventdata, handles)
% hObject    handle to landmarknumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns landmarknumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from landmarknumber
global landmarknumber;
valArray = get(handles.landmarknumber, 'String');
index = get(handles.landmarknumber, 'Value');
if (valArray{index} ~= 'Landmark Number');
    landmarknumber = str2num(valArray{index});
end;
        


% --- Executes during object creation, after setting all properties.
function landmarknumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to landmarknumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newimagefolder.
function newimagefolder_Callback(hObject, eventdata, handles)
% hObject    handle to newimagefolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global newimagefolder;
newimagefolder = uigetdir();
