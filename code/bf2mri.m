function [tm, ri, transform,  fix, mov, metric] = bf2mri()

% Catharina Maria Hamer Holland - holland.cat@hotmail.com
% Christoffer Gøthgen - cgathg11@student.aau.dk
% Christos Zoupis Schoinas - xzoupis@gmail.com
% Andrew Janke - a.janke@gmail.com
% 
% Copyright 
% Catharina Maria Hamer Holland, Aalborg University.
% Christoffer Gøthgen, Aalborg University.
% Christos Zoupis Schoinas, Aalborg University.
% Andrew Janke, The University of Queensland.
% Permission to use, copy, modify, and distribute this software and its
% documentation for any purpose and without fee is hereby granted,
% provided that the above copyright notice appear in all copies.  The
% authors and the Universities make no representations about the
% suitability of this software for any purpose.  It is provided "as is"
% without express or implied warranty.

answr = 0;
inputsOK=zeros(1,6);
menu = {'1. Set Transformation Matrix Name', '2. Set Registered Image Name', ...
        '3. Select transformation method', '4. Select fixed images', ...
        '5. Select moving images', '6. Choose Metric'};
out_dir = '';
while sum(inputsOK) < 6 && answr ~= 7
      %=========================MENU==============================%
      fprintf(['\nPlease select the input you want to add:\n' ...
          'WARNING: Make sure the paths do not include spaces or parentheses!!\n']);
      for i=1:length(inputsOK)
          if inputsOK(i)==0
              disp(menu{i})
          else
              disp([menu{i}, '..........ok'])
          end
      end
      answr = input(sprintf('7. Exit\n'));
      %===========================================================%     
      if answr<1 || answr>7
          disp('Wrong choice')
          return
      elseif answr == 1
          %=====================MENU==============================%
          if strcmpi(out_dir, '')
              fprintf('Select the path for the output files\n')
              out_dir = uigetdir(pwd, 'Select the path for the output files\n');
          end
          tmn = input(sprintf ('Transformation Matrix name: '), 's');
          %=======================================================%
          tm = fullfile(out_dir,tmn)
          inputsOK(1) = 1;
      elseif answr == 2
          %=====================MENU==============================%
          if strcmpi(out_dir, '')
              fprintf('Select the path for the output files\n')
              out_dir = uigetdir(pwd, 'Select the path for the output files\n');
          end
          rin = input(sprintf ('Registered image name (don''t forget the .nii in the end): '), 's');
          %=======================================================%
          ri = fullfile(out_dir,rin);
          inputsOK(2) = 1;
      elseif answr == 3
          right_answer = 0;
          while right_answer == 0
            %===================MENU==============================%
            transform = input(sprintf ('Select Transformation method (Rigid, Affine, SyN): '), 's');
            %=====================================================%
            if strcmpi(transform, 'Rigid') || strcmpi(transform, 'Affine') || strcmpi(transform, 'SyN')
                right_answer = 1;
            end
          end
          inputsOK(3) = 1;
      elseif answr == 4
          %=====================MENU==============================%
          fprintf('Select the fixed images\n')
          [FileNameF,fixed] = uigetfile('*.nii','Select the fixed images');
          %=======================================================%
          fix = fullfile(fixed, FileNameF);
          inputsOK(4) = 1;
      elseif answr == 5
          %=====================MENU==============================%
          fprintf('Select the moving images\n')
          [FileNameM,moving] = uigetfile('*.nii','Select the moving images');
          %=======================================================%
          mov = fullfile(moving, FileNameM);
          inputsOK(5) = 1;
      elseif answr == 6
          right_answer = 0;
          while right_answer == 0
          %========================MENU===========================%
            metric = input(sprintf (['Choose metric:\n', ...
                                        'For Mutual Information: MI\n', ...
                                        'For Cross Correlation: CC\n']), 's');
          %=======================================================%
            if strcmpi(metric, 'MI') || strcmpi(metric, 'CC')
                right_answer = 1;
            end
          end

          inputsOK(6) = 1;
      else
          return
      end

end