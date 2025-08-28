# MacToastKit

<img src="/Assets/Screenshots/MacToastKit-1.webp" width="100%" alt="MacToastKit"/>

MacToastKit provides an easy and minimal way to include toast messages in your mac app. It focuses on giving developers an easy way to provide visual feedback to users with minimal effort.

## Install

Compatibility: **macOS 13+**

Add `https://github.com/daniyalmaster693/MacToastKit` in the [“Swift Package Manager” tab in Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Usage

Call the showToast() function when you want to display a message. That's it.

```swift
import SwiftUI
import MacToastKit

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Button("Delete task") {
                let toast = ToastWindowController()

                  toast.showToast(
                    message: "Deleted Task",
                    icon: Image(systemName: "trash.fill"),
                    duration: 3,
                    position: .bottomCenter(100)
                )
            }
        }
    }
}
```

The showToast function supports parameters to control what it displays.

- message: A string that describes the purpose of the toast
- icon: An optional icon that displays with the text
- duration: An optional double value that controls how long the toast will be visible
- position: Controls the position of the toast on the user's screen, with an offset parameter

### Template Toasts

You can create template toasts for messages that are repeatedly used throughout your app.

```swift
import SwiftUI
import MacToastKit

func showSuccessToast(_ message: String = "Action Completed", icon: Image? = nil) {
    DispatchQueue.main.async {
        let toast = ToastWindowController()
        toast.showToast(
            message: message,
            icon: icon ?? Image(systemName: "checkmark.circle.fill")
        )
    }
}

func showErrorToast(_ message: String = "Action Failed", icon: Image? = nil) {
    DispatchQueue.main.async {
        let toast = ToastWindowController()
        toast.showToast(
            message: message,
            icon: icon ?? Image(systemName: "x.circle.fill")
        )
    }
}

```

## Example Projects

- [**SuperCorners**](https://github.com/daniyalmaster693/SuperCorners)

# License

This project is licensed under the [MIT license](LICENSE).
