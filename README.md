# Godot-BeatKeeper
- [Installation](#installation)
- [Usage](#usage)
- [Explanation of Variables](#explanation-of-variables)
  - [Tempo](#tempo)
  - [Offset In Ms](#offset-in-ms)
  - [Processing Mode](#processing-mode)
  - [Audio Mode](#audio-mode)

# Installation
Download the code & place the `addons` folder in your project folder (`res://`)


# Usage
- Place the BeatKeeper node in your tree and load it with your music
- Set the Tempo to your song's BPM 
- Select which beat intervals you would like it to emit
- Turn on [Audio Mode](#audio-mode) if you need it
- Call `play(float)` on the BeatKeeper node

Signals will be emitted with a `number : int` that tells you how many times that beat interval has been done so far in the song


# Explanation of Variables
![](https://i.imgur.com/AFDR7em.png)
## Tempo
Set this to the song's BPM or Beats Per Minute

## Offset In Ms
In milliseconds, how much you want to delay (or speed up) the emission of signals.
Use cases being:
- The song does not actually start playing until 500ms into the file. Set `Offset In Ms` to `500`.
- I want a signal to be emitted 1 second earlier than the actual beat (e.g. creating a game's hit note early so that it can be seen a set time and approach the beat). Set `Offset In Ms` to `-1000`.
- The song does not actually start playing until 500ms into the file, but I want a signal to be emitted 1 second earlier than the actual beat. Set `Offset In Ms` to `-500` (500 + -1000 = -500)

## Processing Mode
Setting the scans to trigger on _physics_process instead may prove more stable results if physics FPS is forced high

## Audio Mode
If you want to have an AudioStreamPlayer play on a signal emission, you will need to turn on Audio Mode, which will allow the BeatKeeper node to emit the `_audio` signals. These are slightly offset by the percieved AudioServer delay and will make your AudioStreamPlayer play at the correct time instead of slightly later.
