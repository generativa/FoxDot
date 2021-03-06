SynthDef.new(\soft,
{|vib=0, bus=0, slide=0, rate=1, sus=1, slidefrom=1, fmod=0, amp=1, freq=0, bits=0, pan=0|
var osc, env;
freq = freq + fmod;
freq = Line.ar(freq * slidefrom, freq * (1 + slide), sus);
freq = Vibrato.kr(freq, rate: vib);
sus=(sus * 1.5);
amp=(amp / 30);
rate=(rate + 1);
osc=Klank.ar(`[[rate, (rate * 2), (rate * 3), (rate * 4)], [1, 1, 1, 1], [2, 2, 2, 2]], Crackle.ar(0.005).dup, freq);
env=EnvGen.ar(Env(levels: [0, amp, 0],curve: 'lin',times: (sus * 2)), doneAction: 0);
osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
	ReplaceOut.ar(bus, osc)}).add;
