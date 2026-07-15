import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoreUI
#if os(macOS)
import AppKit
#endif

@MainActor
final class PieProgressIndicatorSnapshotTests: XCTestCase {
    
    func testPieProgressIndicator_atVariousStates() {
        // 25% progress
        let quarterView = PieProgressIndicatorView(progress: 0.25, themeColor: .blue)
        
        #if os(macOS)
        let quarterHost = NSHostingView(rootView: quarterView)
        quarterHost.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        assertSnapshot(of: quarterHost, as: .image, named: "mac_25_Percent")
        #else
        assertSnapshot(
            of: quarterView,
            as: .image(layout: .fixed(width: 100, height: 100)),
            named: "25_Percent"
        )
        #endif
        
        // 100% progress
        let fullView = PieProgressIndicatorView(progress: 1.0, themeColor: .green)
        
        #if os(macOS)
        let fullHost = NSHostingView(rootView: fullView)
        fullHost.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        assertSnapshot(of: fullHost, as: .image, named: "mac_100_Percent")
        #else
        assertSnapshot(
            of: fullView,
            as: .image(layout: .fixed(width: 100, height: 100)),
            named: "100_Percent"
        )
        #endif
    }
}
