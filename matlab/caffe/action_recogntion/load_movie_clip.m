function M = load_movie_clip(filename)

while true
    try
        xyloObj = VideoReader(filename);
        break;
    catch
        fprintf('error occurs, retry...')
    end
end

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

M = zeros(vidHeight,vidWidth,nFrames,'single');

% for k = 1 : nFrames
%     M(:,:,k) = single(rgb2gray(read(xyloObj,k)))/255;
%     figure(1),imshow(read(xyloObj,k));
%     drawnow
% end
M_color =  read(xyloObj,[1 Inf]);

for k = 1 : nFrames
    M(:,:,k) = single(rgb2gray(M_color(:,:,:,k)))/255;
end
