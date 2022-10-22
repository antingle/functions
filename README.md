# Functions

A calculator that lives in your macOS menu bar and keeps a history of your calculations

<div align="left">
  	<img width="300" src="media/menubar_dark.png#gh-dark-mode-only" alt="Calculator in the menu bar">
  	<img width="300" src="media/window_dark.png#gh-dark-mode-only" alt="Calculator window">
 	<img width="300" src="media/menubar_light.png#gh-light-mode-only" alt="Calculator in the menu bar">
	<img width="300" src="media/window_light.png#gh-light-mode-only" alt="Calculator window">
	<br>
</div>

## Opening

- The app is currently not signed, so simply double clicking the app will not open it
- You must right click the app and choose 'Open'
- You will then receieve a warning popup that the app cannot be checked for malicious software
- You can then choose the button to 'Open' it

## Usage

- Calculator can be accessed by pressing the `f(x)` symbol in your menu bar
- ~~The calculator can also be toggled with the global shortcut `option + command + c`~~ 
- - This is not working yet, since there is no way to currently open a MenuBarExtra programmtically.
- Calculations can be typed and submitted to history by pressing `Enter`
- History is saved even when the app is quit. It can also be cleared.
- Pprevious solutions or expressions can be added to the textfield by clicking on them
- Previous solutions can also be added by cycling through them with arrow keys or the arrow buttons
- Previous solutions can be copied to the clipboard by pressing the copy symbol to the right each submitted solution
- Typing infix operators (excluding `e` and `-`) will insert the previous answer before them for continuous calculations
- A live preview of the calculation is shown while typing an expression

### Notes

- Non-valid calculations cannot be submitted to history
- Syntax must be valid (only numbers with supported operators, functions and constants)
- Closing parentheses are added upon submission of an expression if open pairs are missing their closed counterparts

### Currently supported math symbols:

**constants**

```swift
pi or π, e
```

**infix operators**

```swift
+ - / * % ^ e
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
ln(x)
log(x) or log10(x)
log2(x)

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
- The [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) package by sindresorhus
- The [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin) package by sindresorhus

