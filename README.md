# SmartHealth HCP - Doctor App

<p align="center">
  <img src="assets/images/icon_logo.png" alt="SmartHealth Logo" width="120"/>
</p>

<p align="center">
  <strong>A comprehensive healthcare management solution for medical professionals</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#screenshots">Screenshots</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.38.2-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.10.0-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=for-the-badge" alt="Platform"/>
</p>

---

## Project Overview

**SmartHealth HCP** is a mobile application designed for Healthcare Professionals (HCPs) to streamline patient management, voucher processing, and medical consultation workflows. The app facilitates efficient diagnosis funding through extensive lab work management, enabling better treatment services for patients.

Built with Flutter for cross-platform compatibility, the app provides a seamless experience for doctors to:
- Register and manage patient information
- Process medical vouchers and services
- Complete digital consent forms with e-signatures
- Handle questionnaires for patient assessments
- Track and manage their patient list

### Key Highlights

- **Bilingual Support**: Full Arabic and English localization
- **Secure Authentication**: OTP-based verification system
- **Dynamic Configuration**: Firebase Remote Config for environment management
- **Real-time Notifications**: Push notifications for patient updates
- **QR Code Integration**: Quick voucher validation via scanning

---

## Tech Stack

### Core Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.38.2 | Cross-platform UI framework |
| Dart | 3.10.0 | Programming language |

### State Management & Architecture
| Package | Purpose |
|---------|---------|
| `provider` | State management solution |
| MVVM Pattern | Architectural design pattern |

### Backend & Cloud Services
| Service | Purpose |
|---------|---------|
| Firebase Core | Backend infrastructure |
| Firebase Messaging | Push notifications |
| Firebase Remote Config | Dynamic app configuration |

### Networking & Storage
| Package | Purpose |
|---------|---------|
| `http` | REST API communication |
| `shared_preferences` | Local data persistence |

### UI/UX Components
| Package | Purpose |
|---------|---------|
| `google_fonts` | Typography |
| `country_code_picker` | Phone number input |
| `pin_code_fields` | OTP input |
| `flutter_speed_dial` | FAB menu |
| `signature` | Digital signature capture |
| `flutter_widget_from_html_core` | HTML content rendering |

### Media & File Handling
| Package | Purpose |
|---------|---------|
| `file_picker` | Document selection |
| `image_picker` | Camera/gallery access |
| `fl_downloader` | File downloads |
| `qr_code_scanner_plus` | QR code scanning |
| `share_plus` | Content sharing |

### Utilities
| Package | Purpose |
|---------|---------|
| `permission_handler` | Runtime permissions |
| `device_info_plus` | Device information |
| `package_info_plus` | App version info |
| `url_launcher` | External links |
| `new_version_plus` | App update detection |

---

## Architecture

The application follows the **MVVM (Model-View-ViewModel)** architectural pattern, ensuring clean separation of concerns and maintainable codebase.

```
┌─────────────────────────────────────────────────────────────┐
│                        PRESENTATION                          │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                      Views                           │    │
│  │   (Screens, Widgets, UI Components)                  │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
│                           ▼                                  │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   ViewModels                         │    │
│  │   (Business Logic, State Management)                 │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                          DOMAIN                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    Models                            │    │
│  │   (Data Classes, Response Objects)                   │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                           DATA                               │
│  ┌─────────────────────────────────────────────────────┐    │
│  │               Repositories / Services                │    │
│  │   (API Calls, Local Storage, Remote Config)          │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### State Management Flow

```dart
// Provider-based state management
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
    ChangeNotifierProvider(create: (_) => PatientdetailsViewModel()),
    // ... more providers
  ],
  child: MaterialApp(...),
)
```

### Key Design Decisions

1. **Feature-based Organization**: Each feature is self-contained with its own model, view, viewmodel, and repository
2. **Centralized Constants**: All API endpoints, colors, and strings are managed centrally
3. **Dynamic Configuration**: Firebase Remote Config enables environment switching without app updates
4. **Localization-first**: Built-in support for RTL languages (Arabic)

---

## Features

### Authentication & Security
- **User Registration** - Complete doctor onboarding with speciality selection
- **Secure Login** - Phone number + password authentication
- **OTP Verification** - SMS-based account verification
- **Password Recovery** - Forgot/Reset password flow
- **Session Management** - Persistent login state

### Patient Management
- **Patient Registration** - Capture patient details (name, ID, phone, city)
- **Patient List** - View and search all registered patients
- **Patient History** - Track patient voucher and consultation history

### Voucher System
- **Project Selection** - Choose from available medical projects
- **Service Selection** - Pick specific voucher/service types
- **Voucher Generation** - Automatic serial number creation
- **QR Code Scanning** - Quick voucher validation
- **Manual Validation** - Enter serial numbers manually

### Consent & Questionnaires
- **Digital Consent Forms** - Upload or capture consent documents
- **E-Signature** - Capture digital signatures
- **Dynamic Questionnaires** - Project-specific survey questions
- **Multi-page Consent** - Support for complex consent workflows

### Additional Features
- **Push Notifications** - Real-time updates on patient status
- **File Management** - Download and share patient documents
- **Technical Support** - Request support directly from the app
- **CMS Pages** - Terms, Privacy Policy, and Cookies information
- **App Updates** - Automatic update prompts for new versions
- **Dark Mode** - System-based theme switching

---

## Testing

### Current Test Coverage

The project includes a basic widget test setup:

```dart
// test/widget_test.dart
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    // Test assertions...
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

### Recommended Testing Strategy

| Test Type | Purpose | Tools |
|-----------|---------|-------|
| Unit Tests | Test ViewModels and Services | `flutter_test` |
| Widget Tests | Test UI components | `flutter_test` |
| Integration Tests | Test complete flows | `integration_test` |
| Golden Tests | Visual regression testing | `golden_toolkit` |

---

## Folder Structure

```
lib/
├── main.dart                           # Application entry point
├── firebase_options.dart               # Firebase configuration
│
├── api_commons/                        # API utilities
│   ├── api_errors.dart                 # Error models
│   └── api_status.dart                 # Response status classes
│
├── constants/                          # App-wide constants
│   ├── api_consts.dart                 # API endpoints & base URLs
│   ├── color_consts.dart               # Theme colors
│   ├── firebase_const.dart             # Firebase messaging setup
│   ├── intent_const.dart               # Navigation intent keys
│   ├── shared_const.dart               # SharedPreferences keys
│   ├── style_consts.dart               # Text styles
│   ├── texts_consts.dart               # Static text strings
│   └── widget_consts.dart              # Common widgets
│
├── services/                           # Core services
│   └── remote_config_service.dart      # Firebase Remote Config
│
├── l10n/                               # Localization
│   ├── app_localizations.dart          # Base localization class
│   ├── app_localizations_ar.dart       # Arabic translations
│   ├── app_localizations_en.dart       # English translations
│   └── l10n.dart                       # Supported locales
│
├── LocalizationProvider/               # Language management
│   └── locale_provider.dart
│
├── Features/                           # Feature modules
│   ├── CMSPage/                        # Terms, Privacy, Cookies
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── ConsentForm/                    # Consent handling
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── ForgotPassword/                 # Password recovery
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── viewmodel/
│   │
│   ├── HomeScreen/                     # Main dashboard
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── Login/                          # Authentication
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── viewmodel/
│   │
│   ├── MyList/                         # Patient list
│   │   ├── Model/
│   │   ├── Repo/
│   │   ├── view/
│   │   └── Viewmodel/
│   │
│   ├── PatientDetails/                 # Patient registration
│   │   ├── models/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── ProjectConsent/                 # Project consent
│   │   ├── model/
│   │   ├── repo/
│   │   ├── View/
│   │   └── ViewModel/
│   │
│   ├── ProjectsAndServices/            # Project & voucher selection
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── Registration/                   # Doctor registration
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── RequestCall/                    # Technical support
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── ResetPassword/                  # Password reset
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── ThemeProvider/                  # Theme management
│   │   └── theme_provider.dart
│   │
│   ├── ValidateVoucher/                # Voucher validation
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   ├── Verificarion/                   # OTP verification
│   │   ├── model/
│   │   ├── repo/
│   │   ├── view/
│   │   └── view_model/
│   │
│   └── new_consent_upload/             # New consent uploads
│       ├── view/
│       └── view_model/
│
├── assets/
│   └── images/                         # App images and icons
│
└── test/
    └── widget_test.dart                # Widget tests
```

---

## Getting Started

### Prerequisites

- Flutter SDK (3.38.2 or higher)
- Dart SDK (3.10.0 or higher)
- Android Studio / VS Code
- Xcode (for iOS development)
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/abdalmuneim/app1-doctor.git
   cd smarthealth-hcp-doctor
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the respective platform folders
   - Or use FlutterFire CLI:
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```

4. **Set up Firebase Remote Config**

   Add the following configuration in Firebase Remote Config:
   ```json
   {
     "environment": "testing",
     "production": {
       "api_base_url_app1": "https://your-production-api.com/api"
     },
     "testing": {
       "api_base_url_app1": "https://your-staging-api.com/api"
     }
   }
   ```

5. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

6. **Run the app**
   ```bash
   # Debug mode
   flutter run

   # Release mode
   flutter run --release

   # Specific device
   flutter run -d <device_id>
   ```

### Building for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release
```

### Environment Configuration

The app supports multiple environments via Firebase Remote Config:

| Environment | Purpose | API Endpoint |
|-------------|---------|--------------|
| `testing` | Development & QA | Staging servers |
| `production` | Live app | Production servers |

---

## Future Improvements

### Planned Features

- [ ] **Offline Mode** - Cache data for offline access
- [ ] **Biometric Authentication** - Face ID / Fingerprint login
- [ ] **Video Consultations** - Agora SDK integration (partially implemented)
- [ ] **Analytics Dashboard** - Track voucher usage and patient statistics
- [ ] **Multi-language Expansion** - Add more language support (Urdu, French)
- [ ] **Document Scanner** - Built-in document scanning for consent forms

### Technical Enhancements

- [ ] **Migrate to Riverpod** - Modern state management solution
- [ ] **Add Comprehensive Tests** - Increase test coverage to 80%+
- [ ] **Implement CI/CD** - GitHub Actions for automated builds
- [ ] **Code Generation** - Use `freezed` for immutable models
- [ ] **API Layer Refactor** - Implement `dio` with interceptors
- [ ] **Error Tracking** - Integrate Sentry or Crashlytics

### Performance Optimizations

- [ ] **Image Caching** - Implement `cached_network_image`
- [ ] **Lazy Loading** - Paginate large lists
- [ ] **App Size Reduction** - Tree-shake unused assets

---

<!--
Add your screenshots here:

| Login | Home | Patient Details |
|:-----:|:----:|:---------------:|
| <img src="screenshots/login.png" width="200"/> | <img src="screenshots/home.png" width="200"/> | <img src="screenshots/patient.png" width="200"/> |

| Questionnaire | Voucher | My List |
|:-------------:|:-------:|:-------:|
| <img src="screenshots/questionnaire.png" width="200"/> | <img src="screenshots/voucher.png" width="200"/> | <img src="screenshots/mylist.png" width="200"/> |
-->

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## License

This project is proprietary software. All rights reserved.

---

## Connect With Me

<p align="center">
     
  <a href="mailto:devmnem@gmail.com">
    <img src="https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/>
  </a>
</p>

---

<p align="center">
  Made with ❤️ using Flutter
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-2.4.1-blue?style=flat-square" alt="Version"/>
  <img src="https://img.shields.io/badge/Build-22-green?style=flat-square" alt="Build"/>
</p>
