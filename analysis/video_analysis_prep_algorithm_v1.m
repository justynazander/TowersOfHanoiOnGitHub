hmean = video.Mean;

% number of successive image comparisons
nimages = 100;

% initialize the mean for the number of successive image comparisons
m = zeros(nimages);

% initialize the image sequence for display to the user
image_sequence = zeros(150,120,3,nimages);
left_sequence = zeros(150,120,3,nimages);
right_sequence = zeros(150,120,3,nimages);

% compute left image submatrix to successively compare
uint8_video_left = uint8(video_left);
left = uint8_video_left(75:224, 1:120, :);

% compute uint8 version of right image
uint8_video_right = uint8(video_right);

for k=1:nimages
    % compute successive right image submatrices for comparison
    right = uint8_video_right(125+k:125+149+k, 1:120, :);
    
    % compare left and right image submatrices
    cmp = bitxor(left,right);
    
    % compute the mean over all pixels of the comparison results
    m(k) = step(hmean,double(cmp));

    % create image sequences to show comparison and results
    image_sequence(:,:,:,k) = cmp;
    left_sequence(:,:,:,k) = left;
    right_sequence(:,:,:,k) = right;
end

plot(m);
grid;

implay(uint8(image_sequence), 10);
implay(uint8(left_sequence), 10);
implay(uint8(right_sequence), 10);