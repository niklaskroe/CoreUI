import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoreUI
#if os(macOS)
import AppKit
#endif

@MainActor
final class PieProgressIndicatorViewSnapshotTests: XCTestCase {
    private func assertPieProgressSnapshot(
        _ view: some View,
        named name: String,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        #if os(macOS)
        let host = NSHostingView(rootView: view)
        host.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        assertSnapshot(of: host, as: .image(precision: 0.99, perceptualPrecision: 0.98), named: "mac_\(name)", file: file, testName: testName, line: line)
        #else
        assertSnapshot(
            of: view,
            as: .image(precision: 0.99, perceptualPrecision: 0.98, layout: .fixed(width: 100, height: 100)),
            named: name,
            file: file,
            testName: testName,
            line: line
        )
        #endif
    }
    
    func testPieProgressIndicator_atVariousStates() {
        // 25% progress
        let quarterView = PieProgressIndicatorView(progress: 0.25, themeColor: Color(red: 0.0, green: 0.5, blue: 1.0))
        
        assertPieProgressSnapshot(quarterView.environment(\.colorScheme, .light), named: "25_Percent_light")
        assertPieProgressSnapshot(quarterView.environment(\.colorScheme, .dark), named: "25_Percent_dark")
        
        // 100% progress
        let fullView = PieProgressIndicatorView(progress: 1.0, themeColor: Color(red: 0.0, green: 0.8, blue: 0.0))
        
        assertPieProgressSnapshot(fullView.environment(\.colorScheme, .light), named: "100_Percent_light")
        assertPieProgressSnapshot(fullView.environment(\.colorScheme, .dark), named: "100_Percent_dark")
    }
}
