# 📚 Bookstore App

A modern Flutter-based bookstore application that provides users with a smooth experience for browsing books, viewing details, managing a shopping cart, and submitting orders.

The project focuses on clean UI design, reusable components, state management, and structured application architecture.

---

## ✨ Features

* 🔐 Welcome page with user input validation
* 📖 Browse available books in a responsive grid layout
* 🔎 View detailed information about each book
* 🛒 Add books to the shopping cart
* ➕ Increase, decrease, and remove cart items
* 💰 Automatic total price calculation
* 📝 Order submission with customer information validation
* ℹ️ About page with store information and contact details
* 🌙 Dark-themed Persian RTL user interface
* 🎨 Custom styling using shared theme constants

---

## 🛠️ Technologies

* **Flutter**
* **Dart**
* **Material Design 3**
* **Stateful & Stateless Widgets**
* **Form Validation**
* **Singleton Design Pattern**

---

## 🏗️ Project Structure

```
lib/
│
├── models/
│   └── books.dart
│       # Book data model and sample book data
│
├── screens/
│   ├── welcome_page.dart
│   │   # User welcome and login validation screen
│   │
│   ├── home_page.dart
│   │   # Main bookstore catalog screen
│   │
│   ├── book_detail_page.dart
│   │   # Book information and cart interaction
│   │
│   ├── order_page.dart
│   │   # Shopping cart and order submission
│   │
│   └── about_page.dart
│       # Store information page
│
├── services/
│   └── cart.dart
│       # Shopping cart business logic
│
├── utilities/
│   └── constants.dart
│       # Shared colors, styles, and UI constants
│
└── main.dart
    # Application entry point
```

---

## 🧩 Architecture

The project follows a simple layered structure:

```
Presentation Layer
        |
        ├── Screens
        └── UI Components

Data Layer
        |
        └── Book Model

Business Logic Layer
        |
        └── Cart Service

Shared Resources
        |
        └── Constants & Theme Styles
```

This separation keeps UI code organized and makes the application easier to maintain and extend.

---

## 🛒 Shopping Cart Implementation

The cart system is implemented using the **Singleton Pattern** to provide a single shared cart instance across different screens.

Supported operations:

* Add items
* Remove items
* Update quantities
* Calculate total items
* Calculate total price
* Clear cart after successful order

---

## 📱 Demo & Screenshots

### 🎬 Application Demo

<p align="center">
  <img src="assets/screenshots/demo.gif" width="300"/>
</p>

### 📸 App Screenshots

<p align="center">
  <img src="assets/screenshots/Screenshot_01.png" width="250"/>
  <img src="assets/screenshots/Screenshot_02.png" width="250"/>
  <img src="assets/screenshots/Screenshot_03.png" width="250"/>
</p>

<p align="center">
  <img src="assets/screenshots/Screenshot_04.png" width="250"/>
  <img src="assets/screenshots/Screenshot_05.png" width="250"/>
  <img src="assets/screenshots/Screenshot_06.png" width="250"/>
</p>

<p align="center">
  <img src="assets/screenshots/Screenshot_07.png" width="250"/>
  <img src="assets/screenshots/Screenshot_08.png" width="250"/>
</p>

---

## 🚀 Getting Started

### Prerequisites

Make sure you have Flutter installed:

```bash
flutter --version
```

### Installation

Clone the repository:

```bash
git clone <repository-url>
```

Navigate to the project directory:

```bash
cd bookstore_app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

