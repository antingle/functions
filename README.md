# Menu Bar Calculator for macOS

A calculator that lives in your menu bar and keeps a history of your calculations

<img src="media/screenshot.png" alt="Calculator in the menu bar!" style="width: 300px">

The calculator can currently be toggled with the global shortcut `option + command + c` 

Here are the currently supported math symbols:

**constants**

```swift
pi
```

**infix operators**

```swift
+ - / * % ^
```

**prefix operators**

```swift
-
```

**functions**

```swift
// Unary functions

sqrt(x)
floor(x)
ceil(x)
round(x)
cos(x)
acos(x)
sin(x)
asin(x)
tan(x)
atan(x)
abs(x)

// Binary functions

pow(x,y)
atan2(x,y)
mod(x,y)

// Variadic functions

max(x,y,[...])
min(x,y,[...])
```

### Credits
- The [Expression](https://github.com/nicklockwood/Expression#math-symbols) framework by Nick Lockwood
- The [HotKey](https://github.com/soffes/HotKey) package by soffes

