# Shzzz

A "boring" Todo application that works.

## Index

- [Project Structure](#project-structure)
- [Technology](#technology)
- [Installation](#installation)
- [Upcoming Feature](#upcoming-feature)

## Project Structure

![Architecture](assets/architecture.png)

The app uses `Getx` to manage State, Navigation and Dependency Injection.

There are 3 layers to the app:
- Data layer: Provides data from local DB, API in the form of `models`
- Business layer: Manages CRUD interaction between the `Presentation` and `Data` layer through a `Repository` class
- Presentation layer: Presents the data and handles user interaction with the app

### Technology

Flutter: 2.8.1 (channel `stable`)
Dart: 2.15.1

### Installation

Run the app with following steps:
- Make sure you are on the correct version of `Flutter` and `Dart`
- Run `flutter pub get`
- Run `flutter run`

To run the tests, follow these steps:
- Run `flutter test`

## Upcoming Feature

- Background image, avatar image upload with Firebase
- Mark as favorite
- Session management with Firebase