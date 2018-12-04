
// handles attributes that all played notes share
class Note {
  /* ------- REQUIRED FIELDS ------- */
  int channel, velocity, pitch;   // store the channel, velocity and pitch
  int lifespan;                   // lifespan of note, in frames
  boolean isReleased;             // whether or not the note has been released yet

  Note(int channel_, int pitch_, int velocity_) {
    this.channel = channel_;
    this.pitch = pitch_;
    this.velocity = velocity_;
    this.lifespan = 1;
    this.isReleased = false;
  }
  
  // update note age and features
  void update() {
    if (this.isReleased) {
      this.lifespan--;
    }
  }
  
  // display node on canvas
  void display() {

  }
}
