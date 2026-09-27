# Оставляем WebView и JS-интерфейсы нетронутыми
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keep class com.betterdeepseek.run2km.** { *; }
