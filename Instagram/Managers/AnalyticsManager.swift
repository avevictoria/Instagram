//
//  AnalyticsManager.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logEvent() {
        Analytics.logEvent("", parameters: [ : ])
    }
    
}
