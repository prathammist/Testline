Kindly refer to the [Google Drive link](https://drive.google.com/drive/folders/1UDaI8kAzwYDs0BdxYMK6umG73e0rhl06?usp=sharing) for the video demonstration and the release APK.

---


# Quiz Game App

The **Quiz Game App** is a cross-platform mobile application built with **Flutter** for both **Android** and **iOS**. This gamified quiz app offers an engaging experience where users answer multiple-choice questions within a time limit. The app tracks the user's performance, shows results, and provides feedback on incorrect answers.

---
<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/user-attachments/assets/b57731f5-4d23-4ba6-9f83-6616ccd28aa9" style="width: 200px; margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/7570abd8-95f4-41a9-8d7d-fa9ee9ecc435" style="width: 200px; margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/e168dd11-6511-4bbf-9fb4-edb7dcf3b38d" style="width: 200px; margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/08d0eb80-b748-462c-8b6a-43d07ee864a7" style="width: 200px; margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/34b9385a-162f-4389-8b0f-b216527df88c" style="width: 200px; margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/2a84deb7-a9e8-48b6-a171-7d9c90cecae7" style="width: 200px; margin: 10px;" />
</div>


## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Installation](#installation)
5. [Folder Structure](#folder-structure)
6. [App Overview](#app-overview)
7. [Code Explanation](#code-explanation)
8. [Contributing](#contributing)
9. [License](#license)

---

## Introduction

The **Quiz Game App** is an interactive and gamified quiz application that runs on both **Android** and **iOS**. Users are presented with multiple-choice questions, and they have **60 seconds** to select the correct answer for each question. If the answer is correct, the option is highlighted in **green**, and if incorrect, it turns **red**. If the user fails to answer in time, the next question is automatically shown.

Upon completing the quiz, the **Result Screen** displays important performance metrics, such as:
- Correct answers
- Incorrect answers
- Accuracy score
- Performance overview
Additionally, the app shows a comparison of **wrong answers** with the **correct answers** for each question.

---

## Features

- **Interactive Quiz Interface**: Users can answer multiple-choice questions in a fun and engaging way.
- **Timer for Each Question**: Each question comes with a **60-second timer**. If the user doesn't answer within the time limit, the next question automatically appears.
- **Gamified Answer Feedback**: Correct answers are highlighted in **green**, while incorrect answers turn **red**.
- **Performance Metrics**: After completing the quiz, users are shown performance statistics like accuracy, correct answers, wrong answers, and more.
- **Correct vs. Wrong Answers Comparison**: Users can review the questions they answered incorrectly and see the correct answers.
- **Platform Compatibility**: Available on both **Android** and **iOS**, ensuring a smooth experience across devices.

---

## Tech Stack

- **Flutter**: The framework for building cross-platform mobile apps (Android & iOS).
- **Dart**: The programming language used to develop the app.
- **Android & iOS**: The app is designed to run seamlessly on both platforms.

---

## Installation

Follow these steps to set up the Quiz Game app locally on your machine:

### Prerequisites

Ensure you have the following installed:
- **Flutter SDK**: [Flutter Install Guide](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (comes bundled with Flutter)
- **Android Studio** or **Visual Studio Code** (with Flutter and Dart plugins)
- **Xcode** (for iOS development on macOS)

### Steps to Install

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/quiz_game_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd quiz_game_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on an Android or iOS emulator or a physical device:
   ```bash
   flutter run
   ```

---

## Folder Structure

Here’s an overview of the folder structure of the project:

```
quiz_game_app/
├── android/                # Android-specific configurations and code
├── ios/                    # iOS-specific configurations and code
├── lib/                    # Flutter app's source code
│   ├── constant/           # Constants (colors, app configuration)
│   ├── model/              # Models (Quiz, Question, Option)
│   ├── presentation/       # Screens (QuizScreen, ResultScreen)
│   ├── main.dart           # Entry point of the application
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Flutter project configuration (dependencies)
├── pubspec.lock             # Locked versions of dependencies
└── README.md                # Project documentation (this file)
```

---

## App Overview

### 1. **QuizScreen**
The main screen where users interact with the quiz. It displays:
- The current question and answer choices.
- A countdown timer for each question (60 seconds).
- Real-time selection of answers.

**Key Functions:**
- `startTimer`: Starts the countdown for each question.
- `moveToNextQuestion`: Automatically moves to the next question after the timer ends or when the user selects an answer.
- `optionSelected`: Updates the UI to highlight the selected answer with green (correct) or red (incorrect).

### 2. **ResultScreen**
This screen is shown once the user has answered all the questions:
- Displays the answers selected by the user.
- Highlights correct and incorrect answers.
- Shows performance metrics like the total score, accuracy, and a comparison between the correct and incorrect answers.

---

## Code Explanation

### Main Components:
- **QuizScreen**: Displays the questions and options. It manages the countdown timer and tracks user selection.
- **ResultScreen**: Shows the performance overview after completing the quiz. The screen includes the user's answers, correct answers, and overall performance.

### Key Variables and Logic:
- **selectedAnswers**: A map that stores the user's selected answers for each question.
- **correctAnswers**: A map that stores the correct answers for each question.
- **currentQuestionIndex**: Keeps track of the current question being displayed.
- **remainingTime**: Holds the remaining time for each question (starts from 60 seconds).
- **optionSelected**: Tracks the selected option for the current question and updates the UI to indicate correctness.

### Timer Implementation:
- A `Timer` is used to update the countdown every second.
- Once the timer reaches zero, the quiz automatically proceeds to the next question.
- If the user selects an answer before the timer runs out, the selected answer is immediately evaluated.

### UI Design:
- **Material Design** is used to create a clean and simple interface.
- The app dynamically updates based on user interaction and the countdown timer.
- Visual feedback (color change) is provided when users select answers, helping them understand whether they answered correctly or incorrectly.

---

## Contributing

We welcome contributions to improve this quiz game app. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Make your changes and commit them (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request to merge the changes.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This README provides a comprehensive guide for understanding, setting up, and contributing to the **Quiz Game App**. Enjoy building and enhancing the app!

