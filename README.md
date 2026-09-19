# FinTrack

**The Smart Companion for Personal Finance Management**

## Overview
**FinTrack** is a comprehensive ecosystem designed to give you complete, intelligent control over your finances. Through a modern and intuitive interface, the application delivers a seamless, professional experience for tracking expenses, managing multiple accounts, and precisely monitoring monthly budgets. Built with a strict focus on data privacy, the app operates entirely offline.

---

## Key Features

### 📊 Smart Dashboard
Gain a holistic view of your financial health in seconds. The dashboard intelligently summarizes your current total balance, provides visual progress indicators for your active budgets, and lists your latest transactions so you are always up to date.

### 💳 Comprehensive Account Management
Whether it is cash, bank accounts, or credit cards, manage them all in one unified place. Track individual balances and review detailed transaction histories for each account independently and systematically.

### 📈 Accurate Budgets & Reports
Set financial goals and allocate custom monthly budgets for various categories like shopping, transportation, and utilities. Visual progress bars help you stay within your limits, while interactive charts offer clear insights into your weekly spending habits.

### ⚡ Seamless & Fast Transactions
Logging your expenses, income, or transfers is faster than ever. With an elegant, focused data entry interface, you can effortlessly categorize your spending and track the flow of your money with precision.

---

## Performance & Privacy First

- **Total Privacy (Offline-First)**: Your financial data is strictly yours. FinTrack securely stores all your information locally on your personal device.
- **Exceptional Performance**: Built with cutting-edge technologies and Clean Architecture, ensuring instant responsiveness and a flawless user experience.
- **Professional Design**: A meticulously crafted user interface designed for visual comfort, featuring full RTL support and perfect typography tailored for heavy daily use.

---

## Tech Stack

- **Framework**: Flutter
- **Database**: Drift (SQLite) with Reactive Streams
- **State Management**: BLoC + Equatable
- **Routing**: GoRouter
- **Dependency Injection**: GetIt + Injectable
- **Charts**: fl_chart

---

## Architecture

The project relies on **Clean Architecture** combined with a **Feature-first** organizational approach, ensuring high scalability and easy maintenance:

```text
lib/
├── core/                          # Shared Utilities
│   ├── application/               # Themes, Colors, and Text Styles
│   ├── database/                  # Database Configuration and Core Tables
│   ├── data/                      # Shared DAOs and Repositories
│   ├── domain/                    # Shared Models and Use Cases
│   └── presentaion/               # Shared UI Components
│
├── features/                      # Isolated Features
│   ├── home/                      # Main Dashboard
│   ├── accounts/                  # Account Management
│   ├── budgets/                   # Monthly Budgets
│   ├── reports/                   # Reports and Charts
│   ├── main/                      # Shell Screen and Bottom Navigation
│   └── splash/                    # Splash Screen
│
├── l10n/                          # Localization Files
├── routes/                        # Navigation Configuration (GoRouter)
└── main.dart                      # Application Entry Point
```

Every feature within the system adheres to the following internal structure to ensure strict Separation of Concerns:
```text
feature/
├── data/          # Repository Implementations and DAOs
├── domain/        # Repository Interfaces, Models, and Use Cases
└── presentaion/   # Screens, Widgets, and State Management (BLoC)
```

---

## 🚀 Getting Started

To run the project in your local environment, follow these steps:

```bash
# 1. Fetch dependencies
flutter pub get

# 2. Generate boilerplate code (Required for Drift and Injectable)
dart run build_runner build --delete-conflicting-outputs

# 3. Run the application
flutter run
```
