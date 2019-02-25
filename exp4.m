function varargout = exp4(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exp4_OpeningFcn, ...
                   'gui_OutputFcn',  @exp4_OutputFcn, ...
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


function exp4_OpeningFcn(hObject, ~, handles, varargin)
handles.I=0;
handles.SFtype=1;
Disabler(handles);
handles.output = hObject;
global CN;
CN.Step1Setting=get(handles.Step1Setting,'title');
CN.Step1Setting=get(handles.Step1Setting,'title');
CN.Step2Setting=get(handles.Step2Setting,'title');
CN.Step3Setting=get(handles.Step3Setting,'title');
CN.Step4Setting=get(handles.Step4Setting,'title');
CN.Step5Setting=get(handles.Step5Setting,'title');
CN.text3=get(handles.text3,'string');
CN.text4=get(handles.text4,'string');
CN.text5=get(handles.text5,'string');
CN.text6=get(handles.text6,'string');
CN.text9=get(handles.text9,'string');
CN.MedfiltBT=get(handles.MedfiltBT,'string');
CN.CstmlzBT=get(handles.CstmlzBT,'string');
CN.AddN=get(handles.AddN,'string');
CN.puMenu=get(handles.puMenu,'string');
CN.imgLoader=get(handles.imgLoader,'string');
guidata(hObject, handles);


function varargout = exp4_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;


function puMenu_Callback(~, ~, handles)
Disabler(handles);
Chooser(handles);

function puMenu_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function imgLoader_Callback(hObject, ~, handles)
imgNum=get(handles.imgLoader,'Value');
switch imgNum
    case 2
        handles.I=imread('./samples/pout.tif');
    case 3
        handles.I=imread('./samples/football.jpg');
    case 4
        handles.I=imread('./samples/cameraman.tif');
    case 5
        handles.I=imread('./samples/eight.tif');
    case 6
        handles.I=imread('./samples/rice.png');
    case 7
        [file,path]=uigetfile({'*.jpg;*.tif;*.png;*.gif','Image Files';'*.*','All files'});
        PaF=strcat(path,file);
        if ~isequal(file,0)
        	handles.I=imread(PaF);
        end
end
axes(handles.Origin),imshow(handles.I);
if numel(size(handles.I))>2
    handles.I=rgb2gray(handles.I);
end
axes(handles.Hist),imhist(handles.I);
Chooser(handles);
guidata(hObject, handles);
function imgLoader_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Clear_Callback(hObject, ~, handles)
clAxe(handles.Origin);
clAxe(handles.Hist);
clAxe(handles.Out);
handles.I=0;
guidata(hObject, handles);

function clAxe(x)
axes(x),cla reset;
set(x,'xTick',[]);
set(x,'ytick',[]);
set(x,'xColor','white');
set(x,'yColor','white');

function SaPf_Callback(~, ~, ~)
function AddN_Callback(hObject, ~, handles)
handles.I=imnoise(handles.I,'Salt & Pepper',0.04);
Chooser(handles)
axes(handles.Origin),imshow(handles.I);
axes(handles.Hist),imhist(handles.I);
guidata(hObject,handles);

function Disabler(handles)
set(handles.Rb,'Enable','Off');
set(handles.Rt,'Enable','Off');
set(handles.blkSizeR,'Enable','Off');
set(handles.blkSizeC,'Enable','Off');
set(handles.thr,'Enable','Off');
set(handles.f0,'Enable','Off');
set(handles.f1,'Enable','Off');
set(handles.f2,'Enable','Off');
set(handles.f3,'Enable','Off');
set(handles.g0,'Enable','Off');
set(handles.g1,'Enable','Off');
set(handles.g2,'Enable','Off');
set(handles.g3,'Enable','Off');
set(handles.MedfiltBT,'Enable','Off');
set(handles.CstmlzBT,'Enable','Off');
set(handles.Factor,'Enable','Off');
set(handles.m11,'Enable','Off');
set(handles.m12,'Enable','Off');
set(handles.m13,'Enable','Off');
set(handles.m21,'Enable','Off');
set(handles.m22,'Enable','Off');
set(handles.m23,'Enable','Off');
set(handles.m31,'Enable','Off');
set(handles.m32,'Enable','Off');
set(handles.m33,'Enable','Off');
set(handles.SpMenu,'Enable','Off');
set(handles.Sensi,'Enable','Off');

function Chooser(handles)
measure=get(handles.puMenu,'Value');
switch measure
    case 2
        if ~isequal(handles.I,0)
            HistBalancer(handles);
        end
    case 3
        set(handles.Rb,'Enable','On');
        set(handles.Rt,'Enable','On');
        if ~isequal(handles.I,0)
            Grayfix(handles);
        end
    case 4
        set(handles.blkSizeR,'Enable','On');
        set(handles.blkSizeC,'Enable','On');
        set(handles.thr,'Enable','On');
        if ~isequal(handles.I,0)
            LightFix(handles);
        end
    case 5
        set(handles.f0,'Enable','On');
        set(handles.f1,'Enable','On');
        set(handles.f2,'Enable','On');
        set(handles.f3,'Enable','On');
        set(handles.g0,'Enable','On');
        set(handles.g1,'Enable','On');
        set(handles.g2,'Enable','On');
        set(handles.g3,'Enable','On');
        if ~isequal(handles.I,0)
            pltFix(handles);
        end
    case 6
        set(handles.MedfiltBT,'Enable','On');
        set(handles.CstmlzBT,'Enable','On');
        set(handles.Factor,'Enable','On');
        set(handles.m11,'Enable','On');
        set(handles.m12,'Enable','On');
        set(handles.m13,'Enable','On');
        set(handles.m21,'Enable','On');
        set(handles.m22,'Enable','On');
        set(handles.m23,'Enable','On');
        set(handles.m31,'Enable','On');
        set(handles.m32,'Enable','On');
        set(handles.m33,'Enable','On');
        if ~isequal(handles.I,0)
            SmoothFix(handles);
        end
    case 7
        set(handles.SpMenu,'Enable','On');
        set(handles.Sensi,'Enable','On');
        if ~isequal(handles.I,0)
            SharpenFix(handles);
        end
end

function HistBalancer(handles)
axes(handles.Out),imshow(handles.I);

function Grayfix(handles)
Rb=str2double(get(handles.Rb,'String'));
Rt=str2double(get(handles.Rt,'String'));
J1=imadjust(handles.I,[Rb,Rt],[]);
axes(handles.Out),imshow(J1);

function LightFix(handles)
global thr;
thr=str2double(get(handles.thr,'String'));
blkSizeR=str2double(get(handles.blkSizeR,'String'));
blkSizeC=str2double(get(handles.blkSizeC,'String'));
J2_blk=blockproc(double(handles.I),[blkSizeR blkSizeC],@estibackground);
J2_bg=imresize(J2_blk,size(handles.I),'bilinear');
J2=imsubtract(handles.I,uint8(J2_bg));
axes(handles.Out),imshow(J2);
function [backgray]=estibackground(x)
global thr;
backgray=max(mean(x.data(:))-thr*std(x.data(:)),min(x.data(:)));

function pltFix(handles)
I=handles.I;
f0=str2double(get(handles.f0,'String'));
f1=str2double(get(handles.f1,'String'));
f2=str2double(get(handles.f2,'String'));
f3=str2double(get(handles.f3,'String'));
g0=str2double(get(handles.g0,'String'));
g1=str2double(get(handles.g1,'String'));
g2=str2double(get(handles.g2,'String'));
g3=str2double(get(handles.g3,'String'));
a1=(g1-g0)/(f1-f0);
a2=(g2-g1)/(f2-f1);
a3=(g3-g2)/(f3-f2);
I(I>=f0&I<=f1)=a1*I(I>=f0&I<=f1);
I(I>f1&I<=f2)=a2*(I(I>f1&I<=f2)-f1)+g1;
I(I>f2&I<=f3)=a3*(I(I>f2&I<=f3)-f2)+g2;
axes(handles.Out),imshow(I);

function SmoothFix(handles)
I=handles.I;
if get(handles.MedfiltBT,'Value')==get(handles.CstmlzBT,'Value')
    set(handles.MedfiltBT,'Value',1);
end
if handles.SFtype==1
    K=medfilt2(I);
    axes(handles.Out),imshow(K);
elseif handles.SFtype==2
    Factor=str2num(get(handles.Factor,'String')); 
    m11=str2double(get(handles.m11,'String'));
    m12=str2double(get(handles.m12,'String'));
    m13=str2double(get(handles.m13,'String'));
    m21=str2double(get(handles.m21,'String'));
    m22=str2double(get(handles.m22,'String'));
    m23=str2double(get(handles.m23,'String'));
    m31=str2double(get(handles.m31,'String'));
    m32=str2double(get(handles.m32,'String'));
    m33=str2double(get(handles.m33,'String'));
    matrix=Factor.*[m11,m12,m13;m21,m22,m23;m31,m32,m33];
    K=filter2(matrix,I);
    axes(handles.Out),imshow(K);
end

function SharpenFix(handles)
Sensi=str2double(get(handles.Sensi,'String'));
Sp=get(handles.SpMenu,'Value');
switch Sp
    case 1
        SpType='Roberts';
    case 2
        SpType='Prewitt';
    case 3
        SpType='Sobel';
    otherwise
        SpType=0;
end
if isequal(SpType,0)
    J=imfilter(handles.I,[0 -1 0; -1 4 -1; 0 -1 0]);
else
    J=edge(handles.I,SpType,Sensi);
end
axes(handles.Out),imshow(J);


%Step1Setting
function Rb_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    Grayfix(handles)
end
function Rb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Rt_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    Grayfix(handles)
end
function Rt_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Step2Setting
function blkSizeR_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    LightFix(handles)
end
function blkSizeR_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function blkSizeC_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    LightFix(handles)
end
function blkSizeC_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function thr_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    LightFix(handles)
end
    function thr_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Step3Setting
function f0_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function f0_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function g0_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function g0_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function f1_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function f1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function f3_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function f3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function f2_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function f2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function g1_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function g1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function g2_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function g2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function g3_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    pltFix(handles)
end
function g3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Step4Setting
function MedfiltBT_Callback(hObject, ~, handles)
set(handles.CstmlzBT,'Value',0)
handles.SFtype=1;
guidata(hObject,handles);
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function CstmlzBT_Callback(hObject, ~, handles)
set(handles.MedfiltBT,'Value',0)
handles.SFtype=2;
guidata(hObject,handles);
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function SaPf_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Factor_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function Factor_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m11_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m11_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m12_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m12_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m13_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m13_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m21_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m21_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m22_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m22_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m23_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m23_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m31_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m31_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m32_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m32_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function m33_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SmoothFix(handles)
end
function m33_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Step5Setting
function SpMenu_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SharpenFix(handles)
end
function SpMenu_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Sensi_Callback(~, ~, handles)
if ~isequal(handles.I,0)
    SharpenFix(handles)
end
function Sensi_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Language_Select.
function Language_Select_Callback(hObject, eventdata, handles)
langNum=get(handles.Language_Select,'Value');
global CN;
switch langNum
    case 1
        set(handles.Step1Setting,'title',CN.Step1Setting);
        set(handles.Step2Setting,'title',CN.Step2Setting);
        set(handles.Step3Setting,'title',CN.Step3Setting);
        set(handles.Step4Setting,'title',CN.Step4Setting);
        set(handles.Step5Setting,'title',CN.Step5Setting);
        set(handles.text3,'string',CN.text3);
        set(handles.text4,'string',CN.text4);
        set(handles.text5,'string',CN.text5);
        set(handles.text6,'string',CN.text6);
        set(handles.text9,'string',CN.text9);
        set(handles.MedfiltBT,'string',CN.MedfiltBT);
        set(handles.CstmlzBT,'string',CN.CstmlzBT);
        set(handles.AddN,'string',CN.AddN);
        set(handles.puMenu,'string',CN.puMenu);
        set(handles.imgLoader,'string',CN.imgLoader);
    case 2
        set(handles.Step1Setting,'title','Grayscale Correction Range');
        set(handles.Step2Setting,'title','Light Correction');
        set(handles.Step3Setting,'title','Turning Points of 3-Stage Linear Transformation');
        set(handles.Step4Setting,'title','Smoothing Method');
        set(handles.Step5Setting,'title','Sharpen Method');
        set(handles.text3,'string','Block processing size');
        set(handles.text4,'string','Factor');
        set(handles.text5,'string','Original Points');
        set(handles.text6,'string','Expected Points');
        set(handles.text9,'string','Threshold:');
        set(handles.MedfiltBT,'string','Median Filtering');
        set(handles.CstmlzBT,'string','Customized Model');
        set(handles.AddN,'string','Add Pepper Noise');
        set(handles.puMenu,'string',{'Select a image enhancement function...';'Histogram Equalization [No options]';'Grayscale Correction';'Uneven Illumination Correction';'3-Stage Linear Transformation Enhancement';'Image Smoothing';'Image Sharpen'})
        set(handles.imgLoader,'string',{'Select an image...';'pout.tif';'football.jpg';'cameraman.tif';'eight.tif';'rice.png';'Customize…'})
end
guidata(hObject, handles);

function Language_Select_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
