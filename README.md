# 📱 TaskManagerA2

A minimalist iOS task management app built with **SwiftUI** and the **MVVM architecture**.
This project was created as part of my iOS development assignment, simulating a real-world app development workflow.

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
- `testAddTaskSuccessIncreasesCount()` → verifies that successfully adding a task increases the task list count
- `testOverdueDaysNegative()` → ensures that overdue tasks report negative remaining days

### 🎭 UI Tests (`TaskManagerA2UITests`)
- `testAddTaskFlow()` → simulates adding a new task via the UI and checks that it appears in the list

Run all tests in **Xcode → Product → Test (⌘U)**.

---

## 📸 Screenshots


---

## 🚀 Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/victor-YT/TaskManagerA2.git

2. Open in Xcode:
    open TaskManagerA2.xcodeproj
