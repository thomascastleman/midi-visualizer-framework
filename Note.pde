
// handles attributes that all played notes share
class Note {
  /* ------- REQUIRED FIELDS ------- */
  int channel, velocity, pitch;   // store the channel, velocity and pitch
  int age, maxAge;                // current age, maximum possible age (in frames)
  boolean isReleased = false;     // whether or not the note has been released yet

  Note(int channel_, int pitch_, int velocity_) {
    this.channel = channel_;
    this.pitch = pitch_;
    this.velocity = velocity_;
    this.age = 0;  // age starts at 0
    this.maxAge = 1; // arbitrarily -- example purposes
  }
  
  // update note age and features
  void update() {
    if (this.isReleased) {
      this.age++;
    }
  }
  
  // display node on canvas
  void display() {
    // e.g. draw an ellipse, x position scaled based on note pitch
    ellipse(scaleValue(this.pitch, MINPITCH, MAXPITCH, 0, width), 350, 20, 20);
  }
}
