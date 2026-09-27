# Как собрать APK из этого проекта

Есть **три способа** — от самого простого (без установки Android Studio) до классического.

---

## Способ 1 — GitHub Actions (рекомендую, APK собирается в облаке)

Тебе **не нужен** Android Studio. Всё собирается на серверах GitHub бесплатно.

### Шаг 1. Создай аккаунт GitHub
Если его нет — зарегистрируйся на https://github.com (бесплатно, 2 минуты).

### Шаг 2. Создай новый репозиторий
1. Нажми **+** → **New repository**.
2. Имя: `run2km` (любое).
3. Тип: **Private** или **Public** — не важно.
4. **Не** ставь галочки «Add README», «Add .gitignore», «Add license».
5. Нажми **Create repository**.

### Шаг 3. Загрузи файлы проекта
На странице пустого репозитория:
1. Нажми ссылку **«uploading an existing file»**.
2. **Распакуй ZIP** с проектом `run2km-android` на компьютере.
3. Перетащи **всю папку** `run2km-android` (все файлы и подпапки) в окно браузера.
4. Внизу нажми **Commit changes**.

### Шаг 4. Добавь workflow-файл
1. В репозитории нажми **Add file** → **Create new file**.
2. Имя файла: `.github/workflows/build.yml` (обязательно с точкой в начале имени `.github`).
3. Вставь туда содержимое из файла `.github/workflows/build.yml` (см. ниже в этом проекте).
4. Нажми **Commit changes**.

### Шаг 5. Дождись сборки
1. Перейди на вкладку **Actions** вверху репозитория.
2. Увидишь запущенную сборку (жёлтый кружок → зелёная галочка через 2–3 минуты).
3. Нажми на завершённую сборку → прокрути вниз до **Artifacts**.
4. Скачай **app-debug.apk**.
5. Перекинь APK на телефон (Telegram, кабель).
6. Открой файл, разреши **«Установка из неизвестных источников»** → **Установить**.

**Готово.**

---

## Способ 2 — Android Studio (классический, нужен компьютер)

### Шаг 1. Установи Android Studio
Скачай с https://developer.android.com/studio и установи (стандартная установка, ~10 минут).

### Шаг 2. Открой проект
1. Запусти Android Studio.
2. **File → Open** → выбери папку `run2km-android`.
3. Дождись **Gradle Sync** (первый раз может занять 5–10 минут — скачивает зависимости).

### Шаг 3. Собери APK
1. Меню **Build → Build Bundle(s) / APK(s) → Build APK(s)**.
2. Дождись сообщения **«APK(s) generated successfully»**.
3. Нажми **«locate»** в появившемся уведомлении — откроется папка с APK.

Путь к APK: `run2km-android/app/build/outputs/apk/debug/app-debug.apk`

### Шаг 4. Установи на телефон
1. Перекинь APK на телефон (USB, Telegram).
2. Открой файл через файловый менеджер.
3. Разреши **«Установка из неизвестных источников»** (телефон подскажет).
4. Нажми **Установить**.

---

## Способ 3 — Командная строка (для тех, у кого есть JDK)

Требуется: **JDK 17+** и **Android SDK** (переменная `ANDROID_HOME`).

```bash
cd run2km-android
./gradlew assembleDebug
```

APK появится здесь: `app/build/outputs/apk/debug/app-debug.apk`

Для Windows:

```
cd run2km-android
gradlew.bat assembleDebug
```

---

## Что делать после установки

1. Открой приложение на телефоне — увидишь 4 вкладки.
2. **📅 Программа** — отмечай выполненные тренировки, прогресс сохраняется.
3. **⏱️ Таймер** — для интервалов (6×400, 5×800 и т.д.).
4. **🎯 Забег** — для дня старта, трекинг кругов.
5. **ℹ️ Справка** — зоны, техника, питание, тесты.

Приложение **работает полностью офлайн** — не требует интернета.

---

## Частые проблемы

**«Gradle sync failed»** — нажми «Try again» или File → Invalidate Caches → Restart.

**«SDK not found»** — в Android Studio: Tools → SDK Manager → установи Android 14 (API 34).

**«Установка заблокирована»** — Настройки → Безопасность → Установка из неизвестных источников → разреши для файлового менеджера/Telegram.

**Хочу подписанный release APK** — в Android Studio: Build → Generate Signed Bundle / APK → APK → создай новый keystore → готово.

---

## Изменение программы

Вся программа лежит в файле `app/src/main/assets/index.html` в блоке `const PROGRAM = [...]`. После правки — пересобери APK (Build → Build APK(s)).

</BDS:create_file>

<BDS:create_file fileName="run2km-android/.github/workflows/build.yml">

```yaml
name: Build APK

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - name: Setup Gradle
        uses: gradle/gradle-build-action@v3

      - name: Grant execute permission for gradlew
        run: chmod +x gradlew

      - name: Build debug APK
        run: ./gradlew assembleDebug --no-daemon

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: app-debug
          path: app/build/outputs/apk/debug/app-debug.apk
          if-no-files-found: error

