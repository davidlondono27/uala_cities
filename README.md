# uala_cities iOS

## Requirements
Xcode 16.3

### For Testing purposes
Ruby 3.3.8.
Bundler 2.2.33.

# Uala Cities iOS App

## Overview

Uala Cities is an iOS application built with Swift and SwiftUI, designed to help you explore and manage your favorite cities easily. It displays city information and locations interactively using maps.

## Project Requirements

* **Xcode**: Version 16.3 or later

### For Testing

* **Ruby**: Version 3.3.8
* **Bundler**: Version 2.2.33

## Architecture

The project follows a clean and simple architecture:

* **Domain Driven Design (DDD)**: Keeps business logic independent and organized.
* **MVVM (Model-View-ViewModel)**: Clearly separates data handling, app logic, and user interface.

## Features and Tools

* **SwiftUI**: Used to build interactive and responsive user interfaces.
* **Snapshot Testing**: Ensures UI consistency and stability.
* **Swift Package Manager (SPM)**: Manages multiple modules within the app for better organization.
* **Fastlane**: Automates tests and makes continuous integration (CI) easier.
* **GitFlow**: Structured branching strategy that clearly organizes features, development, and releases.
* **Conventional Commits**: Standardized commit messages to improve project history clarity.

## How to Run

1. Clone the repository.
2. Open the project with Xcode 16.3 or newer.
3. Select a simulator or physical device.
4. Run the app.

## Running Tests

To run tests locally:

```bash
bundle install
bundle exec fastlane ios tests
```

This will execute all Snapshot tests to verify the UI.
