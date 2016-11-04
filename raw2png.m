function raw2png(Dir, extension)
% raw2png(Dir, extension) converts the raw file with the extension given 
% from the directory given to png files. The png files are saved in the
% same directory and then are resized in the 25% of their original size.

disp(['mogrify -format png ' Dir '/*.' extension]);

disp(['mogrify -resize 25% *.' extension]);