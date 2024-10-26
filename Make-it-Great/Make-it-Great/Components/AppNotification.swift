//
//  AppNotification.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 15/10/24.
//

import Foundation
import UIKit
import UserNotifications
import SwiftUI
import SwiftData

class AppNotification: UIViewController {
    
    @Binding var dataFim: Date
    @Binding var identifier: Date
    @Binding var item: Food
    
    init(dataFim: Binding <Date>, identifier: Binding <Date>, item: Binding <Food>) {
        self._dataFim = dataFim
        self._identifier = identifier
        self._item = item
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForPermission { isAuthorized in
            if isAuthorized {
                self.scheduleNotificationBeforeExpire(for: self.dataFim, item: self.item)
            } else {
                print("Notificações não permitidas.")
            }
        }
        
        
    }
    
    func checkForPermission(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
            case .denied:
                completion(false)
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if let error = error {
                        print("Erro ao solicitar permissão para notificações: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        completion(didAllow)
                    }
                }
            default:
                completion(false)
            }
        }
    }
    
    func dispatchNotification(for date: Date, identifier: String, title: String, message: String, type: NotificationType, secondaryType: SecondaryNotificationType) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        if type == .inTarget {
            content.categoryIdentifier = "inTarget"
        } else {
            content.categoryIdentifier = "outTarget"
        }
        
        if secondaryType == .specific {
            content.categoryIdentifier = content.categoryIdentifier + ", specific"
        } else {
            content.categoryIdentifier = content.categoryIdentifier + ", generic"
        }
        
        var triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        triggerDate.hour = 12
        triggerDate.minute = 0
        triggerDate.second = 0
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: type == .inTarget ? UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false) : UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true))
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(date)")
            }
        }
    }
    
    func scheduleNotificationBeforeExpire(for targetDate: Date, item: Food) {
        
        let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: targetDate)!
        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: targetDate)!
        
        checkIfItsMultipleNotification(for: oneDayBefore) { types in
            if types[0] == true {
                self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
            } else {
                self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
            }
            
            self.checkIfItsMultipleNotification(for: targetDate) { types in
                if types[0] == true {
                    self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
                } else {
                    self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
                }
                
                self.checkIfItsMultipleNotification(for: dayAfter) { types in
                    if types[2] == true {
                        self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                    } else {
                        self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                    }
                }
            }
        }
        
//        types = checkIfItsMultipleNotification(for: oneDayBefore)
//        
//        if types[0] == true {
//                dispatchNotification(for: oneDayBefore, identifier: notificationIDOneDay, title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
//        } else {
//            dispatchNotification(for: oneDayBefore, identifier: notificationIDOneDay, title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//        }
//        
//        types = checkIfItsMultipleNotification(for: targetDate)
//        
//        if types[0] == true {
//            dispatchNotification(for: targetDate, identifier: notificationIDSameDay, title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
//        } else {
//            dispatchNotification(for: targetDate, identifier: notificationIDSameDay, title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//        }
//        
//        types = checkIfItsMultipleNotification(for: dayAfter)
//        
//        if types[2] == true {
//            dispatchNotification(for: dayAfter, identifier: notificationOutOfTarget, title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
//        } else {
//            dispatchNotification(for: dayAfter, identifier: notificationOutOfTarget, title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
//        }
    }
    
//    func checkIfItHasNotification(for targetDate: Date) -> Bool {
//        var existingNotification: UNNotificationRequest?
//        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
//            for request in requests {
//                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
//                    let triggerDate = trigger.dateComponents
//                    if triggerDate.year == Calendar.current.component(.year, from: targetDate),
//                       triggerDate.month == Calendar.current.component(.month, from: targetDate),
//                       triggerDate.day == Calendar.current.component(.day, from: targetDate) {
//                        existingNotification = request
//                    }
//                }
//            }
//        }
//        return existingNotification != nil ? true : false
//    }
    
    func checkIfItsMultipleNotification (for targetDate: Date, completion: @escaping ([Bool]) -> Void) {
        var inTargetType: [Bool] = [false, false] // dentro do prazo e se a notif é especifica ou generica
        var outTargetType: [Bool] = [false, false]
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    let triggerDate = trigger.dateComponents
                    if triggerDate.year == Calendar.current.component(.year, from: targetDate),
                       triggerDate.month == Calendar.current.component(.month, from: targetDate),
                       triggerDate.day == Calendar.current.component(.day, from: targetDate) {
                        if request.content.categoryIdentifier.contains("inTarget") {
                            inTargetType = [true, false]
                            if request.content.categoryIdentifier.contains("specific") {
                                inTargetType = [true, true]
                            }
                        }
                        if request.content.categoryIdentifier.contains("outTarget") {
                            outTargetType = [true, false]
                            if request.content.categoryIdentifier.contains("specific") {
                                outTargetType = [true, true]
                            }
                        }
                    }
                }
            }
        }
        
        completion(inTargetType + outTargetType)

    }
    
    func updateNotification(for food: Food, foods: [Food]) {
        let calendar = Calendar.current
        let dayBefore = calendar.date(byAdding: .day, value: -1, to: food.consumirAte!)!
        let dayAfter = calendar.date(byAdding: .day, value: +1, to: food.consumirAte!)!
        
        var types: [Bool] = []
        var foodDayBeforeIn: [Food] = []
        var foodSameDayIn: [Food] = []
        var foodDayAfterOut: [Food] = []
        
        for comida in foods {
            if comida != food {
                if calendar.isDate(comida.consumirAte!, inSameDayAs: dayBefore) {
                    foodDayBeforeIn.append(comida)
                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: food.consumirAte!) {
                    foodDayBeforeIn.append(comida)
                    foodSameDayIn.append(comida)
                    foodDayAfterOut.append(comida)
                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: dayAfter) {
                    foodSameDayIn.append(comida)
                } else if comida.consumirAte! < food.consumirAte! {
                    foodDayAfterOut.append(comida)
                }
            }
        }
        
        checkIfItsMultipleNotification(for: dayBefore) { types in
            
            if types[0] == true {
                if types[1] == true {
                    self.removeNotification(for: dayBefore, type: "IN")
                } else {
                    if foodDayBeforeIn.count == 1 {
                        self.removeNotification(for: dayBefore, type: "IN")
                        self.dispatchNotification(for: dayBefore, identifier: "\(dayBefore)_IN", title: "Aviso", message: "O alimento \(foodDayBeforeIn[0].nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
                    }
                }
            }
            
            self.checkIfItsMultipleNotification(for: food.consumirAte!) { types in
                if types[0] == true {
                    if types[1] == true {
                        self.removeNotification(for: food.consumirAte!, type: "IN")
                    } else {
                        if foodSameDayIn.count == 1 {
                            self.removeNotification(for: food.consumirAte!, type: "IN")
                            self.dispatchNotification(for: food.consumirAte!, identifier: "\(food.consumirAte)_IN", title: "Aviso", message: "O alimento \(foodSameDayIn[0].nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
                        }
                    }
                }
                
                self.checkIfItsMultipleNotification(for: dayAfter) { types in
                    if types[2] == true {
                        if types[3] == true {
                            self.removeNotification(for: dayAfter, type: "OUT")
                            
                        } else {
                            if foodDayAfterOut.count == 1 {
                                self.removeNotification(for: dayAfter, type: "OUT")
                                self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_IN", title: "Aviso", message: "O alimento \(foodDayAfterOut[0].nome) está fora do prazo de consumo definido 😱", type: .inTarget, secondaryType: .specific)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func removeNotification(for itemID: Date, type: String) {
        
        let notification = "\(itemID)_\(type)"
//        let notificationIDTwoDays = "\(itemID)_twoDaysBefore"
//        let notificationIDOneDay = "\(itemID)_oneDayBefore"
//        let notificationIDSameDay = "\(itemID)_sameDay"
//        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification])
    }
}
