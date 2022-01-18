# Shzzz

Getting shzzz done, fast.

## Project Structure

![Architecture](assets/architecture.png)

The app uses `Getx` to manage State, Navigation and Dependency Injection.

There are 3 layers to the app:
- Data layer: Provides data from local DB, API in the form of `models`
- Business layer: Manages CRUD interaction between the `Presentation` and `Data` layer through a `Repository` class
- Presentation layer: Presents the data and handles user interaction with the app


## Upcoming Features

- Background image
- Mark as favorite
- Session management