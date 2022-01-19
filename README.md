# Shzzz

A "boring" Todo application that works.

## Index

- [Project Structure](#project-structure)
- [App Features](#app-features)
- [Technology](#technology)
- [Installation](#installation)
- [Upcoming Feature](#upcoming-feature)

## Project Structure

![Architecture](assets/architecture.png)

The app uses `Getx` to manage State, Navigation and Dependency Injection.

There are 3 layers to the app:
- Data layer: Provides data from local database
- Business layer: Manages CRUD interaction between the `Presentation` and `Data` layer through a `Repository` class
- Presentation layer: Presents the data and handles user interaction with the app

## App Features

- Create new todo item
- Update existing todo item
- Mark new todo item as completed
- Change app theme between Light and Dark
- Change app's language
- Display statistics such as total completed/ ongoing todos
- Show chart display trends of user's tasks
- Simple logout feature that cleans all user's data

## Technology

Flutter: 2.8.1 (channel `stable`)  
Dart: 2.15.1

## Installation

To run the app:
- Clone the app to local machine: `git clone git@github.com:nogicoder/shzzz.git`
- Make sure you are on `master` branch by `git branch`
- If not, run `git checkout master`
- Make sure you are on the project's current version of `Flutter` and `Dart`
- Run `flutter pub get`
- Connect a real device to the machine or start a simulator, make sure your device shows up when run `flutter devices`
- Run `flutter run`

To run the project tests, from the project root run `flutter test`

## Upcoming Feature

- Background image, avatar image upload with Firebase
- Mark as favorite
- Session management with Firebase
- Better documentation for scripts and tests

## Contact

For further contact and support, please contact: [bachm.biz@protonmail.vn](mailto:bachm.biz@protonmail.vn)