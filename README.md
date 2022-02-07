# Breathe

![gif of the player screen](https://github.com/jpknwls/Lynx/blob/main/include/breathe.gif?raw=true)

## Purpose

***Breathe*** is an iOS app built with SwiftUI. The purpose behind ***Breathe*** is to provide simple access to a number of different breathing routines. While doing research on breathing exercises, I realized there was a lot of overlap between common routines, in terms of how they were structured. These routines were simple—simple enough that I thought I could build a small app to explore them further. 

## Stack

- SwiftUI
- UserDefaults

## Design

I use a simple stack here. Just needing to store a few pieces of information per breathing routine, we can simply store an array of routines in the UserDefaults as our model. For the views, we want to allow users to *create*, *search* for and *delete* routines, as well as *play* them. For CRUD views, we use a standard list + sheet architecture. For the Player view, we designed a custom view that ******guides you through a breathing routine, like Box Breathing or Pranayama, with prompts, a pulsing animation and haptic alerts.

### Routes

- /

Displays a tab view for BoxPlayer, PranayamaPlayer, CustomRoutines and Settings.

- /[...]Player

Displays a custom view to conduct the breathing routine.

- /customRoutines

Displays a list of routines. Allows adding, reordering and deleting. 

- /settings/

Allows the changing of app colors.


![photo of the add screen](https://github.com/jpknwls/Lynx/blob/main/include/breathe-add.png?raw=true)
![photo of the player screen](https://github.com/jpknwls/Lynx/blob/main/include/breathe-player.png?raw=true)
