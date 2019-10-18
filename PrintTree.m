function[]= structstruct(S)

% Figure the type and class of the input
whosout = whos('S');
sizes = whosout.size;
sizestr = [int2str(sizes(1)),'x',int2str(sizes(2))];
endstr = [':  [' sizestr '] ' whosout.class];

% Print out the properties of the input variable
disp(' ');
disp([inputname(1) endstr]);

% Check if S is a structure, then call the recursive function
if isstruct(S)
    recursor(S,0,'');
end

% Print out a blank line
disp(' ');

end

function recursor(S,level,recstr)

recstr = [recstr '  |'];

fnames = fieldnames(S);
disp(fnames);

for i = 1:length(fnames)
    
    %% Print out the current fieldname
    
    % Take out the i'th field
    tmpstruct = S.(fnames{i});
    
    
    % Figure the type and class of the current field
    whosout = whos('tmpstruct');
    sizes = whosout.size;
    sizestr = [int2str(sizes(1)),'x',int2str(sizes(2))];
    endstr = [':  [' sizestr '] ' whosout.class];
    
    % Create the strings
    if i == length(fnames) % Last field in the current level
        %str = [recstr(1:(end-1)) '''--' S.(fnames{i}) endstr];
        disp([recstr(1:(end-1)) '''--' S.(fnames{i}) endstr]);
        recstr(end) = ' ';
    else % Not the last field in the current level
        %str = [recstr '--' fnames{i} endstr];
        disp([recstr '--' (fnames{i}) endstr]);
    end
    
    % Print the output string to the command line
    
    %% Determine if each field is a struct
    
    % Check if the i'th field of S is a struct
    if isstruct(tmpstruct) % If tmpstruct is a struct, recursive function call
        recursor(tmpstruct,level+1,recstr); % Call self
    end
    
end

end