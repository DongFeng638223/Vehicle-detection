function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 15-Nov-2017 15:20:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_video.
function select_video_Callback(hObject, eventdata, handles)
% hObject    handle to select_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=...
    uigetfile('*.*','File Selector');%gui中打开文

file = fullfile(filepath,filename);
fidin=fopen('temp.txt','r+');% 需要读取的文件

i=0;
while ~feof(fidin)
    tline=fgetl(fidin);%读取一行
    i=i+1;
    %fprintf(fidout,'%s\n',tline);       
    newtline{i}=tline;    
    if i==1    
    %如果读到第六行，文件中的第六行中的 enc 替换为news_qcif
        newtline{i}=file;%替换的函数
    end
end
fclose(fidin);
%%重新以写的形式打开，写入覆盖原来的内容
fidin=fopen('temp.txt','w+');
for j=1:1:i
    fprintf(fidin,'%s\n',newtline{j});
end

fclose(fidin);


% --- Executes on slider movement.
function ling_min_Callback(hObject, eventdata, handles)
% hObject    handle to ling_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ht= uicontrol('Style', 'text','Position', [655 183 50 20]);
addlistener(hObject,'ContinuousValueChange',...
   @(obj,~)set(ht,'String',obj.Value));

fidin=fopen('temp.txt','r+');% 需要读取的文件
i=0;
while i<3
    tline=fgetl(fidin);%读取一行
    i=i+1;     
    newtline{i}=tline;    
    if i==2    
        newtline{i}=num2str(-hObject.Value*10);%替换的函数
    end
end
fclose(fidin);
%%重新以写的形式打开，写入覆盖原来的内容
fidin=fopen('temp.txt','w+');
for j=1:1:i
    fprintf(fidin,'%s\n',newtline{j});
end
fclose(fidin);

% --- Executes during object creation, after setting all properties.
function ling_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ling_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in begin.
function begin_Callback(hObject, eventdata, handles)
% hObject    handle to begin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
system('Pedestrian.exe');
