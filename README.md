# 021 Trade App - Flutter Trading Assignment

A production-grade, high-performance mock trading application built with Flutter, adhering to strict
clean architecture principles, state management via Flutter Bloc, and real-time data streaming.

---

## 🚀 Features Implemented

* **Feature 1: Multi-Watchlists:** Create, rename, delete, reorder (via drag-and-drop), and manage
  multiple watchlists with real-time stock price integration and persistent local storage.
* **Feature 2: Live Market Overview:** High-performance mock market-data feed streaming live ticks
  for 10 core stocks (`RELIANCE`, `TCS`, `INFY`, `HDFCBANK`, `ICICIBANK`, `SBIN`, `ITC`, `LT`,
  `BHARTIARTL`, `AXISBANK`) with visual flash feedback (green up / red down) and optimized cell
  rendering to prevent UI jank.
* **Feature 3: Simulated Buy/Sell Ticket:** Interactive order execution sheet with pre-filled
  contexts, live price updates, strict margin/balance validations, floating-point precision
  handling, and persistent wallet/order histories.
* **Feature 4: Portfolio Holdings & Live P&L:** Real-time portfolio tracking showing individual
  holdings, dynamic aggregate summaries (Total Invested, Current Value, and Total P&L in ₹ and %),
  customizable sorting options (by P&L, symbol, and current value), and direct tap-to-trade
  functionality.

---

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter (3.35.3 • Stable channel)
* **State Management:** `flutter_bloc` / `bloc`
* **Local Storage:** `shared_preferences` (for watchlists, portfolio holdings, and wallet states)
* **Architecture:** Feature-driven clean architecture separating Data (services & repositories),
  Domain/State (BLoC), and Presentation (screens & widgets).

---

## ⚙️ Getting Started & Run Instructions

Ensure you have the Flutter SDK installed on your machine (stable channel recommended).

1. **Clone the Repository:**

```bash
git clone <your-public-github-repo-url>
cd trade_app

```

2. **Install Dependencies:**

```bash
flutter pub get

```

3. **Run the Application:**

```bash
flutter run

```

---

## 📱 Walkthrough Video

A short walkthrough video demonstrating all features end-to-end has been attached to the final
submission.
