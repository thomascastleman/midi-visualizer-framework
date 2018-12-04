import themidibus.*; // import the midibus library
import java.util.*;  // import java util to use ArrayLists

MidiBus bus; // interface with the MidiBus library
NoteManager nm;  // note manager to handle tracking of MIDI notes

int MINPITCH = 21;  // lowest possible pitch value on this MIDI instrument
int MAXPITCH = 108;  // highest possible pitch value
int pitchRange = MAXPITCH - MINPITCH;  // range of pitch values

void setup() {
  size(700, 700);  // set the size of the window
  background(0);   // set the background color of window

  MidiBus.list(); // list all available Midi devices
  bus = new MidiBus(this, 0, 1); // create a MidiBus
  
  nm = new NoteManager();  // create new note manager
}

void draw() {
  background(0);  // reset the background color
  nm.track();  // track notes being played
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
