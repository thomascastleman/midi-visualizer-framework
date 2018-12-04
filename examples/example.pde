import themidibus.*; // import the midibus library
import java.util.*;  // import java util to use ArrayLists

MidiBus bus;     // interface with the MidiBus library
NoteManager nm;  // note manager to handle tracking of MIDI notes

int MINPITCH = 21;   // lowest possible pitch value on this MIDI instrument
int MAXPITCH = 108;  // highest possible pitch value

void setup() {
  fullScreen();                    // set the size of the window
  background(0);                   // set the background color of window
  MidiBus.list();                  // list all available Midi devices
  bus = new MidiBus(this, 0, 1);   // tell MidiBus to listen to connected MIDI instrument
  nm = new NoteManager();          // create a note manager
}

void draw() {
  background(0); // reset the background color
  nm.track();    // track notes being played, updating and displaying them
}

// when a new key is pressed on the MIDI instrument
void noteOn(int channel, int pitch, int velocity) {
  // add this note
  nm.addNote(new Note(channel, pitch, velocity));
}

// when a key is released on the MIDI instrument
void noteOff(int channel, int pitch, int velocity) {
  // release this note
  nm.releaseNote(new Note(channel, pitch, velocity));
}

// scale value from one range to another
float scaleVal(float value, int oldMin, int oldMax, int newMin, int newMax) {
  return (((float) (value - oldMin)) / (oldMax - oldMin)) * (newMax - newMin) + newMin;
}

// scale pitch to a rainbow color value
color scalePitchToRainbow(int pitch) {
  float freq = 2 * (2 * (float) Math.PI) / (MAXPITCH - MINPITCH);
  
  // scale between 0 and pitchRange
  int truePitch = pitch - MINPITCH;
  
  // calc rgb values using out of phase waves
  float r = scaleVal((float) Math.cos(truePitch * freq), -1, 1, 0, 255);
  float b = scaleVal((float) Math.cos(truePitch * freq + 2), -1, 1, 0, 255);
  float g = scaleVal((float) Math.cos(truePitch * freq + 4), -1, 1, 0, 255);
  
  return color(r, g, b);
}