%% ******************** Online Classification for Target & Nontarget ********************

i_sbj=1;
% [pathstr,name,ext]=fileparts(which(mfilename));
% d1=[pathstr,'\Parameters',Subject,];
load('A_Syn');
N_buttons = 7;
Fs = 256;
ds = 8;     % downsample to 32 Hz
window = 179;       % 700 ms
% CHANNELS = {'FC5','FC3','FC1','FCz','FC2','FC4','FC6','C5','C3','C1','Cz','C2','C4','C6','CP5',...
%     'CP3','CP1','CPz','CP2','CP4','CP6','Fp1','Fpz','Fp2','AF7','AF3','AFz','AF4','AF8','F7',...
%     'F5','F3','F1','Fz','F2','F4','F6','F8','FT7','FT8','T7','T8','T9','T10','TP7','TP8','P7',...
%     'P5','P3','P1','Pz','P2','P4','P6','P8','PO7','PO3','POz','PO4','PO8','O1','Oz','O2','Iz'};
% Ch = [34 11 49 51 53 56 60 62];
% channels = CHANNELS(Ch);
% N_Ch = length(Ch);
[b,a]=butter(3,[0.1 30]/Fs/2,'bandpass');       % butterworth bandpass filter
responses = [];

%% For each block
% get response samples at start of each Flash
rowcolcnt=zeros(1,N_buttons);
rowcolcnt1=0;               % for targets
rowcolcnt2=zeros(1,6);      % for nontargets

% Data Extraction & Segmentation (Windowing)
for n=2:size(Signal,1)
    if Flashing(n)==1 && Flashing(n-1)==0
        rowcol=StimulusCode(n);
        rowcolcnt(rowcol)=rowcolcnt(rowcol)+1;
        X=Signal(n:(n+window-1),:);     % size(X)=[179,8]
        
        % Preprocessing
        X=squeeze(X);       % size(X)=[179,8]
        X=filtfilt(b,a,X);        % size(X)=[179,8]
%         for i=1:size(X,2)
%             X=decimate(X(:,i),ds);
%             X(:,i)=X;
%         end
        X=X(1:ds:end,:);      % downsample, size(X)=[23,8]
        responses(rowcol,rowcolcnt(rowcol),:,:)=X;     % size(responses)=[7,N_avr,23,8]
        % responses(1)=rowcol=number of buttons=7
        % responses(2)=rowcolcnt(rowcol)=number of trials per run=1 or 2
        % responses(3)=n-24:n+window-25=number of samples in each window=23
        % responses(4)=:=number of channels=8
    end
end

%% STDA
L=2;
err=10^(-5);
W1_op=weight1_max{1}(:,:,i_sbj);
W2_op=weight1_max{2}(:,:,i_sbj);
w_ST=weight1_max{3}(:,i_sbj);
a
% STDA test
A=squeeze(mean(responses,2));       % size(A)=[7,23,8]
test_ST=[];
for i=1:size(A,1)
    for j=1:size(A,2)
        for k=1:size(A,3)
            test_ST(k,j,i)=A(i,j,k);        % size(test_ST)=[8,23,7]
        end
    end
end
[ y,~ ] = mySTDA_test1( test_ST,W1_op,W2_op,w_ST );     % size(y)=[1,1]





