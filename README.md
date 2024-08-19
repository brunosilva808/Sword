# Sword
Sword Health Challenge

## Challenge

This project is a part of the Sword Health Challenge, developed using modern iOS development practices. It leverages the MVVM (Model-View-ViewModel) architecture, SwiftUI for UI building, unit tests for ensuring code reliability with a 55,2% coverage, and offline functionality using CoreData/SwiftData for data persistence managing the favourites.

## Strategy

First I used a plist to save the favourites, having later migrated to CoreData according to instructions. 
CoreData was first a Singleton but later on due to the impossobility of unit test the class, was migrated to a class with an injectable provider, being then possible to test the class. 
UI was divided in small components to better organize resposanbilities, of each one.

## Unit Tests

Unit tests were made to test the core of the app, API and CoreData 

## Notes

Some commits were made to show I can work with Git.
No external libraries were used for this challenge.
Missing stored API response in order to only make the request one time, after the app has been installed
Missing a ImageCache that could store the images as Data in CoreData and load them instead of always downloading the image
