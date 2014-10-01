clc, close all

%% determine data paths
params.afspath = '/media/shusain/farzad_hdd/ExternalProjects/action_recognition_spatio_temporal_features/';
params.infopath = [params.afspath, 'action_youtube_naudio/vids/']; 
params.avipath{1} = [params.afspath, 'action_youtube_naudio/vids/'];


params.path_img_write = '../../../data/action_youtube_naudio/';

test_group=1;
[all_train_labels, all_test_labels, all_train_files, all_test_files] ...
        = get_data_summary(params.infopath,test_group);

ROWS = 8;
COLUMNS = 7;
TIME_SAMPLES = 1;
size_idx = 1;
img = [];
%% load the train videos and save them in image format for the deep network
m = length(all_train_files);
for i=1:m
    i
	M = load_movie_clip([params.avipath{size_idx}, char(all_train_files(i))]);
	nFrames = size(M,3);
    % ff = int32(linspace(1,nFrames,TIME_SAMPLES));
    ff(1) = ceil(nFrames/2);
	if (nFrames>TIME_SAMPLES)
		
		for j=1:TIME_SAMPLES
            img = imresize(M(:,:,ff(j)), 0.5);
        end
            imwrite(img, [params.path_img_write, all_train_files{i},'.jpg']);
    end
	img=[];
end
%% write train file names along with their labels

for i=1:length(all_train_files)
	all_train_files{i} = ['/home/shusain/caffe/data/action_youtube_naudio/', all_train_files{i},'.jpg'];
end


T = table(all_train_files,all_train_labels);
writetable(T,[params.path_img_write, 'train.txt'],'WriteVariableNames',false,'Delimiter',' ');

%% load the test videos and save them in image format for the deep network
m = length(all_test_files);
for i=1:m
    i
	M = load_movie_clip([params.avipath{size_idx}, char(all_test_files(i))]);
	nFrames = size(M,3);
    % ff = int32(linspace(1,nFrames,TIME_SAMPLES));
    ff(1) = ceil(nFrames/2);
	if (nFrames>TIME_SAMPLES)
		
		for j=1:TIME_SAMPLES
            img = imresize(M(:,:,ff(j)), 0.5);
        end
            imwrite(img, [params.path_img_write, all_test_files{i},'.jpg']);
    end
	img=[];
end
%% write test file names along with their labels

for i=1:length(all_test_files)
        all_test_files{i} = ['/home/shusain/caffe/data/action_youtube_naudio/', all_test_files{i},'.jpg'];
end

T = table(all_test_files,all_test_labels);
writetable(T,[params.path_img_write, 'test.txt'],'WriteVariableNames',false,'Delimiter',' ');


