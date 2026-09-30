# Exposure Diary

An iOS app for logging daily trips — mileage, duration, places, and how many
people you came into contact with — and viewing running totals. Built in Swift
for CSC 214 (iOS Development) at the University of Rochester, Summer 2020.

## What it does

- **Add entries** through a form with a picker and stepper (`AddVC`), including an
  optional photo (`ImageVC`).
- **Persist** everything with Core Data, listed in a custom table view (`MainTVC`
  + `MainTableViewCell`).
- **Aggregate stats** (`StatsVC`): total mileage, duration, contacts, and places,
  plus the longest single trip. If total contacts cross a threshold, the screen
  turns red and shows an alert.
- **Localized** into English and French (`en.lproj`, `fr.lproj`).

## Build & run

Open `EXPOSUREDIARY.xcodeproj` in Xcode and run on the simulator (iOS 13+).

## Notes

This repo keeps its original 12-commit history, so you can see the app come
together (`Working on Seques and VC → CoreData working → finished stats view
controller → localization → alerts`).

Cleaned up since the original submission:

- Removed three empty Xcode template leftovers (`ViewController`,
  `ActionVCViewController`, `ButtonVC`) that were unused by the storyboard.
- Hardened `StatsVC.calculateTrip()`, which force-unwrapped every Core Data
  attribute and would crash the Stats screen if any field was missing; values are
  now coerced safely.
