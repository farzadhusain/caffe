function [all_train_labels, all_test_labels, all_train_files, all_test_files] = get_data_summary(info_path, test_group, num_movies)
%[all_train_labels, all_test_labels, all_train_files, all_test_files] =
%                   get_data_summary(file_path, num_movies)
% INFO_PATH : path to video information (ClipSets)
% NUM_MOVIES: number of movies for processing
% ALL_TRAIN_LABELS : train labels
% ALL_TEST_LABELS  : test labels
% ALL_TRAIN_FILES  : train file names
% ALL_TEST_FILES   : test file names
% test file, train file and labels are organized such that each index will
% give the filename and corresponding labels

%% customized for different datasets; this is for Hollywood2
    actions = {'biking', 'diving', 'golf', 'juggle', ...
        'jumping', 'riding', 'shooting', 'spiking','swing', ...
        'tennis', 'walk_dog'};

%% The following code extracts each movie-label pair in a list from
%% ClipSets, which contains, for each action label, a file giving binary
%% indication of whether each clip has that action label
%since a single movie may have multiple labels, the list is longer than
%total number of movie clips; during classification the list is unscrambled
%to comply with correct testing procedures

l = length(actions);
all_train_files = {};
all_test_files = {};
all_train_labels = [];
all_test_labels = [];


test_count=1;
for i=1:l
    test_data = dir([info_path '*' actions{i} '_' num2str(test_group,'%02.0f') '_*']);
    all_test_labels(test_count:test_count+length(test_data)-1) = i;
    for j=1:length(test_data)
        all_test_files{test_count+j-1} = test_data(j).name;
    end
    test_count = test_count+j;
end

y = dir([info_path '*.avi']);
for j=1:length(y)
    x{j} = y(j).name;
end
all_train_files = setdiff(x,all_test_files);
all_train_labels = zeros(1,length(all_train_files));

for i=1:l
    v_action = ['v_' actions{i}];
    index = strncmpi(all_train_files,v_action,length(v_action));
    all_train_labels(index) = i;
end
    
all_train_labels=all_train_labels';
all_test_labels=all_test_labels';
all_train_files=all_train_files';
all_test_files=all_test_files';

if exist('num_movies', 'var')&&(num_movies>0)    
    m = length(all_train_files);
    p = randperm(m);
    p = p(1:num_movies); % if no input, take all movies
    all_train_labels = all_train_labels(p,:);
    all_train_files = all_train_files(p,:);
    
    all_test_labels = all_test_labels(p,:);
    all_test_files = all_test_files(p,:);    
end
