function [ freq ] = midiToFreq( midi )

%converts midi notation to frequency in Hz
% Using a4 as base frequency: midi notation - 69, frequency - 440

a4freq = 440;
a =   (double(midi-69)/12);
freq = (2^a) * a4freq;

end

