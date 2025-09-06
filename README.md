# 📱 TaskManagerA2

A minimalist iOS task management app built with **SwiftUI** and the **MVVM architecture**.
This project was created as part of my iOS development assignment (A2), simulating a real-world app development workflow.

---

## ✨ Features

- Add, delete, and reorder personal tasks
- Optional **due date** with remaining days / overdue badge
- Task completion toggle (with strikethrough effect)
- Categories with **emoji icons** (e.g. 📚 Study, 💼 Work, 🏃 Personal)
- Priority indicator with **traffic light dot** (green = low, yellow = medium, red = high)
- Data loaded from a bundled `seed_tasks.json` file
- Unit tests and UI tests with **XCTest**

---

## 🏛 Architecture

The app follows the **MVVM (Model-View-ViewModel)** pattern:

- **Models** → `Task`, `AppError`, `TaskCategory`
- **ViewModels** → `TaskListViewModel` (manages task list state, sorting, validation)
- **Views** → `TaskRowView`, `TaskListView`, `AddTaskView`, `ContentView`
- **Utils** → `Bundle+Decode.swift` (JSON loading helper)
- **Resources** → `seed_tasks.json` (sample tasks)

---

## 🧪 Testing

The project includes both **Unit Tests** and **UI Tests**:

### ✅ Unit Tests (`TaskCoreTests`)
- `testToggleDone()` → verifies toggling task completion
- `testValidation_EmptyTitle()` → ensures empty titles throw `AppError.emptyTitle`
- `testDaysRemainingStable()` → ensures due date calculation is valid

### 🎭 UI Tests (`TaskManagerA2UITests`)
- `testAddTaskFlow()` → simulates adding a new task via the UI

Run all tests in **Xcode → Product → Test (⌘U)**.

---

## 📂 Project Structure
TaskManagerA2
├── Models/          # Data models (Task, AppError, TaskCategory)
├── Protocols/       # Protocol definitions
├── Resources/       # Seed JSON data
├── Utils/           # Utility extensions
├── ViewModels/      # TaskListViewModel
├── Views/           # SwiftUI views
├── Assets.xcassets/ # App icons & assets
├── TaskManagerA2App.swift
├── Tests/
│   ├── TaskCoreTests.swift
│   └── TaskManagerA2UITests.swift
└── README.md

---

## 📸 Screenshots

### Task List Example

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/victor-YT/TaskManagerA2.git

