# Breathe

## Purpose

The purpose behind ***Breathe*** is to provide simple access to a number of different breathing routines. While doing some research on my own, I came across an interesting body of literature on the patterns and timings used in breathing routines. These routines were simple—simple enough that I thought I ought to build a small app to explore them further. ***Breathe*** guides you through simple breathing routines, like Box Breathing or Pranayama, with a pulsing animation and haptic alerts providing subtle feedback.

## Stack

- SwiftUI
- UserDefaults

We use a simple stack here. Just needing to store a few pieces of information per breathing routine, we can simply store an array of routines in the UserDefaults as our model. For our views, we can allow users to *create*, *search* for and *delete* routines, as well as *play* them. For CRUD views, we use a standard list + sheet architecture. For the player view, we designed a custom view. 

## Code
