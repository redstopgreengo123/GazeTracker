# GazeTracker

A production-quality Android application for eye-tracking research, capturing gaze data while participants view images.

## Features

- **Face & Eye Tracking**: MediaPipe-based face landmark detection with iris tracking
- **Quality Assessment**: Real-time tracking quality scoring and feedback
- **Privacy-First**: All processing done locally, no network transmission
- **Research-Grade**: Designed for controlled viewing studies
- **Dual Mode**: Participant (data collection) and Admin (analysis) interfaces

## Architecture

- **Clean Architecture** with MVVM presentation layer
- **Hilt** for dependency injection
- **Room** database for local storage
- **Proto DataStore** for preferences
- **CameraX** for camera capture
- **Compose UI** with Material 3

## Requirements

- Android Studio Hedgehog (2023.1.1) or newer
- Android SDK 24+ (Android 7.0)
- Target SDK 35
- Device with front-facing camera

## Setup

### 1. Clone the repository

```bash
git clone <repository-url>
cd GazeTracker
```

### 2. Download the MediaPipe model

The face landmark model is not included in the repository due to size.

```bash
./scripts/download_model.sh
```

Or manually download from:
https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task

Place in: `app/src/main/assets/face_landmarker.task`

### 3. Build and run

```bash
./gradlew assembleDebug
```

Or open in Android Studio and run directly.

## Project Structure

```
app/src/main/java/com/gazetrack/
├── data/
│   ├── camera/           # CameraX + frame analysis
│   │   ├── CameraManager.kt
│   │   ├── FrameAnalyzer.kt
│   │   └── VideoRecorder.kt
│   ├── local/
│   │   ├── db/           # Room database
│   │   │   ├── entity/   # 6 entities (Session, Stimulus, etc.)
│   │   │   └── dao/      # Data access objects
│   │   ├── datastore/    # Proto DataStore
│   │   └── repository/   # Data repositories
│   ├── security/         # Keystore encryption
│   └── tracking/         # Face detection & gaze processing
│       ├── FaceLandmarkDetector.kt
│       ├── TrackingSample.kt
│       ├── TrackingQualityScorer.kt
│       ├── GazeFilter.kt
│       └── FeatureExtractor.kt
├── di/                   # Hilt modules
├── ui/
│   ├── components/       # Reusable UI components
│   ├── navigation/       # Type-safe navigation
│   ├── screens/
│   │   ├── admin/        # Admin dashboard, settings
│   │   ├── consent/      # Participant consent
│   │   ├── modechooser/  # Mode selection
│   │   ├── participant/  # Participant home
│   │   └── tracking/     # Camera preview, calibration
│   └── theme/            # Material 3 theming
└── GazeTrackerApp.kt     # Application class
```

## Milestones

### ✅ Milestone 1: Core Architecture
- Clean Architecture + MVVM setup
- Room database with 6 entities
- Proto DataStore preferences
- Keystore security
- Navigation graph
- 6 screens (Consent, ModeChooser, Admin, Participant)

### ✅ Milestone 2: Face Tracking Infrastructure
- MediaPipe Face Landmarker integration
- CameraX preview and analysis
- Real-time tracking quality scoring
- One Euro Filter for gaze smoothing
- Feature extraction for calibration
- Camera preview screen with overlays

### ⏳ Milestone 3: Calibration (Coming Next)
- 9-point calibration procedure
- Ridge regression model
- Calibration quality assessment
- Drift checking

### ⏳ Milestone 4: Session Capture
- Image stimulus display
- Gaze data recording
- Rating collection
- Optional camera clips

### ⏳ Milestone 5: Analysis & Export
- Heatmap generation
- Fixation detection
- Session analysis viewer
- Data export (CSV, JSON)

## Tracking Quality

The app continuously assesses tracking quality:

| Status | Score | Description |
|--------|-------|-------------|
| Excellent | ≥0.8 | Optimal tracking conditions |
| Good | ≥0.5 | Acceptable for calibration |
| Poor | <0.5 | Needs adjustment |

Quality factors:
- Face detection confidence
- Eye visibility
- Head pose (yaw/pitch/roll limits)
- Stability (motion variance)
- Blink detection

## Data Storage

All data stored locally in:
- Room database: `gaze_tracker.db`
- Encrypted preferences: Proto DataStore
- Sensitive data: Android Keystore

## Testing

Run unit tests:
```bash
./gradlew test
```

Test classes:
- `TrackingQualityScorerTest`
- `FeatureExtractorTest`
- `GazeFilterTest`
- `HeadPoseTest`

## License

[License information here]

## Acknowledgments

- [MediaPipe](https://mediapipe.dev/) for face landmark detection
- [One Euro Filter](https://cristal.univ-lille.fr/~casiez/1euro/) for signal smoothing
