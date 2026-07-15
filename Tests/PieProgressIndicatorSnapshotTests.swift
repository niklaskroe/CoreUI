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
        let quarterView = PieProgressIndicatorView(progress: 0.25, themeColor: Color(red: 0.0, green: 0.5, blue: 1.0))
            .environment(\.colorScheme, .light)
        
        #if os(macOS)
        let quarterHost = NSHostingView(rootView: quarterView)
        quarterHost.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        assertSnapshot(of: quarterHost, as: .image(precision: 0.99, perceptualPrecision: 0.98), named: "mac_25_Percent")
        #else
        assertSnapshot(
            of: quarterView,
            as: .image(precision: 0.99, perceptualPrecision: 0.98, layout: .fixed(width: 100, height: 100)),
            named: "25_Percent"
        )
        #endif
        
        // 100% progress
        let fullView = PieProgressIndicatorView(progress: 1.0, themeColor: Color(red: 0.0, green: 0.8, blue: 0.0))
            .environment(\.colorScheme, .light)
        
        #if os(macOS)
        let fullHost = NSHostingView(rootView: fullView)
        fullHost.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        assertSnapshot(of: fullHost, as: .image(precision: 0.99, perceptualPrecision: 0.98), named: "mac_100_Percent")
        #else
        assertSnapshot(
            of: fullView,
            as: .image(precision: 0.99, perceptualPrecision: 0.98, layout: .fixed(width: 100, height: 100)),
            named: "100_Percent"
        )
        #endif
    }
}
