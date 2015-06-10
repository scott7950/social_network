function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      clean.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to grow (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 16-Jun-2014 16:49:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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



% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)
rand('seed', 5570);

% Choose default command line output for main_gui
handles.output = hObject;
handles.initialization = 0;
% handles.degreeFreqFigHandle = figure;
handles.pre_showNetwork = 0;
set(handles.showNetwork, 'Value', 1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in grow.
function grow_Callback(hObject, eventdata, handles)
% hObject    handle to grow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% guidata(hObject, handles);
runFourGrowData = get(handles.runFourGrowData, 'Value');
if handles.initialization == 0
    errordlg('has not  initialization');
    return
% elseif handles.initialization == 1
%     vertices_conn1 = handles.init_rand_vertices_conn;
else
    vertices_conn1 = handles.vertices_conn1;
    if runFourGrowData == 1
        vertices_conn2 = handles.vertices_conn2;
        vertices_conn3 = handles.vertices_conn3;
        vertices_conn4 = handles.vertices_conn4;
        
        secondParaOfGrow2 = get(handles.secondParaOfGrow2, 'String');
        [startValue_of_secondParaOfGrow2, endValue_of_secondParaOfGrow2] = get_grow_para(secondParaOfGrow2);
        handles.startValue_of_secondParaOfGrow2_val = startValue_of_secondParaOfGrow2;
        handles.endValue_of_secondParaOfGrow2_val = endValue_of_secondParaOfGrow2;
        
        secondParaOfGrow3 = get(handles.secondParaOfGrow3, 'String');
        [startValue_of_secondParaOfGrow3, endValue_of_secondParaOfGrow3] = get_grow_para(secondParaOfGrow3);
        handles.startValue_of_secondParaOfGrow3_val = startValue_of_secondParaOfGrow3;
        handles.endValue_of_secondParaOfGrow3_val = endValue_of_secondParaOfGrow3;
        
        firstParaOfGrow4 = get(handles.firstParaOfGrow4, 'String');
        [startValue_of_firstParaOfGrow4, endValue_of_firstParaOfGrow4] = get_grow_para(firstParaOfGrow4);
        handles.startValue_of_firstParaOfGrow4_val = startValue_of_firstParaOfGrow4;
        handles.endValue_of_firstParaOfGrow4_val = endValue_of_firstParaOfGrow4;
        
        secondParaOfGrow4 = get(handles.secondParaOfGrow4, 'String');
        [startValue_of_secondParaOfGrow4, endValue_of_secondParaOfGrow4] = get_grow_para(secondParaOfGrow4);
        handles.startValue_of_secondParaOfGrow4_val = startValue_of_secondParaOfGrow4;
        handles.endValue_of_secondParaOfGrow4_val = endValue_of_secondParaOfGrow4;
    end
end
handles.initialization = 2;

growTo_str = get(handles.growTo, 'String');
growTo = str2num(growTo_str);
handles.growTo_val = growTo;

if runFourGrowData == 1
    no_of_grow_models = 4;
else
    no_of_grow_models = 1;
end

curr_vertices_grow_stat = zeros(1, no_of_grow_models);
increased_node_no = zeros(1, no_of_grow_models);
for i=1:no_of_grow_models
    curr_vertices = ['vertices_conn', num2str(i)];
    curr_vertices_no = size(eval(curr_vertices), 1);
    if curr_vertices_no == growTo
        curr_vertices_grow_stat(1, i) = 1;
    elseif curr_vertices_no > growTo
        errordlg('Cannot Grow To the size that is less than current size');
        return
    end
    
    increased_node_no(1, i) = growTo - curr_vertices_no;
end
if curr_vertices_grow_stat == 1
    warndlg('already grown to the number of Grow To');
    return
end

% generate mr probability matrix
mr_prob_matrix1 = [1, 0.95; 2, 0.05];
handles.mr_prob_matrix1 = mr_prob_matrix1;
if runFourGrowData == 1
    mr_prob_matrix2 = [1, 0.95; 2, 0.05];
    handles.mr_prob_matrix2 = mr_prob_matrix2;
    
    mr_prob_matrix3 = [1, 0.95; 2, 0.05];
    handles.mr_prob_matrix3 = mr_prob_matrix3;
    
    mr_prob_matrix4 = [];
    for i=startValue_of_firstParaOfGrow4:endValue_of_firstParaOfGrow4
        mr_prob_matrix4 = [mr_prob_matrix4; i, 0];
    end
    mr_prob_matrix4(:, 2) = 1 / sum(size(mr_prob_matrix4, 1));
    handles.mr_prob_matrix4 = mr_prob_matrix4;
end

% generate ms probability matrix
ms_prob_matrix1 = [0, 0; 1, 0; 2, 0; 3, 0];
ms_prob_matrix1(:, 2) = 1 / sum(size(ms_prob_matrix1, 1));
handles.ms_prob_matrix1 = ms_prob_matrix1;
if runFourGrowData == 1
    ms_prob_matrix2 = [];
    for i=startValue_of_secondParaOfGrow2:endValue_of_secondParaOfGrow2
        ms_prob_matrix2 = [ms_prob_matrix2; i, 0];
    end
    ms_prob_matrix2(:, 2) = 1 / sum(size(ms_prob_matrix2, 1));
    handles.ms_prob_matrix2 = ms_prob_matrix2;
    
    ms_prob_matrix3 = [];
    for i=startValue_of_secondParaOfGrow3:endValue_of_secondParaOfGrow3
        ms_prob_matrix3 = [ms_prob_matrix3; i, 0];
    end
    ms_prob_matrix3(:, 2) = 1 / sum(size(ms_prob_matrix3, 1));
    handles.ms_prob_matrix3 = ms_prob_matrix3;
    
    ms_prob_matrix4 = [];
    for i=startValue_of_secondParaOfGrow4:endValue_of_secondParaOfGrow4
        ms_prob_matrix4 = [ms_prob_matrix4; i, 0];
    end
    ms_prob_matrix4(:, 2) = 1 / sum(size(ms_prob_matrix4, 1));
    handles.ms_prob_matrix4 = ms_prob_matrix4;
end

[begin_row_of_new_vertices1, total_vertices_conn1] = network_grow(vertices_conn1, increased_node_no(1, 1), mr_prob_matrix1, ms_prob_matrix1);
if runFourGrowData == 1
    [begin_row_of_new_vertices2, total_vertices_conn2] = network_grow(vertices_conn2, increased_node_no(1, 2), mr_prob_matrix2, ms_prob_matrix2);
    [begin_row_of_new_vertices3, total_vertices_conn3] = network_grow(vertices_conn3, increased_node_no(1, 3), mr_prob_matrix3, ms_prob_matrix3);
    [begin_row_of_new_vertices4, total_vertices_conn4] = network_grow(vertices_conn4, increased_node_no(1, 4), mr_prob_matrix4, ms_prob_matrix4);
end

axes(handles.axes1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate node, show vertice and connection
node_pos = handles.node_pos;
growDetail = get(handles.growDetail, 'Value');
showNetwork = get(handles.showNetwork, 'Value');
pre_showNetwork = handles.pre_showNetwork;
for i=1:increased_node_no
    % generate the node
    new_node_pos = rand(1, 2);
    
    % append the new node
    node_pos = [node_pos; new_node_pos];

end

if showNetwork == 1 && pre_showNetwork == 1
    for i =begin_row_of_new_vertices1:size(total_vertices_conn1, 1)
        % show the new node
        plot(node_pos(i, 1), node_pos(i, 2), 'o');
        
        % connect the new vetice to the first contact
        st_pos = node_pos(i, :);
        
        for j=1:i
            if total_vertices_conn1(i, j) == 1
                en_p = node_pos(j, :);
                line([st_pos(1, 1); en_p(1, 1)], [st_pos(1, 2); en_p(1, 2)]);
                if growDetail == 1
                    pause(0.1);
                end
            end
        end
    end
end


if showNetwork == 1 && pre_showNetwork == 0
    for i=1:size(node_pos, 1)
        plot(node_pos(i, 1), node_pos(i, 2), 'o');
        if growDetail == 1
            pause(0.1);
        end
    end
    
    for i=1:size(total_vertices_conn1, 1)
        for j=i:size(total_vertices_conn1, 2)
            if total_vertices_conn1(i, j) == 1
                line([node_pos(i, 1); node_pos(j, 1)], [node_pos(i, 2); node_pos(j, 2)]);
                if growDetail == 1
                    pause(0.1);
                end
            end
        end
    end
end


if showNetwork == 1 && pre_showNetwork == 0
    for i=1:size(node_pos, 1)
        plot(node_pos(i, 1), node_pos(i, 2), 'o');
        if growDetail == 1
            pause(0.1);
        end
    end
    
    for i=1:size(total_vertices_conn1, 1)
        for j=i:size(total_vertices_conn1, 2)
            if total_vertices_conn1(i, j) == 1
                line([node_pos(i, 1); node_pos(j, 1)], [node_pos(i, 2); node_pos(j, 2)]);
                if growDetail == 1
                    pause(0.1);
                end
            end
        end
    end
end

if showNetwork == 1 
    for i=1:no_of_grow_models
        curr_vertices_conn_name = ['total_vertices_conn', num2str(i)];
        curr_vertices_conn = eval(curr_vertices_conn_name);
            
        fileName = ['network', num2str(i), '.gexf'];
        fileID = fopen(fileName,'w');

        fprintf(fileID, '<?xml version="1.0" encoding="UTF-8"?>');
        fprintf(fileID, '<gexf xmlns:viz="http:///www.gexf.net/1.1draft/viz" version="1.1" xmlns="http://www.gexf.net/1.1draft">');
        fprintf(fileID, '<meta lastmodifieddate="2010-03-03+23:44">');
        fprintf(fileID, '<creator>Gephi 0.7</creator>');
        fprintf(fileID, '</meta>');
        fprintf(fileID, '<graph defaultedgetype="undirected" idtype="string" type="static">');
        
        no_of_vertices = size(curr_vertices_conn, 1);
        fprintf(fileID, '<nodes count="%d">\n', no_of_vertices);
        for j=1:size(curr_vertices_conn, 1)
            fprintf(fileID,'<node id="%d" label="%d"/>\n', j, j);
        end
        
        fprintf(fileID,'</nodes>\n');
        
        nodes_deg = zeros(1, no_of_vertices);
        for j=1:no_of_vertices
            nodes_deg(1, j) = size(find(curr_vertices_conn(j, :) == 1), 2);
        end
        total_nodes_deg = sum(nodes_deg) / 2;
        fprintf(fileID,'<edges count="%d">\n', total_nodes_deg);
        
        edge_id = 0;
        for j=1:(no_of_vertices-1)
            for k=(j+1):no_of_vertices
                if curr_vertices_conn(j, k) == 1
                    fprintf(fileID, '<edge id="%d" source="%d" target="%d"/>\n', edge_id, j, k);
                    edge_id = edge_id + 1;
                end
            end
        end

        fprintf(fileID, '</edges>');
        fprintf(fileID, '</graph>');
        fprintf(fileID, '</gexf>');
        
        fclose(fileID);
        
    end
end

handles.pre_showNetwork = showNetwork;
handles.vertices_conn1 = total_vertices_conn1;
if runFourGrowData == 1
    handles.vertices_conn2 = total_vertices_conn2;
    handles.vertices_conn3 = total_vertices_conn3;
    handles.vertices_conn4 = total_vertices_conn4;
end
handles.node_pos = node_pos;
guidata(hObject, handles);

msgbox('Grow Process is Done');


% --- Executes on button press in clean.
function clean_Callback(hObject, eventdata, handles)
% hObject    handle to clean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;



function n0_Callback(hObject, eventdata, handles)
% hObject    handle to n0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n0 as text
%        str2double(get(hObject,'String')) returns contents of n0 as a double
% n0_str = get(handles.n0, 'String');
% n0 = str2num(n0_str);

n0_str = get(handles.n0, 'String');
n0 = str2num(n0_str);
handles.n0_val = n0;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function n0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function gamma_Callback(~, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double
gamma_str = get(handles.gamma, 'String');
gamma = str2num(gamma_str);
handles.gamma_val = gamma;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in init.
function init_Callback(hObject, eventdata, handles)
% hObject    handle to init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n0_str = get(handles.n0, 'String');
n0 = str2num(n0_str);
handles.n0_val = n0;

randThresh_str = get(handles.randThresh, 'String');
randThresh = str2num(randThresh_str);
if randThresh >= 1
    randThresh = 0.9;
end
handles.randThresh_val = randThresh;

[A] = random_network_vertices_and_connection(n0, randThresh);
[node_pos, st_p, en_p] = random_network_plot_nodes_and_lines(A);

axes(handles.axes1);
axis([0, 1, 0, 1]);
cla;
hold on;
showNetwork = get(handles.showNetwork, 'Value');
if showNetwork == 1
    plot(node_pos(:, 1), node_pos(:, 2), 'o');

    %line([st_p(:, 1)', en_p(:, 1)'], [st_p(:, 2)', en_p(:, 2)']);
    for i=1:size(st_p, 1)
        line([st_p(i, 1); en_p(i, 1)], [st_p(i, 2); en_p(i, 2)]);
    end
end

if showNetwork == 1 
    fileID = fopen('initial_network.gexf','w');

    fprintf(fileID, '<?xml version="1.0" encoding="UTF-8"?>');
    fprintf(fileID, '<gexf xmlns:viz="http:///www.gexf.net/1.1draft/viz" version="1.1" xmlns="http://www.gexf.net/1.1draft">');
    fprintf(fileID, '<meta lastmodifieddate="2010-03-03+23:44">');
    fprintf(fileID, '<creator>Gephi 0.7</creator>');
    fprintf(fileID, '</meta>');
    fprintf(fileID, '<graph defaultedgetype="undirected" idtype="string" type="static">');
        
    no_of_vertices = size(A, 1);
    fprintf(fileID, '<nodes count="%d">\n', no_of_vertices);
    for j=1:size(A, 1)
        fprintf(fileID,'<node id="%d" label="%d"/>\n', j, j);
    end
    
    fprintf(fileID,'</nodes>\n');
    
    nodes_deg = zeros(1, no_of_vertices);
    for j=1:no_of_vertices
        nodes_deg(1, j) = size(find(A(j, :) == 1), 2);
    end
    total_nodes_deg = sum(nodes_deg) / 2;
    fprintf(fileID,'<edges count="%d">\n', total_nodes_deg);
    
    edge_id = 0;
    for j=1:(no_of_vertices-1)
        for k=(j+1):no_of_vertices
            if A(j, k) == 1
                fprintf(fileID,'<edge id="%d" source="%d" target="%d"/>\n', edge_id, j, k);
                edge_id = edge_id + 1;
            end
        end
    end
    
    fprintf(fileID, '</edges>');
    fprintf(fileID, '</graph>');
    fprintf(fileID, '</gexf>');
        
    fclose(fileID);
    
end

handles.init_rand_vertices_conn = A;
handles.vertices_conn1 = handles.init_rand_vertices_conn;
handles.vertices_conn2 = handles.init_rand_vertices_conn;
handles.vertices_conn3 = handles.init_rand_vertices_conn;
handles.vertices_conn4 = handles.init_rand_vertices_conn;
handles.node_pos = node_pos;
handles.initialization = 1;
handles.pre_showNetwork = showNetwork;
guidata(hObject, handles);
msgbox('Initialization of Random Network is Done');


function growTo_Callback(hObject, eventdata, handles)
% hObject    handle to growTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of growTo as text
%        str2double(get(hObject,'String')) returns contents of growTo as a double


% --- Executes during object creation, after setting all properties.
function growTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to growTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in growDetail.
function growDetail_Callback(hObject, eventdata, handles)
% hObject    handle to growDetail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of growDetail


% --- Executes on button press in degreeDistri.
function degreeDistri_Callback(hObject, eventdata, handles)
% hObject    handle to degreeDistri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.initialization <= 1
    warndlg('the network has not grown to the number of Grow To');
    return
end
runFourGrowData = get(handles.runFourGrowData, 'Value');
no_of_grow_models = get_no_of_grow_models(runFourGrowData, ...
    handles.init_rand_vertices_conn, handles.vertices_conn2, ...
    handles.vertices_conn3, handles.vertices_conn4);

degreeShowInOne = get(handles.degreeShowInOne, 'Value');
runFourGrowData = get(handles.runFourGrowData, 'Value');
if runFourGrowData ~= 1 || no_of_grow_models == 1
    degreeShowInOne = 1;
end

if degreeShowInOne == 1
    % figure(handles.degreeFreqFigHandle);
    figure;
    hold on;

    xlabel('Degree (log10)');
    ylabel('Frequency (log10)');
    
    if no_of_grow_models == 1
        curr_mr_prob_matrix = handles.mr_prob_matrix1;
        curr_ms_prob_matrix = handles.ms_prob_matrix1;
    
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        title_str = sprintf('Grow Model\n%s\n%s', mr_str, ms_str);
        title(title_str);
    end
else
    figure;
end

for i=1:no_of_grow_models
    curr_vertices_conn_name = ['handles.vertices_conn', num2str(i)];
    curr_vertices_conn = eval(curr_vertices_conn_name);
    
    curr_mr_prob_matrix_name = ['handles.mr_prob_matrix', num2str(i)];
    curr_mr_prob_matrix = eval(curr_mr_prob_matrix_name);
    
    curr_ms_prob_matrix_name = ['handles.ms_prob_matrix', num2str(i)];
    curr_ms_prob_matrix = eval(curr_ms_prob_matrix_name);
    
    node_degree_distribution = analyze_node_degree_distribution(curr_vertices_conn, curr_mr_prob_matrix, curr_ms_prob_matrix);
    
    [sim_format, theory_format] = get_plot_format_of_sim_and_theory(i);

    if degreeShowInOne ~= 1
        subplot(2, 2, i);
        hold on;

        xlabel('Degree (log10)');
        ylabel('Frequency (log10)');
        
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model %d\n%s\n%s', i, mr_str, ms_str);
        title(title_str);
    end
    
    % simulation data
    for j=1:size(node_degree_distribution, 2)
        plot(node_degree_distribution(1, j), node_degree_distribution(2, j), sim_format, 'MarkerFaceColor', 'red');
    end
    plot(node_degree_distribution(1, :), node_degree_distribution(2, :), '-c');

    % theory data
    plot(node_degree_distribution(1, :), node_degree_distribution(3, :), theory_format);
end
msgbox('Analyze Degree Distribution is Done');


function randThresh_Callback(hObject, eventdata, handles)
% hObject    handle to randThreshLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of randThreshLabel as text
%        str2double(get(hObject,'String')) returns contents of randThreshLabel as a double


% --- Executes during object creation, after setting all properties.
function randThreshLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to randThreshLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function randThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to randThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analyzeClusSpec.
function analyzeClusSpec_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeClusSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.initialization <= 1
    warndlg('the network has not grown to the number of Grow To');
    return
end

runFourGrowData = get(handles.runFourGrowData, 'Value');
no_of_grow_models = get_no_of_grow_models(runFourGrowData, ...
    handles.init_rand_vertices_conn, handles.vertices_conn2, ...
    handles.vertices_conn3, handles.vertices_conn4);

triShowInOne = get(handles.triShowInOne, 'Value');
if runFourGrowData ~= 1 || no_of_grow_models == 1
    triShowInOne = 1;
end

if triShowInOne == 1
    figure;
    hold on;

    xlabel('Degree (log10)');
    ylabel('Cluster (log10)');
    
    if no_of_grow_models == 1
        curr_mr_prob_matrix = handles.mr_prob_matrix1;
        curr_ms_prob_matrix = handles.ms_prob_matrix1;
      
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model\n%s\n%s', mr_str, ms_str);
        title(title_str);
    end
else
    figure;
end

for i=1:no_of_grow_models
    curr_vertices_conn_name = ['handles.vertices_conn', num2str(i)];
    curr_vertices_conn = eval(curr_vertices_conn_name);
    
    curr_mr_prob_matrix_name = ['handles.mr_prob_matrix', num2str(i)];
    curr_mr_prob_matrix = eval(curr_mr_prob_matrix_name);
    
    curr_ms_prob_matrix_name = ['handles.ms_prob_matrix', num2str(i)];
    curr_ms_prob_matrix = eval(curr_ms_prob_matrix_name);
    
    node_triang_and_degree = analyze_triangle_distribution(curr_vertices_conn, curr_mr_prob_matrix, curr_ms_prob_matrix);

    if triShowInOne ~= 1
        subplot(2, 2, i);
        hold on;

        xlabel('Degree (log10)');
        ylabel('Cluster (log10)');
        
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model %d\n%s\n%s', i, mr_str, ms_str);
        title(title_str);
    end
    
    [sim_format, theory_format] = get_plot_format_of_sim_and_theory(i);
    
    for j=1:size(node_triang_and_degree, 2)
        % simulation data
        plot(node_triang_and_degree(1, j), node_triang_and_degree(2, j), sim_format, 'MarkerFaceColor', 'red');

    end

    % theory data
    plot(node_triang_and_degree(1, :), node_triang_and_degree(3, :), theory_format);
end
msgbox('Analyze Node Triangle is Done');


% --- Executes on button press in runFourGrowData.
function runFourGrowData_Callback(hObject, eventdata, handles)
% hObject    handle to runFourGrowData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runFourGrowData



function distribution2_Callback(hObject, eventdata, handles)
% hObject    handle to distribution2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distribution2 as text
%        str2double(get(hObject,'String')) returns contents of distribution2 as a double


% --- Executes during object creation, after setting all properties.
function distribution2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distribution2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secondParaOfGrow2_Callback(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secondParaOfGrow2 as text
%        str2double(get(hObject,'String')) returns contents of secondParaOfGrow2 as a double
secondParaOfGrow2 = get(handles.secondParaOfGrow2, 'String');
[startValue_of_secondParaOfGrow2, endValue_of_secondParaOfGrow2] = get_grow_para(secondParaOfGrow2);
handles.startValue_of_secondParaOfGrow2_val = startValue_of_secondParaOfGrow2;
handles.endValue_of_secondParaOfGrow2_val = endValue_of_secondParaOfGrow2;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function secondParaOfGrow2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secondParaOfGrow3_Callback(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secondParaOfGrow3 as text
%        str2double(get(hObject,'String')) returns contents of secondParaOfGrow3 as a double
secondParaOfGrow3 = get(handles.secondParaOfGrow3, 'String');
[startValue_of_secondParaOfGrow3, endValue_of_secondParaOfGrow3] = get_grow_para(secondParaOfGrow3);
handles.startValue_of_secondParaOfGrow3_val = startValue_of_secondParaOfGrow3;
handles.endValue_of_secondParaOfGrow3_val = endValue_of_secondParaOfGrow3;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function secondParaOfGrow3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function firstParaOfGrow4_Callback(hObject, eventdata, handles)
% hObject    handle to firstParaOfGrow4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of firstParaOfGrow4 as text
%        str2double(get(hObject,'String')) returns contents of firstParaOfGrow4 as a double
firstParaOfGrow4 = get(handles.firstParaOfGrow4, 'String');
[startValue_of_firstParaOfGrow4, endValue_of_firstParaOfGrow4] = get_grow_para(firstParaOfGrow4);
handles.startValue_of_firstParaOfGrow4_val = startValue_of_firstParaOfGrow4;
handles.endValue_of_firstParaOfGrow4_val = endValue_of_firstParaOfGrow4;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function firstParaOfGrow4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstParaOfGrow4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secondParaOfGrow4_Callback(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secondParaOfGrow4 as text
%        str2double(get(hObject,'String')) returns contents of secondParaOfGrow4 as a double
secondParaOfGrow4 = get(handles.secondParaOfGrow4, 'String');
[startValue_of_secondParaOfGrow4, endValue_of_secondParaOfGrow4] = get_grow_para(secondParaOfGrow4);
handles.startValue_of_secondParaOfGrow4_val = startValue_of_secondParaOfGrow4;
handles.endValue_of_secondParaOfGrow4_val = endValue_of_secondParaOfGrow4;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function secondParaOfGrow4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secondParaOfGrow4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in degreeShowInOne.
function degreeShowInOne_Callback(hObject, eventdata, handles)
% hObject    handle to degreeShowInOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of degreeShowInOne


% --- Executes on button press in triShowInOne.
function triShowInOne_Callback(hObject, eventdata, handles)
% hObject    handle to triShowInOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of triShowInOne


% --- Executes on button press in analyzeKnn.
function analyzeKnn_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeKnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.initialization <= 1
    warndlg('the network has not grown to the number of Grow To');
    return
end

runFourGrowData = get(handles.runFourGrowData, 'Value');
no_of_grow_models = get_no_of_grow_models(runFourGrowData, ...
    handles.init_rand_vertices_conn, handles.vertices_conn2, ...
    handles.vertices_conn3, handles.vertices_conn4);

knnShowInOne = get(handles.knnShowInOne, 'Value');
if runFourGrowData ~= 1 || no_of_grow_models == 1
    knnShowInOne = 1;
end

if knnShowInOne == 1
    figure;
    hold on;

    xlabel('Degree (log10)');
    ylabel('knn (log10)');
    
    if no_of_grow_models == 1
        curr_mr_prob_matrix = handles.mr_prob_matrix1;
        curr_ms_prob_matrix = handles.ms_prob_matrix1;
      
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model\n%s\n%s', mr_str, ms_str);
        title(title_str);
    end
else
    figure;
end

for i=1:no_of_grow_models
    curr_vertices_conn_name = ['handles.vertices_conn', num2str(i)];
    curr_vertices_conn = eval(curr_vertices_conn_name);
    
    curr_mr_prob_matrix_name = ['handles.mr_prob_matrix', num2str(i)];
    curr_mr_prob_matrix = eval(curr_mr_prob_matrix_name);
    
    curr_ms_prob_matrix_name = ['handles.ms_prob_matrix', num2str(i)];
    curr_ms_prob_matrix = eval(curr_ms_prob_matrix_name);
    
    node_knn_and_degree = analyze_knn_distribution(curr_vertices_conn);

    if knnShowInOne ~= 1
        subplot(2, 2, i);
        hold on;

        xlabel('Degree (log10)');
        ylabel('knn (log10)');
        
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model %d\n%s\n%s', i, mr_str, ms_str);
        title(title_str);
    end
    
    [sim_format, theory_format] = get_plot_format_of_sim_and_theory(i);
    
    for j=1:size(node_knn_and_degree, 2)
        % simulation data
        plot(node_knn_and_degree(1, j), node_knn_and_degree(2, j), sim_format, 'MarkerFaceColor', 'red');

    end

end
msgbox('Analyze Knn is Done');

% --- Executes on button press in knnShowInOne.
function knnShowInOne_Callback(hObject, eventdata, handles)
% hObject    handle to knnShowInOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knnShowInOne


% --- Executes on button press in showNetwork.
function showNetwork_Callback(hObject, eventdata, handles)
% hObject    handle to showNetwork (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showNetwork


% --- Executes on button press in analyzeShortPath.
function analyzeShortPath_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeShortPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runFourGrowData = get(handles.runFourGrowData, 'Value');
no_of_grow_models = get_no_of_grow_models(runFourGrowData, ...
    handles.init_rand_vertices_conn, handles.vertices_conn2, ...
    handles.vertices_conn3, handles.vertices_conn4);

knnShowInOne = 1;
if knnShowInOne == 1
    figure;
    hold on;

    xlabel('Vertices No. (log10)');
    ylabel('Average Shortest Path Lenght');
    
    if no_of_grow_models == 1
        curr_mr_prob_matrix = handles.mr_prob_matrix1;
        curr_ms_prob_matrix = handles.ms_prob_matrix1;
      
        [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
        title_str = sprintf('Grow Model\n%s\n%s', mr_str, ms_str);
        title(title_str);
    end
else
    figure;
end

for i=1:no_of_grow_models
    curr_vertices_conn_name = ['handles.vertices_conn', num2str(i)];
    curr_vertices_conn = eval(curr_vertices_conn_name);
    
    curr_mr_prob_matrix_name = ['handles.mr_prob_matrix', num2str(i)];
    curr_mr_prob_matrix = eval(curr_mr_prob_matrix_name);
    
    curr_ms_prob_matrix_name = ['handles.ms_prob_matrix', num2str(i)];
    curr_ms_prob_matrix = eval(curr_ms_prob_matrix_name);
    
    analyzeGroups = [];
    no_of_vertices = size(curr_vertices_conn, 1);
    log_of_no_of_vertices = log10(no_of_vertices);
    if log_of_no_of_vertices <= 2
         analyzeGroups = [analyzeGroups, no_of_vertices];
    else
        for j=0:fix(log_of_no_of_vertices - 2)
            analyzeGroups = [analyzeGroups, 10^(j+2)];
        end
        if rem(log_of_no_of_vertices, 1) ~= 0
             analyzeGroups = [analyzeGroups, no_of_vertices];
        end
    end

    for j=1:size(analyzeGroups, 2)
        calc_avg_vertices_no = analyzeGroups(1, j);
        avg_short_path = calc_avg_shortest_path(curr_vertices_conn(1:calc_avg_vertices_no, 1:calc_avg_vertices_no));
    
        if knnShowInOne ~= 1
            subplot(2, 2, i);
            hold on;

            xlabel('Vertices No. (log10)');
            ylabel('Cluster (log10)');
        
            [mr_str, ms_str] = convMrMs2Str(curr_mr_prob_matrix, curr_ms_prob_matrix);
        
            title_str = sprintf('Grow Model %d\n%s\n%s', i, mr_str, ms_str);
            title(title_str);
        end
    
        [sim_format, theory_format] = get_plot_format_of_sim_and_theory(i);
        
        plot(log10(calc_avg_vertices_no), avg_short_path, sim_format);
    end
        
end
msgbox('Analyze Shortest Path is Done');


% --- Executes on button press in analyzeCommunity.
function analyzeCommunity_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeCommunity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runFourGrowData = get(handles.runFourGrowData, 'Value');
if runFourGrowData == 1
    no_of_grow_models = 4;
else
    no_of_grow_models = 1;
end

if (size(handles.vertices_conn2, 1) == size(handles.init_rand_vertices_conn, 1)) || ...
        (size(handles.vertices_conn3, 1) == size(handles.init_rand_vertices_conn, 1)) || ...
        (size(handles.vertices_conn4, 1) == size(handles.init_rand_vertices_conn, 1))
    no_of_grow_models = 1;
end

for i=1:no_of_grow_models
    curr_vertices_conn_name = ['handles.vertices_conn', num2str(i)];
    curr_vertices_conn = eval(curr_vertices_conn_name);
        
    fileName = ['connection', num2str(i), '.txt'];
    fileID = fopen(fileName,'w');
    for j=1:size(curr_vertices_conn, 1)
        for k=j:size(curr_vertices_conn, 2)
            if curr_vertices_conn(j, k) == 1
                fprintf(fileID,'%d %d\n', j, k);
            end
        end
    end
    
    fclose(fileID);
end
msgbox('Generate Vertices Connection File is Done');

