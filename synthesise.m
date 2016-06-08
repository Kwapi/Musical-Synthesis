function [ notes ] = synthesise( track, BPM, instrument)
%Synthesises a tune using a resample mechanism
%
%Input:
%track -         String to txt file containing frequencies and durations of the notes in a
%                "f:d" format
%BPM -           integer denoting the number of Beats Per Minute to be used
%instrument -    String to wav file containing an instrument sample
%
%Output:
%notes -         array containing a synthesised tune

crotchetDurationSec = 60/BPM;
txt = fopen(track);
values = textscan(txt,'%d:%f');
fclose(txt);

% put the frequency and duration values into two vectors
m = cell2mat(values(1));
for i =1 : length(m)

end
d = cell2mat(values(2));

%load the instrument file
[x,fs] = audioread(instrument);

%  create an array to store the resampled notes
notes = zeros;

%resample
for i=1:length(m)
    % 0 is a rest. If it's a note do the resampling.
    if m(i)~=0
        %NOTE
        %   sample sounds are an A4 note (440Hz)
        originalFreq = 440;
        %transpose midi number to frequency
        f(i) = nearest(midiToFreq(m(i)));
        %   doubling both the original freq and intended freq to enable the use of
        %   notes whose frequencies are not integers (p/q ratio is preserved)
        note = resample(x, originalFreq*2, double(f(i)*2));
        %   alter the duration of the note to match the notation
        duration = crotchetDurationSec * fs * d(i);
        note = note(1:duration);
        %   create ASDR envelope (modified version of
        %   http://194.81.104.27/~brian/DSP/ReadMusic.pdf)
        target = [0.99999;0.25;0.05];
        gain = [0.005;0.0004;0.00075];
        duration = [125;800;75];
        a = adsr_gen(target,gain,duration,length(note));
        
        %  modulate the note to implement ASDR envelope
        
        note = note.*a;
        
    else
        %REST
        note = x;
        duration = crotchetDurationSec * fs * d(i); %calculate the duration of the rest
        note = note(1:duration); %trim the note
        note = note*0; %set all values to zero to simulate the rest
        
    end
    
    %adding the new sound into an array of notes making up the track
    notes = [notes; note];
end


end

