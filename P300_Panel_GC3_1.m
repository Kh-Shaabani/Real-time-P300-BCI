function varargout = P300_Panel_GC3_1(varargin)
% P300_Panel_GC3_1 MATLAB code for P300_Panel_GC3_1.fig
%      P300_Panel_GC3_1, by itself, creates a new P300_Panel_GC3_1 or raises the existing
%      singleton*.
%
%      H = P300_Panel_GC3_1 returns the handle to a new P300_Panel_GC3_1 or the handle to
%      the existing singleton*.
%
%      P300_Panel_GC3_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P300_Panel_GC3_1.M with the given input arguments.
%
%      P300_Panel_GC3_1('Property','Value',...) creates a new P300_Panel_GC3_1 or raises the
%      existing singleton*.  Starting from the Left, property value pairs are
%      applied to the GUI before P300_Panel_GC3_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P300_Panel_GC3_1_OpeningFcn via varargin.
%
%      *See GUI Options On GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P300_Panel_GC3_1

% Last Modified by GUIDE v2.5 23-Jul-2017 17:57:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P300_Panel_GC3_1_OpeningFcn, ...
                   'gui_OutputFcn',  @P300_Panel_GC3_1_OutputFcn, ...
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


% --- Executes just before P300_Panel_GC3_1 is made visible.
function P300_Panel_GC3_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P300_Panel_GC3_1 (see VARARGIN)

% Choose default command line output for P300_Panel_GC3_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P300_Panel_GC3_1 wait for user response (see UIRESUME)
% uiwait(handles.P300_Panel_GC3_1);
            

% --- Outputs from this function are returned to the command line.
function varargout = P300_Panel_GC3_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%****************************** Two Monitors ******************************
set(handles.P300_Panel_GC3_1,'Units','pixels');
pos = get(0,'MonitorPositions');       % (x,y,width,height)
sz = size(pos);
if (sz(1) > 1)
    panel_pos = pos(2,:);      % second monitor
    panel_pos(2) = 256;        % height
    panel_pos(3) = panel_pos(3)-pos(1,3);     % width
else
    panel_pos = pos(1,:);     % first monitor
end

set(handles.P300_Panel_GC3_1,'OuterPosition',panel_pos);
%**************************************************************************

%****************************Objects Position******************************
% !!!!! 'Units' of all objects must be 'pixels'. !!!!!
position = get(handles.P300_Panel_GC3_1,'Position');
% x = position(1);
% y = position(2);
width = position(3);
height = position(4);

set(handles.On,'Position',[(width-75)/2,(height-60)/2,100,50]);
set(handles.Left,'Position',[25,height-80,100,50]);
set(handles.Right,'Position',[width-100,height-80,100,50]);
set(handles.Up,'Position',[(width-75)/2,height-80,100,50]);
set(handles.Down,'Position',[(width-65)/2,20,100,50]);
set(handles.Close,'Position',[25,20,100,50]);
set(handles.Open,'Position',[width-100,20,100,50]);
% (width-75)=(x.Right=width-100)+(x.Left=25)+(width.Left=100)-(width.target=100)
% (height-60)=(y.Up=height-80)+(y.Down=20)+(height.Down=50)-(height.target=50)
% (width-213)=(x.Right=width-100)+(x.Left=25)+(width.Left=100)-(width.target=200)
% (height-110)=(y.Up=height-80)+(y.Down=20)+(height.Down=50)-(height.target=100)

set(handles.BOn,'Position',[(width-79)/2,(height-64)/2,104,54]);
set(handles.BLeft,'Position',[23,height-82,104,54]);
set(handles.BRight,'Position',[width-102,height-82,104,54]);
set(handles.BUp,'Position',[(width-79)/2,height-82,104,54]);
set(handles.BDown,'Position',[(width-67)/2,18,104,54]);
set(handles.BClose,'Position',[23,18,104,54]);
set(handles.BOpen,'Position',[width-102,18,104,54]);

%**************************************************************************

global T_on;        % on duration
global T_off;       % off duration

Fs = 256; LF = 0.1; HF = 100;
Fs_on = Fs*T_on/1000;  Fs_off = Fs*T_off/1000;
N_channels = 8;
Channels={'Fz','Cz','P3','Pz','P4','PO7','PO8','Oz'};
Reference = 'Left Earlobe';
Ground = 'FPz';
Commands = {'On','Left','Right','Up','Down','Close','Open','Idle'};
Paradigm = 'GC3_1';     % gray to a random different color for each button_recording 1.
N_buttons = 7;
% Targets = randperm(length(Commands));
Stimuli = [];       % flashing sequence matrix of all trials
pink = [1,0.4,0.6];        % pink
% orange_l = [1,0.687,0.387];     % light orange
% orange_d = [1,0.4,0];           % dark orange
Colors = {'y','m','c','r','g','b',pink};


pause(5);
set_param('EEG_Record','SimulationCommand','Stop');     % stop simulink
mode = 0;      % asynchronous mode
i_block = 0;

%% Set Arm
eml.extrinsic('serial');
eml.extrinsic('set');
eml.extrinsic('fopen');
eml.extrinsic('fprintf');
eml.extrinsic('fclose');
eml.extrinsic('num2str');

% define initial position
obj = serial('COM6');
set(obj, 'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1,'Timeout',1/50,'Terminator','CR');
fopen(obj);
m0 = 1700;    m1 = 2000;    m2 = 1500;    m3 = 2400;    m4 = 500;
fprintf(obj,['#0 P' num2str(m0) 'T1000'])%----T1000 = robot speed---#0 = arm part-----P1250 = position of the part 
fprintf(obj,['#1 P' num2str(m1) 'T1000'])
fprintf(obj,['#2 P' num2str(m2) 'T1000'])
fprintf(obj,['#3 P' num2str(m3) 'T1000'])
fprintf(obj,['#4 P' num2str(m4) 'T1000'])
fclose(obj)
%

%% START, 1 2 3, Go
while 1
    i_block=i_block+1;
    obj = serial('COM6');
    set(obj, 'BaudRate',11000,'DataBits',8,'Parity','none','StopBits',1,'Timeout',1/50,'Terminator','CR');
    fopen(obj);
    set_param('EEG_Record','SimulationCommand','Start');       % start simulink
    if mode==0     % asynchronous
        N_avr=3;
    else            % if mode==1;      % synchronous
        N_avr=1;
    end
    pause(1);
    i_trial = 0;        % trial=round
    tic
    for i_avr=1:N_avr
        i_trial=i_trial+1;
        Stimuli(:,i_trial)=randperm(N_buttons)';  % size(Stimului)=[N_buttons,N_trials]=[7,N_trials]
        color=randperm(size(Colors,2));
        if i_trial>1
            while Stimuli(1,i_trial)==Stimuli(end,i_trial-1)
                Stimuli(:,i_trial)=randperm(N_buttons)';
            end
        end
        for k=1:size(Stimuli,1)
            hnd1=findobj('tag', Commands{Stimuli(k,i_trial)});
            set(hnd1,'foregroundcolor',Colors{color(k)});       % because size(StimulusCode,1)=size(color,2)
            set(hnd1,'backgroundcolor','k');
            set(hnd1,'FontAngle','italic');
            set(hnd1,'FontWeight','bold');
            set(hnd1,'FontSize',26);
            set_param('EEG_Record/Subsystem1/Gain1','Gain','1');       % StartStop=1
            pause(T_on/1000);
            set(hnd1,'foregroundcolor',[0.5 0.5 0.5]);
            set(hnd1,'backgroundcolor','k');
            set(hnd1,'FontAngle','normal');
            set(hnd1,'FontWeight','normal');
            set(hnd1,'FontSize',20);
            set_param('EEG_Record/Subsystem1/Gain1','Gain','0');       % StartStop=0
            pause(T_off/1000);
        end
    end
    pause(0.6);
    set_param('EEG_Record','SimulationCommand','Stop');     % stop simulink
    
    
    %% Loading & Building Data
    flashing = [];        signal = [];      Flashing = [];      Signal = [];
    F=evalin('base','StartStop');
    a=find(F,1);
    flashing=F(a-1:end);       % size(flashing)=[N_time samples,1]
    
    canal1=evalin('base','canal1');
    canal2=evalin('base','canal2');
    canal3=evalin('base','canal3');
    canal4=evalin('base','canal4');
    canal5=evalin('base','canal5');
    canal6=evalin('base','canal6');
    canal7=evalin('base','canal7');
    canal8=evalin('base','canal8');
    canal9=evalin('base','canal9');
    canal10=evalin('base','canal10');
    canal11eyeblink=evalin('base','canal11eyeblink');
    Canals={canal1,canal2,canal3,canal4,canal5,canal6,canal7,canal8,canal9,canal10,canal11eyeblink};
    for c=1:N_channels
        signal(:,c)=Canals{c}(a-1:end);        % size(signal)=[N_time samples,8]
    end
    Flashing=flashing;      % size(Flashing)=[N_time samples,1]
    Signal=signal;          % size(Signal)=[N_time samples,N_channels]   
    
    A=[];
    A=Stimuli(:);       % size(A)=[N_avr*N_buttons,1]

    StimulusCode = Flashing;
    m = 0;
    for n=1:length(Flashing)-1
        if Flashing(n)==0 && Flashing(n+1)==1
            m = m+1;
            StimulusCode(n+1:n+32)=repmat(A(m),1,32);    % size(StimulusCode)=[1,N_time samples]
        end
    end
    
    
    %% Classification
    if mode==1      % synchronous
        Session3_Synchronous1;
        y;
        hnd2=findobj('tag', ['B',Commands{y}]);
        set(hnd2,'backgroundcolor','g');
        switch y
            case 1
                mode=0;     % asynchronous
                y=8;        % Idle
                set(handles.On,'String','On');
            case 2
                m0=m0+300;
                fprintf(obj,['#0 P' num2str(m0) 'T3000'])
                pause(3);
            case 3
                m0=m0-300;
                fprintf(obj,['#0 P' num2str(m0) 'T3000'])
                pause(3);
            case 4
                m3=m3+200;
                fprintf(obj,['#3 P' num2str(m3) 'T2000'])
                pause(2);
            case 5
                m3=m3-200;
                fprintf(obj,['#3 P' num2str(m3) 'T2000'])
                pause(2);
            case 6
                m4=m4+1000;
                fprintf(obj,['#4 P' num2str(m4) 'T2000'])
                pause(2);
            case 7
                m4=m4-2000;
                fprintf(obj,['#4 P' num2str(m4) 'T2000'])
                pause(2);
        end
        set(hnd2,'backgroundcolor','k');
    else            % asynchronous
        Session3_Asynchronous4;
        y;
        if y==1         % control state
            mode=1;     % synchronous
            set(handles.BOn,'backgroundcolor','g');
            set(handles.On,'String','Off');
            pause(1);
            set(handles.BOn,'backgroundcolor','k');
        else        % idle state
            y=8;
        end
    end
    fclose(obj)
    
    %% Informations
    tt=toc;
    Time(i_block)=tt;
    Output(i_block)=y;
    disp(['Mode: ',mode])
    if y==0
        disp('No Output')
    else
        disp(['Output: ',Commands(y)])
    end
    disp(['Time: ',tt])
    disp(['next ',i_block])
end







