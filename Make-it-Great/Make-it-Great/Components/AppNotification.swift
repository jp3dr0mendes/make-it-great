//
//  AppNotification.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 15/10/24.
//

import Foundation
import UIKit
import UserNotifications

class AppNotification: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification() {
        let identifier1 = "near-expired-food"
        let title1 = "Aviso"
        let body1 = "Há alimentos perto do prazo de consumo armazenados 😳"
        
        let identifier2 = "expired-food"
        let title2 = "Aviso"
        let body2 = "Há alimentos fora do prazo de consumo armazenados 😱"
        
        let hour = 12
        let minute = 0
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content1 = UNMutableNotificationContent()
        content1.title = title1
        content1.body = body1
        content1.sound = .default
        
        let content2 = UNMutableNotificationContent()
        content2.title = title2
        content2.body = body2
        content2.sound = .default
        
        let calendar = Calendar.current
        var dateComponent = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponent.hour = hour
        dateComponent.minute = minute
        
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request1 = UNNotificationRequest(identifier: identifier1, content: content1, trigger: trigger1)
        let request2 = UNNotificationRequest(identifier: identifier2, content: content2, trigger: trigger2)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier1, identifier2])
        notificationCenter.add(request1)
        notificationCenter.add(request2)
    }
}
