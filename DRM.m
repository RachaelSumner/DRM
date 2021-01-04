% DRM

% Deese, Roediger and McDermott paradigm for studying false memory
% Used for a fun Cognitive Neuroscience based demonstration. Could easily
% be exapanded and added to.

% CREATED:
% Rachael Sumner, June 2018

% EDITED:



%%%%%%%%   BASIC SCREEN SETUP   %%%%%%%%

PsychDefaultSetup(2);

ListenChar(2); %prevent keyboard input going to the MATLAB window
HideCursor; 

screens = Screen('Screens'); %Get the number of screens in the computer setup
screenNumber = max(screens); % display on the most external screen (grab max number)
 
black = BlackIndex(screenNumber);  % Retrieves the CLUT color code for black.
white = WhiteIndex(screenNumber);  % Retrieves the CLUT color code for white.
grey = white / 2;  % Computes the CLUT color code for grey.

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);ScreenRect = Screen ('Rect', window);
oldTextSize = Screen('TextSize', window, 30); %Adjust the number to change the size of the text. Copy and paste this line into the script to vary the text size


%TASK SETUP

WordList = {'bed', ; 'rest'; 'awake'; 'tired'; 'dream'; 'wake'; 'snooze'; 'blanket'; 'doze'; 'slumber'; 'snore'; 'blanket'; 
            'doze'; 'slumber'; 'snore'; 'nap'; 'peace'; 'yawn'; 'drowsy';'sour'; 'candy'; 'sugar'; 'bitter'; 'good'; 
            'taste'; 'tooth'; 'nice'; 'honey'; 'soda'; 'chocolate'; 'heart'; 'cake'; 'tart'; 'pie'}; 

        
%          WORD                         ANSWER
%                           YES                      NO
Answers = {'honey',     'Correct',               'Incorrect'; 
         'rest',        'Correct',               'Incorrect'; 
         'keys',        'Incorrect',             'Correct';
         'sugar',       'Correct',               'Inorrect';
         'sour',        'Correct',               'Incorrect';
         'pie',         'Correct',               'Incorrect';
         'table',       'Incorrect',             'Correct';
         'chocolate',   'Correct',               'Incorrect';
         'soda',        'Correct',               'Incorrect';
         'doze',        'Correct',               'Incorrect';
         'sign',        'Incorrect',             'Correct';
         'wake',        'Correct',               'Correct';
         'drowsy',      'Correct',               'Incorrect';
         'map',         'Incorrect',             'Correct';
         'slumber',     'Correct',               'Incorrect';
         'cake',        'Correct',               'Incorrect';
         'dream',       'Correct',               'Incorrect';
         'bed',         'Correct',               'Incorrect';
         'sweet',       'Thats a false memory!', 'Correct';
         'snooze',      'Correct',               'Incorrect';
         'candy',       'Correct',               'Incorrect';
         'nap',         'Correct',               'Incorrect';
         'tired',       'Correct',               'Incorrect';
         'horse',       'Incorrect',             'Correct';
         'sleep',       'Thats a false memory!', 'Correct';
         'yawn',        'Correct',               'Incorrect';
         'taste',       'Correct',               'Incorrect';
         'arm',         'Incorrect',             'Correct';
         'snore',       'Correct',               'Incorrect';
         'good',        'Correct',               'Incorrect';
         'awake',       'Correct',               'Incorrect'};
        
        
%KEYBOARD SETUP  

KbName('UnifyKeyNames');
activeKeys = [KbName('y') KbName('n') KbName('q') KbName('space')]; 
RestrictKeysForKbCheck(activeKeys); % restrict input from the keyboard to a set number of keys as defined above

Yes = 'y'; 
No = 'n';
Quit = 'q';


%%%%%%%%%%%%  TASK %%%%%%%%%%%%%

%Make the task loop until you press QUIT or SHIFT@

x = 1;

while x == 1; 
    
    %INTRO

    DrawFormattedText(window, 'Test your verbal memory! \n \n \n \nPress SPACEBAR to continue \n \nPress Q to quit at any time', 'center','center', black); %Will accept any activeKeys input
    Screen('Flip', window);
    KbWait
    
    [keyIsDown, secs, keyCode] = KbCheck;
    if find(keyCode) == KbName(Quit)%Hit quit button to exit
          Screen ('CloseAll');
          ShowCursor;
          ListenChar(0);
          return
    end  

    %PRESENT WORD LIST

    DrawFormattedText(window, 'Try and remember these words', 'center','center', black);
    Screen('Flip', window);
    pause (3); 

    for i = 1:length(WordList);


        DrawFormattedText(window, WordList{i}, 'center','center', black);
        Screen('Flip', window);
        pause (1); 

        Screen('Flip', window);
        pause (1); 
        
        [keyIsDown, secs, keyCode] = KbCheck;
        if find(keyCode) == KbName(Quit)%Hit quit button to exit
              Screen ('CloseAll');
              ShowCursor;
              ListenChar(0);
              return
        end 

    end

    %TEST RECALL

    DrawFormattedText(window, 'Which words do you remember? \n \nPress Y for YES \n \nPress N for NO \n \n \nPress SPACEBAR to continue' , 'center','center', black);
    Screen('Flip', window);
    KbWait;

    for i = 1:length(Answers);

        DrawFormattedText(window, Answers{i,1}, 'center','center', black);
        Screen('Flip', window);
        KbWait;

            [keyIsDown, secs, keyCode] = KbCheck;
        if find(keyCode) == KbName(Yes)
              DrawFormattedText(window, Answers{i,2}, 'center', 'center', black); % if Y pressed show answer from YES collumn (2)
               Screen('Flip', window);
               pause (2);
          elseif find(keyCode) == KbName (No)
              DrawFormattedText(window, Answers{i,3}, 'center', 'center', black); % if N pressed show answer from NO collumn (3)
              Screen('Flip', window);
              pause (2);

        elseif find(keyCode) == KbName(Quit)%Hit quit button to exit
              Screen ('CloseAll');
              ShowCursor;
              ListenChar(0);
              return

        end  

        Screen('Flip', window);
        pause (1);

    end
    
    %DESCRIPTION

    DrawFormattedText(window, 'Did you experience a false memory? Almost everyone does! \n \nSo why does this happen? \n \nAll the words on the list were related to the themes \n “sleep” and “sweet”. These concepts become activated \nin your mind, and so during the test phase, \nyou recalled those words as being on the list. \nThis is known as “misattribution” \nor thinking that something you imagined in your mind \nreally happened in the real world. \n \nThis help to show how our memories work. \nIt also shows how they are not always perfect \n \nPress SPACEBAR to exit' , 'center','center', black);
    Screen('Flip', window);
    KbWait
    
    Screen('Flip', window);
    pause (2); 


end

%%%%%END (if limited/no loop)
Screen ('CloseAll');
ShowCursor;
ListenChar (0);
