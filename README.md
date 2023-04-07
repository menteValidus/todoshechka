# todoshechka iOS

This is a Todo application built with Swift, SwiftUI, CoreData, and R.swift. The app uses the MVVM+C architecture pattern, with a coordinator built from scratch to suit the project's specific needs.

## Dependencies Injection

The app utilizes a self-written dependency injection solution instead of relying on third-party frameworks like [Swinject](https://github.com/Swinject/Swinject), [Needle](https://github.com/uber/needle), or [Factory](https://github.com/hmlongco/Factory). This decision was made because existing frameworks did not provide the required compile-safety and provided too much of needless for project logic.

The Factory framework compile-safety was used as a base reference, and the final product works as follows: `Container.shared.dependency`.

## Unit Testing

The main logic of the app is covered with unit tests, and UI tests have been replaced with `ViewModel` unit tests. This was achieved by adding the `Presenter` responsibility to `ViewModel`.

Instead of presenting data in views, data is prepared in the `ViewModel`. e.g. instead of passing `Date` objects - they are already formatted as `String`, instead of passing whole data structs - special structs with only required data for views is passed, etc.

## Installation

To install the app, simply clone this repository and open the project in Xcode. From there, you can run the app on a simulator or a physical device.

## Contributing

If you want to contribute to the project, feel free to fork this repository and make a pull request. Any contributions are welcome, including bug fixes, feature additions, and documentation improvements.

## License

This project is licensed under the MIT License. Feel free to use this code for any purpose.
