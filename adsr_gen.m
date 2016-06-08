function a = adsr_gen(target,gain,duration,noteDuration)
%Creates an Attack Decay Sustain Release envelope
% Input
% target - vector of attack, sustain, release target values
% gain - vector of attack, sustain, release gain values
% duration - vector of attack, sustain, release durations in ms
% Output
% a - vector of adsr envelope values

a = zeros(noteDuration,1); % ASDR envelope has the same duration as the note
duration = round(duration./1000.*noteDuration); % envelope duration in samp
% Attack phase
start = 2;
stop = duration(1);
for n = [start:stop]
a(n) = target(1)*gain(1) + (1.0 - gain(1))*a(n-1);
end
% Sustain phase
start = stop + 1;
stop = start + duration(2);
for n = [start:stop]
a(n) = target(2)*gain(2) + (1.0 - gain(2))*a(n-1);
end
% Release phase
start = stop + 1;
stop = noteDuration;

for n = [start:stop]
a(n) = target(3)*gain(3) + (1.0 - gain(3))*a(n-1);
end;