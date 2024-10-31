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

class AppNotification {
    
    @Binding var dataFim: Date
    @Binding var identifier: Date
    @Binding var item: Food
    @Binding var items: [Food]
    
    
    
    init(dataFim: Binding <Date>, identifier: Binding <Date>, item: Binding <Food>, items: Binding <[Food]>) {
        self._dataFim = dataFim
        self._identifier = identifier
        self._item = item
        self._items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNotification() {
        checkForPermission { isAuthorized in
            if isAuthorized {
                self.scheduleNotificationBeforeExpiree(for: self.dataFim)
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
            print("inTarget")
        } else {
            content.categoryIdentifier = "outTarget"
            print("outTarget")
        }
        
        if secondaryType == .specific {
            content.categoryIdentifier = content.categoryIdentifier + " , specific"
            print("specific")
        } else {
            content.categoryIdentifier = content.categoryIdentifier + " , generic"
            print("generic")
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
    
    
    
    
    func scheduleNotificationBeforeExpiree(for targetDate: Date) {
        let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: targetDate)!
        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: targetDate)!
        
        checkDayInNotification(for: oneDayBefore) { type in
            if type[0] == false {
                if oneDayBefore > Calendar.current.startOfDay(for: .now) {
                    self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "O alimento \(self.item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
                }
            } else {
                if oneDayBefore > Calendar.current.startOfDay(for: .now) {
                    if type[1] == true {
                        self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
                    }
                }
            }
        }
        
        checkDayInNotification(for: targetDate) { type in
            if type[0] == false {
                self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "O alimento \(self.item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
            } else {
                if type[1] == true {
                    self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
                }
            }
        }
        
        checkDayOutTargetNotification(for: dayAfter)
    }
    
    func checkDayInNotification(for targetDate: Date, completion: @escaping ([Bool]) -> Void) {
        var typeNotification: [Bool] = [false, false] // [existe, especifico ou nao]
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    let triggerDate = trigger.dateComponents
                    if triggerDate.year == Calendar.current.component(.year, from: targetDate),
                       triggerDate.month == Calendar.current.component(.month, from: targetDate),
                       triggerDate.day == Calendar.current.component(.day, from: targetDate) {
                        if request.content.categoryIdentifier.contains("inTarget") {
                            typeNotification = [true, false]
                            if request.content.categoryIdentifier.contains("specific") {
                                typeNotification = [true, true]
                            }
                            break
                        }
                    }
                }
            }
            completion(typeNotification)
        }
    }
    
    func checkDayOutTargetNotification(for targetDate: Date) {
        var specificNotificationExist = false
        var genericNotificationExist = false
        var specificDate: Date?
        var genericDate: Date?
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                    if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                        var triggerDate = trigger.dateComponents
                        triggerDate.hour = 3
                        triggerDate.minute = 0
                        triggerDate.second = 0
                        triggerDate.timeZone = TimeZone(secondsFromGMT: 0)
                        print(Calendar.current.date(from: triggerDate)!)
                            if request.content.categoryIdentifier.contains("outTarget") {
                                if request.content.categoryIdentifier.contains("specific") {
                                    specificNotificationExist = true
                                    
                                    specificDate = Calendar.current.date(from: triggerDate)!
                                }
                                if request.content.categoryIdentifier.contains("generic") {
                                    genericNotificationExist = true
                                    genericDate = Calendar.current.date(from: triggerDate)!
                                }
                                if specificNotificationExist && genericNotificationExist {
                                    break // Interrompe o loop se ambas notificações já forem encontradas
                                }
                    }
                }
            }
            self.outNotification(specificNotificationExist: specificNotificationExist, genericNotificationExist: genericNotificationExist, dayAfter:  targetDate, specificDate: specificDate ?? Date(), genericDate: genericDate ?? Date())
        }
        
        
    }
    
    func outNotification(specificNotificationExist: Bool, genericNotificationExist: Bool, dayAfter: Date, specificDate: Date, genericDate: Date) {
        //let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: targetDate)!
        if specificNotificationExist == true {
            if specificDate <= dayAfter {
                if genericNotificationExist == true {
                    if genericDate > dayAfter {
                        self.removeNotification(for: genericDate, type: "OUT")
                        self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                    }
                } else {
                    self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                }
            } else {
                self.removeNotification(for: specificDate, type: "OUT")
                self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                if genericNotificationExist == true {
                    if genericDate > specificDate {
                        self.removeNotification(for: genericDate, type: "OUT")
                        self.dispatchNotification(for: specificDate, identifier: "\(specificDate)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                    }
                } else {
                    self.dispatchNotification(for: specificDate, identifier: "\(specificDate)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                }
            }
        } else {
            self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
        }
    }
    func updateNotification(for foods: [Food]) {
        let calendar = Calendar.current
        let dayBefore = calendar.date(byAdding: .day, value: -1, to: item.consumirAte!)!
        let dayAfter = calendar.date(byAdding: .day, value: +1, to: item.consumirAte!)!
        
        var dayBeforeNotification = [false, false]
        var sameDayNotification = [false, false]
        var nextDayNotification = [false, false]
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    let triggerDate = trigger.dateComponents
                    if triggerDate.year == Calendar.current.component(.year, from: dayBefore),
                       triggerDate.month == Calendar.current.component(.month, from: dayBefore),
                       triggerDate.day == Calendar.current.component(.day, from: dayBefore) {
                        dayBeforeNotification = [true, false]
                        if request.content.categoryIdentifier.contains("specific") {
                            dayBeforeNotification = [true, true]
                        }
                    }
                    if triggerDate.year == Calendar.current.component(.year, from: self.item.consumirAte!),
                       triggerDate.month == Calendar.current.component(.month, from: self.item.consumirAte!),
                       triggerDate.day == Calendar.current.component(.day, from: self.item.consumirAte!) {
                        sameDayNotification = [true, false]
                        if request.content.categoryIdentifier.contains("specific") {
                            sameDayNotification = [true, true]
                        }
                    }
                }
            }
            
            for request in requests {
                
            }
        }
    }
    
    func removeNotification(for itemID: Date, type: String) {
        
        let notification = "\(itemID)_\(type)"
        print("ELIMINANDO \(notification)")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification])
    }
}


//import Foundation
//import UIKit
//import UserNotifications
//import SwiftUI
//import SwiftData
//
//class AppNotification {
//    
//    @Binding var dataFim: Date
//    @Binding var identifier: Date
//    @Binding var item: Food
//    @Binding var items: [Food]
//    init(dataFim: Binding <Date>, identifier: Binding <Date>, item: Binding <Food>, items: Binding <[Food]>) {
//        self._dataFim = dataFim
//        self._identifier = identifier
//        self._item = item
//        self._items = items
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func createNotification() {
//        checkForPermission { isAuthorized in
//            if isAuthorized {
//                self.scheduleNotificationBeforeExpire(for: self.dataFim, item: self.item)
//            } else {
//                print("Notificações não permitidas.")
//            }
//        }
//    }
//    
//    func checkForPermission(completion: @escaping (Bool) -> Void) {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                completion(true)
//            case .denied:
//                completion(false)
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
//                    if let error = error {
//                        print("Erro ao solicitar permissão para notificações: \(error.localizedDescription)")
//                        completion(false)
//                    } else {
//                        completion(didAllow)
//                    }
//                }
//            default:
//                completion(false)
//            }
//        }
//    }
//    
//    func dispatchNotification(for date: Date, identifier: String, title: String, message: String, type: NotificationType, secondaryType: SecondaryNotificationType) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = message
//        
//        if type == .inTarget {
//            content.categoryIdentifier = "inTarget"
//            print("inTarget")
//        } else {
//            content.categoryIdentifier = "outTarget"
//            print("outTarget")
//        }
//        
//        if secondaryType == .specific {
//            content.categoryIdentifier = content.categoryIdentifier + ", specific"
//            print("specific")
//        } else {
//            content.categoryIdentifier = content.categoryIdentifier + ", generic"
//            print("specific")
//        }
//        
//        var triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
//        triggerDate.hour = 12
//        triggerDate.minute = 0
//        triggerDate.second = 0
//        
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: type == .inTarget ? UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false) : UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true))
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error)")
//            } else {
//                print("Notification scheduled for \(date)")
//            }
//        }
//    }
//    
//    func scheduleNotificationBeforeExpire(for targetDate: Date, item: Food) {
//        
//        let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: targetDate)!
//        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: targetDate)!
//        
//        var foodDayAfterOut: [Food] = []
//        
//        for comida in items {
//            if comida != item {
//                if comida.consumirAte! <= item.consumirAte! {
//                    foodDayAfterOut.append(comida)
//                }
//            }
//        }
//        
//        
//        checkIfItsMultipleNotification(for: oneDayBefore, foods: self.items) { types in
//            if types[0] == true {
//                if types[1] == true {
//                    self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
//                }
//            } else {
//                self.dispatchNotification(for: oneDayBefore, identifier: "\(oneDayBefore)_IN", title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//            }
//            
//            self.checkIfItsMultipleNotification(for: targetDate, foods: self.items) { types in
//                if types[0] == true {
//                    if types[1] == true {
//                        self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "Há alimentos perto do prazo de consumo armazenados 😳", type: .inTarget, secondaryType: .generic)
//                    }
//                } else {
//                    self.dispatchNotification(for: targetDate, identifier: "\(targetDate)_IN", title: "Aviso", message: "O alimento \(item.nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//                }
//                
//                self.checkIfItsMultipleNotification(for: dayAfter, foods: self.items) { types in
//                    if types[2] == true {
//                        if types[3] == true && foodDayAfterOut.count == 1 {
//                            self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
//                        }
//                    } else {
//                        self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
//                    }
//                }
//            }
//        }
//    }
//    
//    func checkIfItsMultipleNotification (for targetDate: Date, foods: [Food], completion: @escaping ([Bool]) -> Void) {
//        var inTargetType: [Bool] = [false, false] // dentro do prazo e se a notif é especifica ou generica
//        var outTargetType: [Bool] = [false, false]
//        
//       
//        var foodDayAfterOut: [Food] = []
//        
//        for comida in items {
//            if comida != item {
//                if comida.consumirAte! < item.consumirAte! {
//                    foodDayAfterOut.append(comida)
//                }
//            }
//        }
//        
//        
//        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
//            var foundInTarget = false
//            var foundOutTarget = false
//            for request in requests {
//                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
//                    let triggerDate = trigger.dateComponents
//                    if triggerDate.year == Calendar.current.component(.year, from: targetDate),
//                       triggerDate.month == Calendar.current.component(.month, from: targetDate),
//                       triggerDate.day == Calendar.current.component(.day, from: targetDate) {
//                        if request.content.categoryIdentifier.contains("inTarget"){
//                            foundInTarget = true
//                            inTargetType = [true, false]
//                            print("check inTarget")
//                            if request.content.categoryIdentifier.contains("specific") {
//                                inTargetType = [true, true]
//                                print("check inTarget specific")
//                            }
//                        }
//                        if request.content.categoryIdentifier.contains("outTarget") {
//                            foundOutTarget = true
//                            outTargetType = [true, false]
//                            print("check outTarget")
//                            if request.content.categoryIdentifier.contains("specific") {
//                                outTargetType = [true, true]
//                                print("check outTarget specific")
//                            }
//                        }
//                    }
//                }
//            }
//            if !foundInTarget {
//                //if targetDate != self.item.consumirAte {
//                    inTargetType = [false, false]
//               // }
//            }
//            if !foundOutTarget{
//                    outTargetType = [false, false]
//            }
//            if !foodDayAfterOut.isEmpty {
//                if foodDayAfterOut.count == 1 {
//                    outTargetType = [true, true]
//                } else {
//                    outTargetType = [true, false]
//                }
//            }
//            print(inTargetType + outTargetType)
//            completion(inTargetType + outTargetType)
//        }
//    }
//    
//    
//    func updateNotification(for foods: [Food]) {
//        let calendar = Calendar.current
//        let dayBefore = calendar.date(byAdding: .day, value: -1, to: item.consumirAte!)!
//        let dayAfter = calendar.date(byAdding: .day, value: +1, to: item.consumirAte!)!
//        
//        var types: [Bool] = []
//        var foodDayBeforeIn: [Food] = []
//        var foodSameDayIn: [Food] = []
//        var foodDayAfterOut: [Food] = []
//        
//        for comida in foods {
//            if comida != item {
//                if calendar.isDate(comida.consumirAte!, inSameDayAs: dayBefore) {
//                    foodDayBeforeIn.append(comida)
//                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: item.consumirAte!) {
//                    foodDayBeforeIn.append(comida)
//                    foodSameDayIn.append(comida)
//                    foodDayAfterOut.append(comida)
//                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: dayAfter) {
//                    foodSameDayIn.append(comida)
//                } else if comida.consumirAte! < item.consumirAte! {
//                    foodDayAfterOut.append(comida)
//                }
//            }
//        }
//        
//        checkIfItsMultipleNotification(for: dayBefore, foods: foods) { types in
//            
//            if types[0] == true {
//                if types[1] == true {
//                    self.removeNotification(for: dayBefore, type: "IN")
//                } else {
//                    if foodDayBeforeIn.count == 1 {
//                        self.removeNotification(for: dayBefore, type: "IN")
//                        self.dispatchNotification(for: dayBefore, identifier: "\(dayBefore)_IN", title: "Aviso", message: "O alimento \(foodDayBeforeIn[0].nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//                    }
//                }
//            }
//            
//            self.checkIfItsMultipleNotification(for: self.item.consumirAte!, foods: foods) { types in
//                if types[0] == true {
//                    if types[1] == true {
//                        self.removeNotification(for: self.item.consumirAte!, type: "IN")
//                    } else {
//                        if foodSameDayIn.count == 1 {
//                            self.removeNotification(for: self.item.consumirAte!, type: "IN")
//                            self.dispatchNotification(for: self.item.consumirAte!, identifier: "\(self.item.consumirAte)_IN", title: "Aviso", message: "O alimento \(foodSameDayIn[0].nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
//                        }
//                    }
//                }
//                
//                self.checkIfItsMultipleNotification(for: dayAfter, foods: foods) { types in
//                    if types[2] == true {
//                        if types[3] == true {
//                            self.removeNotification(for: dayAfter, type: "OUT")
//                            
//                        } else {
//                            if foodDayAfterOut.count == 1 {
//                                self.removeNotification(for: dayAfter, type: "OUT")
//                                self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_IN", title: "Aviso", message: "O alimento \(foodDayAfterOut[0].nome) está fora do prazo de consumo definido 😱", type: .inTarget, secondaryType: .specific)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func removeNotification(for itemID: Date, type: String) {
//        
//        let notification = "\(itemID)_\(type)"
////        let notificationIDTwoDays = "\(itemID)_twoDaysBefore"
////        let notificationIDOneDay = "\(itemID)_oneDayBefore"
////        let notificationIDSameDay = "\(itemID)_sameDay"
////        
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification])
//    }
//}
