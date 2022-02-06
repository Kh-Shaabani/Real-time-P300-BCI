function varargout = P300_Panel_Setting(varargin)
% P300_PANEL_SETTING MATLAB code for P300_Panel_Setting.fig
%      P300_PANEL_SETTING, by itself, creates a new P300_PANEL_SETTING or raises the existing
%%      singleton*.

%      H = P300_PANEL_SETTING returns the handle to a new P300_PANEL_SETTING or the handle to
%      the existing singleton*.
%
%      P300_PANEL_SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P300_PANEL_SETTING.M with the given input arguments.
%
%      P300_PANEL_SETTING('Property','Value',...) creates a new P300_PANEL_SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P300_Panel_Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P300_Panel_Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P300_Panel_Setting

% Last Modified by GUIDE v2.5 18-Aug-2016 22:31:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P300_Panel_Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @P300_Panel_Setting_OutputFcn, ...
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


% --- Executes just before P300_Panel_Setting is made visible.
function P300_Panel_Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P300_Panel_Setting (see VARARGIN)

% Choose default command line output for P300_Panel_Setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P300_Panel_Setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P300_Panel_Setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.start,'Enable','off');
set(handles.stop,'Enable','on');

global T_on;        % on duration
global T_off;       % off duration

T_on = str2double(get(handles.edit1,'string'));
T_off = str2double(get(handles.edit2,'string'));

P300_Panel_GC3_1;

set(handles.start,'Enable','on');
set(handles.stop,'Enable','on');


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.stop,'Enable','off');
set(handles.start,'Enable','on');

% Save Informations
Subject=input('enter subject number: ','s');
save(Subject,'Time','Output');
DT=round(clock);        % date & time of recording
Date_Time=[num2str(DT(1)),'_',num2str(DT(2)),'_',num2str(DT(3)),'_'...
    ,num2str(DT(4)),'_',num2str(DT(5)),'_',num2str(DT(6))];
FileName=[Subject,'.txt'];
myf1=fopen(FileName,'w');
Name=input('enter subject name: ','s');
Session_n=input('enter session number: ');
Run_n=input('enter run number: ');
if Session_n==1 || Session_n==2
    S='Offline';
elseif Session_n==3
    S='Online';
end
fprintf(myf1,'%s\r\n','Recording Information');
fprintf(myf1,'%s\r\n',['Date & Time: ',Date_Time]);
fprintf(myf1,'%s\r\n',['Subject: ',Name]);
fprintf(myf1,'%s\r\n',Subject);
fprintf(myf1,'%s\r\n','-------------------------------');
fprintf(myf1,['\r\n','Session ',num2str(Session_n),': ',S,'\n']);
fprintf(myf1,['\r\n','Paradigm: ',Paradigm,'\n']);
fprintf(myf1,['\r\n','Run ',num2str(Run_n),'\n']);
fprintf(myf1,['\r\n','Commands: ',Commands{:},'\n']);
% fprintf(myf1,['\r\n','Number of blocks per run: ',num2str(N_blocks),'\n']);
% fprintf(myf1,['\r\n','Number of trials per block: ',num2str(N_trials),'\n']); 
fprintf(myf1,['\r\n','Number of flashing keys: ',num2str(N_buttons),'\n']);
fprintf(myf1,['\r\n','On duration (ms): ',num2str(T_on),'\n']); 
fprintf(myf1,['\r\n','Off duration (ms): ',num2str(T_off),'\n']);
fprintf(myf1,['\r\n','Band-pass filter of gtec. (Hz): ',num2str(LF),'-',num2str(HF),'\n']);
fprintf(myf1,['\r\n','Sampling frequency (Hz): ',num2str(Fs),'\n']);
fprintf(myf1,['\r\n','Number of channels: ',num2str(N_channels),'\n']);
fprintf(myf1,['\r\n','Channels: ',Channels{:},'\n']);
fprintf(myf1,['\r\n','Reference: ',Reference,'\n']);
fprintf(myf1,['\r\n','Ground: ',Ground,'\n']);
fclose(myf1);
%

fclose(obj);
set_param('EEG_Record','SimulationCommand','Stop');       % stop simulink
close all;
