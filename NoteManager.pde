
// class to manage the tracking of MIDI notes, as played live
class NoteManager {
  
  public ArrayList<Note> notes = new ArrayList<Note>();      // all note objects currently being tracked
  private ArrayList<Note> notesToAdd = new ArrayList<Note>(); // notes to add to the list of tracked notes
  private ArrayList<Note> release = new ArrayList<Note>();    // notes that will be released on this iteration of the draw() loop
  private ArrayList<Note> notesToRelease = new ArrayList<Note>();  // notes waiting for the next iteration of draw() to be released
  
  // construct a new NoteManager object
  public NoteManager() {
     
  }
  
  // add a new note to tracked notes
  void addNote(Note n) {
    // add note to list of notes that will be tracked in the next iteration of draw()
    notesToAdd.add(n);
  }
  
  // remove a note from tracked notes
  void releaseNote(Note n) {
    // add note to list of notes that will be released in the next iteration of draw()
    notesToRelease.add(n);
  }
  
  // add new notes to tracked notes, remove old notes from tracked notes
  void track() {
    this.release.addAll(this.notesToRelease);  // add every note waiting to be released to the list of notes about to be released
    this.notesToRelease.clear();  // remove everything from the list of notes waiting to be released
    
    // for each note that has been released
    for (Note n : this.release) {
      for (Note m : this.notes) {
        if (n.channel == m.channel && n.pitch == m.pitch) {
          m.isReleased = true;  // record that this note is now released
        }
      }
    }
    
    this.release.clear();  // remove everything from the list of notes to remove
  
    this.notes.addAll(this.notesToAdd);  // add every note waiting to be kept track of
    this.notesToAdd.clear();  // remove everything from list of notes waiting to be tracked
    
    // iterate through all notes currently being tracked
    ListIterator<Note> iter = this.notes.listIterator();
    while (iter.hasNext()) {
      Note n = iter.next();
      
      // update and display each note
      n.update();
      n.display();
      
      // if a note is finished, remove from tracked notes
      if (n.age == n.maxAge) {
        iter.remove();
      }
    }
  }
  
}
