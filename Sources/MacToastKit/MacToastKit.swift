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

    public enum ToastPosition {
        case topLeft(CGFloat)
        case topRight(CGFloat)
        case topCenter(CGFloat)
        case center
        case bottomLeft(CGFloat)
        case bottomRight(CGFloat)
        case bottomCenter(CGFloat)
    }

    func showToast(
        message: String,
        icon: Image? = nil,
        duration: TimeInterval? = nil,
        position: ToastPosition = .bottomCenter(100)
    ) {
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
            let x: CGFloat
            let y: CGFloat

            switch position {
            case .topLeft(let offset):
                x = screenFrame.minX + offset
                y = screenFrame.maxY - panel.frame.height - offset
            case .topCenter(let offset):
                x = screenFrame.midX - panel.frame.width / 2
                y = screenFrame.maxY - panel.frame.height - offset
            case .topRight(let offset):
                x = screenFrame.maxX - panel.frame.width - offset
                y = screenFrame.maxY - panel.frame.height - offset
            case .center:
                x = screenFrame.midX - panel.frame.width / 2
                y = screenFrame.midY - panel.frame.height / 2
            case .bottomLeft(let offset):
                x = screenFrame.minX + offset
                y = screenFrame.minY + offset
            case .bottomCenter(let offset):
                x = screenFrame.midX - panel.frame.width / 2
                y = screenFrame.minY + offset
            case .bottomRight(let offset):
                x = screenFrame.maxX - panel.frame.width - offset
                y = screenFrame.minY + offset
            }
            panel.setFrameOrigin(NSPoint(x: x, y: y))
            panel.alphaValue = 0
            panel.orderFrontRegardless()

            let displayDuration = duration ?? 3
            let animateDuration = 0.3

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
