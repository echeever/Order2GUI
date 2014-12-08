function varargout = Order2Gui(varargin)
% ORDER2GUI M-file for Order2Gui.fig
%      ORDER2GUI, by itself, creates a new ORDER2GUI or raises the existing
%      singleton*.
%
%      H = ORDER2GUI returns the handle to a new ORDER2GUI or the handle to
%      the existing singleton*.
%
%      ORDER2GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORDER2GUI.M with the given input arguments.
%
%      ORDER2GUI('Property','Value',...) creates a new ORDER2GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Order2Gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Order2Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Order2Gui

% Last Modified by GUIDE v2.5 31-Oct-2003 13:23:49

% Begin initialization code - DO NOT EDIT

if nargin==0,
%    close all;
end

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Order2Gui_OpeningFcn, ...
    'gui_OutputFcn',  @Order2Gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Order2Gui is made visible.
function Order2Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Order2Gui (see VARARGIN)

% Choose default command line output for Order2Gui
handles.output = hObject;

% % Update handles structure
% guidata(hObject, handles);
% DrawStatic(handles);
% set(handles.PauseToggle,'Value',get(handles.PauseToggle,'Min'));
% set(handles.PauseToggle,'String','Pause');
% set(handles.HaltToggle,'Value',get(handles.HaltToggle,'Min'));
% axes(handles.RotatingPhasor);
% cla;
% axes(handles.TimePhasor);
% cla;

guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ResetGUI(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.
% Update handles structure


% UIWAIT makes Order2Gui wait for user response (see UIRESUME)
% uiwait(handles.SecondOrderControl);


% --- Outputs from this function are returned to the command line.
function varargout = Order2Gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function ZetaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZetaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function ZetaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ZetaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zeta=10^get(hObject,'Value');
set(handles.ZetaEditText,'String',num2str(zeta,'%4.2g'));
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.

% --- Executes during object creation, after setting all properties.
function OmegaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OmegaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function OmegaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to OmegaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w0=10^get(hObject,'Value');
set(handles.OmegaEditText,'String',num2str(w0,'%4.2g'));
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.


% --- Executes on button press in ImpulseCheckBox.
function ImpulseCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to ImpulseCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0,
    set(handles.impulseFig,'Visible','off');
else
    ShowPlots(handles);
end
guidata(handles.SecondOrderControl,handles);  %save changes to handles.


% --- Executes on button press in StepCheckBox.
function StepCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to StepCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0,
    set(handles.stepFig,'Visible','off');
else
    ShowPlots(handles);
end
guidata(handles.SecondOrderControl,handles);  %save changes to handles.


% --- Executes on button press in BodeCheckBox.
function BodeCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to BodeCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0,
    set(handles.stepFig,'Visible','off');
else
    ShowPlots(handles);
end
guidata(handles.SecondOrderControl,handles);  %save changes to handles.


% --- Executes on button press in PoleZeroCheckBox.
function PoleZeroCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to PoleZeroCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0,
    set(handles.polezeroFig,'Visible','off');
else
    ShowPlots(handles);
end
guidata(handles.SecondOrderControl,handles);  %save changes to handles.



% --- Executes on button press in TFcheckBox.
function TFcheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to TFcheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0,
    set(handles.TFText,'Visible','off');
    set(handles.TFFracBarText,'Visible','off');
    set(handles.TFNumText,'Visible','off');
    set(handles.TFDenText,'Visible','off');
else
    set(handles.TFText,'Visible','on');
    set(handles.TFFracBarText,'Visible','on');
    set(handles.TFNumText,'Visible','on');
    set(handles.TFDenText,'Visible','on');
end
guidata(handles.SecondOrderControl,handles);  %save changes to handles.


% --- Executes during object creation, after setting all properties.
function ZetaEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZetaEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ZetaEditText_Callback(hObject, eventdata, handles)
% hObject    handle to ZetaEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zeta=str2double(get(handles.ZetaEditText,'String'));
zeta=max(min(10,zeta),0.1);
set(handles.ZetaEditText,'String',num2str(zeta,'%4.2g'));
set(handles.ZetaSlider,'Value',log10(zeta));
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.

% --- Executes during object creation, after setting all properties.
function OmegaEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OmegaEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function OmegaEditText_Callback(hObject, eventdata, handles)
% hObject    handle to OmegaEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w0=str2double(get(handles.OmegaEditText,'String'));
w0=max(min(10,w0),0.1);
set(handles.OmegaEditText,'String',num2str(w0,'%4.2g'));
set(handles.OmegaSlider,'Value',log10(w0));
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.

% --- Executes on button press in LowPassRadio.
function LowPassRadio_Callback(hObject, eventdata, handles)
% hObject    handle to LowPassRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LowPassRadio,'Value',1);
set(handles.HighPassRadio,'Value',0);
set(handles.BandPassRadio,'Value',0);
set(handles.NotchRadio,'Value',0);
set(handles.TFNumText,'String','wo^2');
ShowPlots(handles);


% --- Executes on button press in HighPassRadio.
function HighPassRadio_Callback(hObject, eventdata, handles)
% hObject    handle to HighPassRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LowPassRadio,'Value',0);
set(handles.HighPassRadio,'Value',1);
set(handles.BandPassRadio,'Value',0);
set(handles.NotchRadio,'Value',0);
set(handles.TFNumText,'String','s^2');
ShowPlots(handles);


% --- Executes on button press in BandPassRadio.
function BandPassRadio_Callback(hObject, eventdata, handles)
% hObject    handle to BandPassRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LowPassRadio,'Value',0);
set(handles.HighPassRadio,'Value',0);
set(handles.BandPassRadio,'Value',1);
set(handles.NotchRadio,'Value',0);
set(handles.TFNumText,'String','2*zeta*wo*s');
ShowPlots(handles);


% --- Executes on button press in NotchRadio.
function NotchRadio_Callback(hObject, eventdata, handles)
% hObject    handle to NotchRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LowPassRadio,'Value',0);
set(handles.HighPassRadio,'Value',0);
set(handles.BandPassRadio,'Value',0);
set(handles.NotchRadio,'Value',1);
set(handles.TFNumText,'String','s^2+wo^2');
ShowPlots(handles);



% --- Executes on button press in HoldButton.
function HoldButton_Callback(hObject, eventdata, handles)
% hObject    handle to HoldButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get(handles.HoldButton,'Value')
if (get(handles.HoldButton,'Value')==1),
    handles.zetaArray=[];
    handles.omegaArray=[];
    guidata(handles.SecondOrderControl,handles);   %save changes to handles.
end
%     ResetGUI(handles)
%     handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.
% end
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.

% --- Executes on button press in ClearButton.
function ClearButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.zetaArray=[];
handles.omegaArray=[];
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
guidata(handles.SecondOrderControl,handles);   %save changes to handles.
ShowPlots(handles);
handles=guidata(handles.SecondOrderControl);   %Reload handles after function call.


% --- Executes on button press in ExitButton.
function ExitButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.stepFig);
delete(handles.impulseFig);
delete(handles.bodeFig);
delete(handles.polezeroFig);
delete(handles.SecondOrderControl);

function ResetGUI(handles)
%clc
handles.zeta=1.0;
handles.omega=1.0;
handles.zetaArray=[];
handles.omegaArray=[];
handles.stepFig=figure;
handles.impulseFig=figure;
handles.bodeFig=figure;
handles.polezeroFig=figure;
set(handles.stepFig,'Visible','off','Name','2nd Order Step Response');
set(handles.impulseFig,'Visible','off','Name','2nd Order Impulse Response');
set(handles.bodeFig,'Visible','off','Name','2nd Order Frequency Response');
set(handles.polezeroFig,'Visible','off','Name','2nd Order Pole-Zero Plot');
set(handles.TFText,'Visible','off');
set(handles.TFFracBarText,'Visible','off');
set(handles.TFNumText,'Visible','off','String','wo^2');
set(handles.TFDenText,'Visible','off');


set(handles.ZetaSlider,'Value',0);
set(handles.OmegaSlider,'Value',0);
set(handles.ZetaEditText,'String','1.0');
set(handles.OmegaEditText,'String','1.0');
set(handles.StepCheckBox,'Value',0);
set(handles.ImpulseCheckBox,'Value',0);
set(handles.BodeCheckBox,'Value',0);
set(handles.PoleZeroCheckBox,'Value',0);
set(handles.LowPassRadio,'Value',1);
set(handles.HighPassRadio,'Value',0);
set(handles.BandPassRadio,'Value',0);
set(handles.NotchRadio,'Value',0);
set(handles.HoldButton,'Value',0);
guidata(handles.SecondOrderControl,handles);  %save changes to handles.


function ShowPlots(handles);
set(handles.WaitText,'Visible','on')
drawnow
guidata(handles.SecondOrderControl,handles);  %save changes to handles.
zeta=10^get(handles.ZetaSlider,'Value');
w0=10^get(handles.OmegaSlider,'Value');
if get(handles.HoldButton,'Value')==1,
    handles.zetaArray=[ handles.zetaArray zeta];
    handles.omegaArray=[ handles.omegaArray w0];
else
    handles.zetaArray=[zeta];
    handles.omegaArray=[w0];
end

guidata(handles.SecondOrderControl,handles);  %save changes to handles.

leg_str='legend(';
for i=1:length(handles.zetaArray),
    s=sprintf('\\zeta=%3.2f, \\omega_0=%3.2f',...
        handles.zetaArray(i),handles.omegaArray(i));
    leg_str=strcat(leg_str,['''',s,'''']);
    if i~=length(handles.zetaArray),
        leg_str=strcat(leg_str,',');
    end
end
leg_str=strcat(leg_str,');');

if get(handles.StepCheckBox,'Value')==1,
    set(handles.stepFig,'Visible','on');
    figure(handles.stepFig);
    for i=1:length(handles.zetaArray),
        myTF=get_myTF(handles,handles.zetaArray(i),handles.omegaArray(i));
        step(myTF);
        hold on
    end
    eval(leg_str);
    hold off
else
    set(handles.stepFig,'Visible','off'); 
end

if get(handles.ImpulseCheckBox,'Value')==1,
    set(handles.impulseFig,'Visible','on');
    figure(handles.impulseFig);
    for i=1:length(handles.zetaArray),
        myTF=get_myTF(handles,handles.zetaArray(i),handles.omegaArray(i));
        impulse(myTF);
        hold on
    end
    eval(leg_str);
    hold off
else
    set(handles.impulseFig,'Visible','off'); 
end

if get(handles.BodeCheckBox,'Value')==1,
    set(handles.bodeFig,'Visible','on');
    figure(handles.bodeFig);
    for i=1:length(handles.zetaArray),
        myTF=get_myTF(handles,handles.zetaArray(i),handles.omegaArray(i));
        bode(myTF);
        hold on
    end
    eval(leg_str);
    hold off
else
    set(handles.bodeFig,'Visible','off'); 
end


if get(handles.PoleZeroCheckBox,'Value')==1,
    set(handles.polezeroFig,'Visible','on');
    figure(handles.polezeroFig);
    for i=1:length(handles.zetaArray),
        myTF=get_myTF(handles,handles.zetaArray(i),handles.omegaArray(i));
        pzmap(myTF);
        hold on
    end
    eval(leg_str);
    axis equal;
    hold off
else
    set(handles.polezeroFig,'Visible','off'); 
end
set(handles.WaitText,'Visible','off');


function f=get_myTF(handles,zeta,w0)
if get(handles.LowPassRadio,'Value')==1,
    f=tf([0 0 w0*w0],[1 2*zeta*w0 w0*w0]);
elseif get(handles.HighPassRadio,'Value')==1,
    f=tf([1 0 0],[1 2*zeta*w0 w0*w0]);
elseif get(handles.BandPassRadio,'Value')==1,
    f=tf([0 2*zeta*w0 0],[1 2*zeta*w0 w0*w0]);
elseif get(handles.NotchRadio,'Value')==1,
    f=tf([1 0 w0*w0],[1 2*zeta*w0 w0*w0]);
end




