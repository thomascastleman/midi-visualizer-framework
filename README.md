# midi-visualizer-framework

A generalized framework that can be used to easily create visualizations of MIDI input using [Processing](https://processing.org/) and the [Midibus library](https://github.com/sparks/themidibus).

## Purpose

When using input from a MIDI instrument in Processing, issues may arise with the handling of new notes as they arrive and old notes as they are released. This framework is designed to streamline the process of managing a list of active note objects, adding new ones and removing old ones as they come without throwing any [Concurrent Modification Exceptions.](https://docs.oracle.com/javase/7/docs/api/java/util/ConcurrentModificationException.html) The handling of this process frees up the developer to focus more on the creative aspects of the software they are writing.

## Overview

The code for handling note tracking is packaged into the `NoteManager` class. The `NoteManager` assumes the existence of a `Note` class which has at least the following attributes and functions:
```java
  int lifespan;                   // lifespan of note, in frames
  boolean isReleased;             // whether or not the note has been released yet
  void update()                   // updates something about the properties of the Note object
  void display()                  // generates a visual representation of the note
```
The specific implementation of this class is up to the developer, however. As soon as the `isReleased` flag becomes true, the `NoteManager` begins to decrement the `lifespan` of a note. This by default happens when a note is released, however the flag could be made true earlier if desired.

The `NoteManager` itself has a few key functions which are of use to the developer:

```java
void addNote(Note n)
```
This adds a new `Note` object to be tracked. 

```java
void releaseNote(Note n)
```
This will release the `Note` object with the same specifications as the given `Note n` from being tracked.

```java
void track()
```
This function, which should be run every iteration of the `draw()` loop, tells the `NoteManager` to start tracking all the notes that were pressed since the last iteration of `draw()`, and to stop tracking any of the notes that have since been released. It also calls `update()` and then `display()` on every note currently being tracked.

At any given point in the tracking, an `ArrayList` of the `Note` objects currently being tracked is stored under `NoteManager.notes`.
