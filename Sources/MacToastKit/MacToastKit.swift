//
//  MacToastKit.swift
//  MacToastKit
//
//  Created by Daniyal Master on 2025-08-28.
//

import AppKit
import SwiftUI

@MainActor
class ToastWindowController {
    private var panel: NSPanel?
    private var timer: Timer?

    func showToast(message: String, icon: Image? = nil, duration: TimeInterval? = nil, animationDuration: TimeInterval? = nil) {
        if panel == nil {
            let toastView = ToastView(message: message, icon: icon, panel: nil)

            let hostingView = NSHostingView(rootView: toastView)
            hostingView.frame = NSRect(x: 0, y: 0, width: 300, height: 50)

            panel = NSPanel(contentRect: hostingView.frame,
                            styleMask: [.nonactivatingPanel],
                            backing: .buffered,
                            defer: false)

            if let panel = panel {
                panel.contentView = hostingView
                panel.isFloatingPanel = true
                panel.level = .floating
                panel.backgroundColor = .clear
                panel.isOpaque = false
                panel.hasShadow = true
                panel.ignoresMouseEvents = false
                panel.hidesOnDeactivate = false
                panel.collectionBehavior = [.canJoinAllSpaces, .transient, .ignoresCycle]

                hostingView.rootView = ToastView(message: message, icon: icon, panel: panel)
            }
        }

        if let screenFrame = NSScreen.main?.visibleFrame, let panel = panel {
            let x = screenFrame.midX - panel.frame.width / 2
            let y = screenFrame.minY + 100
            panel.setFrameOrigin(NSPoint(x: x, y: y))
            panel.alphaValue = 0
            panel.orderFrontRegardless()

            let displayDuration = duration ?? 3
            let animateDuration = animationDuration ?? 0.3

            NSAnimationContext.runAnimationGroup({ context in
                context.duration = animateDuration
                context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                panel.animator().alphaValue = 1
            }, completionHandler: {
                DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
                    NSAnimationContext.runAnimationGroup({ context in
                        context.duration = animateDuration
                        context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                        panel.animator().alphaValue = 0
                    }, completionHandler: {
                        panel.orderOut(nil)
                    })
                }
            })
        }
    }
}
