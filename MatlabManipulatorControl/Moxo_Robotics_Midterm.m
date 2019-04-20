function varargout = Moxo_Robotics_Midterm(varargin)
% MOXO_ROBOTICS_MIDTERM MATLAB code for Moxo_Robotics_Midterm.fig
%      MOXO_ROBOTICS_MIDTERM, by itself, creates a new MOXO_ROBOTICS_MIDTERM or raises the existing
%      singleton*.
%
%      H = MOXO_ROBOTICS_MIDTERM returns the handle to a new MOXO_ROBOTICS_MIDTERM or the handle to
%      the existing singleton*.
%
%      MOXO_ROBOTICS_MIDTERM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOXO_ROBOTICS_MIDTERM.M with the given input arguments.
%
%      MOXO_ROBOTICS_MIDTERM('Property','Value',...) creates a new MOXO_ROBOTICS_MIDTERM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Moxo_Robotics_Midterm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Moxo_Robotics_Midterm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Moxo_Robotics_Midterm

% Last Modified by GUIDE v2.5 06-Oct-2017 16:50:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Moxo_Robotics_Midterm_OpeningFcn, ...
                   'gui_OutputFcn',  @Moxo_Robotics_Midterm_OutputFcn, ...
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


% --- Executes just before Moxo_Robotics_Midterm is made visible.
function Moxo_Robotics_Midterm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Moxo_Robotics_Midterm (see VARARGIN)

% Choose default command line output for Moxo_Robotics_Midterm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Moxo_Robotics_Midterm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Moxo_Robotics_Midterm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CCx CCy

%% Process Image
[CCx, CCy, CC] = image_processing_moxo();

Moxo_RobotArmKinematics();
