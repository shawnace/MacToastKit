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
```

# License

This project is licensed under the [MIT license](LICENSE).
