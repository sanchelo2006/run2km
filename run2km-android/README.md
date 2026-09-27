# 2 км за 11 минут — Android APK

Нативное Android-приложение на Kotlin + WebView с программой подготовки к забегу на 2 км за 11 минут.

## Быстрый старт (без Android Studio)

1. Залей папку `run2km-android` в репозиторий GitHub.
2. Workflow из `.github/workflows/build.yml` соберёт APK автоматически.
3. Скачай `app-debug.apk` из вкладки **Actions** → **Artifacts**.
4. Установи на телефон.

Подробная инструкция — в `BUILD.md`.

## Структура

```

run2km-android/
├── .github/workflows/build.yml     # CI-сборка APK в облаке
├── app/
│   ├── build.gradle.kts            # зависимости и конфиг
│   ├── proguard-rules.pro
│   └── src/main/
│       ├── AndroidManifest.xml
│       ├── assets/index.html       # всё приложение (HTML+CSS+JS)
│       ├── java/.../MainActivity.kt # WebView-хост
│       └── res/
│           ├── values/             # colors, strings, themes
│           ├── drawable/           # иконка, сплэш
│           ├── mipmap-anydpi-v26/  # adaptive icons
│           └── xml/                # backup rules
├── build.gradle.kts
├── settings.gradle.kts
├── gradle.properties
├── gradlew / gradlew.bat
└── BUILD.md                         # подробная инструкция по сборке

```

## Сборка

| Способ | Требуется | Время |
|---|---|---|
| **GitHub Actions** | Аккаунт GitHub | ~3 мин |
| **Android Studio** | Android Studio (~1 ГБ) | ~15 мин |
| **Командная строка** | JDK 17 + Android SDK | ~5 мин |

## Технологии

- **Kotlin** 1.9.24
- **Android Gradle Plugin** 8.5.2
- **minSdk** 24 (Android 7.0) — покрывает 98% устройств
- **targetSdk** 34 (Android 14)
- **WebView** с включённым JS и localStorage

## Что внутри приложения

- 📅 Программа 8 недель (32 тренировки) с отметками о выполнении
- ⏱️ Интервальный таймер со звуком и вибрацией
- 🎯 Экран забега с трекингом кругов по 400 м
- ℹ️ Справка: зоны, техника, питание, журнал тестов

## Лицензия

Свободное использование.
