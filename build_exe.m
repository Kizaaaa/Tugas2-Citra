% ===== BUILD SCRIPT FOR WINDOWS EXE =====
% Save this as: build_exe.m
% Then run in MATLAB Command Window: build_exe

% Check if MATLAB Compiler is installed
if ~exist('mcc', 'file')
    error('MATLAB Compiler is not installed. Please install it and try again.');
end

% Settings
app_name = 'ImageProcessingGUI';
input_file = 'image_processing_gui.m';
output_dir = 'dist';

% Create output directory if it doesn't exist
if ~isfolder(output_dir)
    mkdir(output_dir);
end

% Compile to standalone Windows executable
disp('Compiling MATLAB GUI to Windows executable...');
disp('This may take a few minutes...');

mcc('-m', ...                           % Compile to standalone exe
    input_file, ...                     % Input MATLAB file
    '-o', app_name, ...                 % Output name
    '-d', output_dir, ...               % Output directory
    '-v', ...                           % Verbose output
    '-R', 'nodisplay', ...              % Run without display splash
    '-R', 'nojvm');                     % Run without Java VM (optional)

disp(' ');
disp('✓ Build complete!');
disp(['✓ Executable created at: ' fullfile(output_dir, [app_name '.exe'])]);
disp(' ');
disp('To run the application:');
disp(['  1. Navigate to: ' output_dir]);
disp(['  2. Double-click: ' app_name '.exe']);
disp(' ');
disp('Note: First run will take longer due to MATLAB Runtime initialization.');
disp('Make sure you have MATLAB Runtime installed, or distribute with MCRInstaller.exe');