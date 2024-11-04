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
            if genericNotificationExist == false {
                self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
            } else {
                if dayAfter < genericDate {
                    self.dispatchNotification(for: dayAfter, identifier: "\(dayAfter)_OUT", title: "Aviso", message: "O alimento \(item.nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                }
            }
        }
    }
    func updateNotification(for foods: [Food]) {
        let calendar = Calendar.current
        let dayBefore = calendar.date(byAdding: .day, value: -1, to: item.consumirAte!)!
        let dayAfter = calendar.date(byAdding: .day, value: +1, to: item.consumirAte!)!
        let sameDay = calendar.date(byAdding: .day, value: 0, to: item.consumirAte!)!
    
        
        var nextDayNotificationSpecific = false
        var nextDayNotificationGeneric = false
        var specificDate: Date?
        var genericDate: Date?
        
        var foodDayBeforeIn: [Food] = []
        var foodSameDayIn: [Food] = []
        var foodDayAfterOut: [Food] = []
        var foodDatesAfterOut: [Date] = []
        
        for comida in foods {
            if comida != item {
                if calendar.isDate(comida.consumirAte!, inSameDayAs: dayBefore) {
                    foodDayBeforeIn.append(comida)
                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: item.consumirAte!) {
                    foodDayBeforeIn.append(comida)
                    foodSameDayIn.append(comida)
                    foodDayAfterOut.append(comida)
                    foodDatesAfterOut.append(dayAfter)
                } else if calendar.isDate(comida.consumirAte!, inSameDayAs: dayAfter) {
                    foodSameDayIn.append(comida)
                    foodDayAfterOut.append(comida)
                    foodDatesAfterOut.append(calendar.date(byAdding: .day, value: +1, to: comida.consumirAte!)!)
                } else if comida.consumirAte! < item.consumirAte! {
                    foodDayAfterOut.append(comida)
                    foodDatesAfterOut.append(calendar.date(byAdding: .day, value: +1, to: comida.consumirAte!)!)
                } else if comida.consumirAte! > dayAfter {
                    foodDayAfterOut.append(comida)
                    foodDatesAfterOut.append(calendar.date(byAdding: .day, value: +1, to: comida.consumirAte!)!)
                }
            }
        }
        foodDatesAfterOut.sort(by: { $0 < $1 })
        foodDayAfterOut.sort(by: { $0.consumirAte! < $1.consumirAte! })
        checkDayInNotification(for: dayBefore) { types in
            self.checkAndRemoveIn(types: types, data: dayBefore, foodDay: foodDayBeforeIn)
        }
            
        checkDayInNotification(for: sameDay) { types in
            self.checkAndRemoveIn(types: types, data: sameDay, foodDay: foodSameDayIn)
        }
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
                            nextDayNotificationSpecific = true
                            
                            specificDate = Calendar.current.date(from: triggerDate)!
                        }
                        if request.content.categoryIdentifier.contains("generic") {
                            nextDayNotificationGeneric = true
                            genericDate = Calendar.current.date(from: triggerDate)!
                        }
                        if nextDayNotificationGeneric && nextDayNotificationSpecific {
                            break // Interrompe o loop se ambas notificações já forem encontradas
                        }
                    }
                }
            }
            self.outNotificationUpdate(nextDayNotificationGeneric: nextDayNotificationGeneric, foodDatesAfterOut: foodDatesAfterOut, foodDayAfterOut: foodDayAfterOut, dayAfter: dayAfter, nextDayNotificationSpecific: nextDayNotificationSpecific, specificDate: specificDate ?? Date(), genericDate: genericDate ?? Date())
        }
    }
    
    func outNotificationUpdate(nextDayNotificationGeneric: Bool, foodDatesAfterOut: [Date], foodDayAfterOut: [Food], dayAfter: Date, nextDayNotificationSpecific: Bool, specificDate: Date, genericDate: Date) {
        if nextDayNotificationSpecific == true {
            if specificDate == dayAfter {
                self.removeNotification(for: dayAfter, type: "OUT")
                if foodDatesAfterOut.count > 1 {
                    if foodDatesAfterOut[0] != foodDatesAfterOut[1] {
                        self.dispatchNotification(for: foodDatesAfterOut[0], identifier: "\(foodDatesAfterOut[0])_OUT", title: "Aviso", message: "O alimento \(foodDayAfterOut[0].nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                    }
                } else if foodDatesAfterOut.count == 1 {
                    self.removeNotification(for: genericDate, type: "OUT")
                    self.dispatchNotification(for: foodDatesAfterOut[0], identifier: "\(foodDatesAfterOut[0])_OUT", title: "Aviso", message: "O alimento \(foodDayAfterOut[0].nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                }
            } else if specificDate < dayAfter {
                if nextDayNotificationGeneric == true {
                    if genericDate == dayAfter {
                        if let firstDifferent = foodDatesAfterOut.first(where: { $0 != foodDatesAfterOut[0] }) ?? foodDatesAfterOut.first {
                                self.removeNotification(for: dayAfter, type: "OUT")
                                self.dispatchNotification(for: firstDifferent, identifier: "\(firstDifferent)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                            if foodDatesAfterOut.count != 1 {
                                if let firstDifferent = foodDatesAfterOut.first(where: {$0 != foodDatesAfterOut[0]}) {
                                    self.dispatchNotification(for: firstDifferent, identifier: "\(firstDifferent)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                                }
                            }
                        } else {
                            self.removeNotification(for: genericDate, type: "OUT")
                        }
                    }
                }
            }
        } else {
            if nextDayNotificationGeneric == true {
                if genericDate == dayAfter {
                    if let firstDifferent = foodDatesAfterOut.first {
                        let ocurred = foodDatesAfterOut.filter { $0 == foodDatesAfterOut.first }.count
                        if ocurred == 1 {
                            self.removeNotification(for: dayAfter, type: "OUT")
                            self.dispatchNotification(for: firstDifferent, identifier: "\(firstDifferent)_OUT", title: "Aviso", message: "O alimento \(foodDayAfterOut[0].nome) está fora do prazo de consumo definido 😱", type: .outTarget, secondaryType: .specific)
                            if foodDatesAfterOut.count != 1 {
                                if let firstDifferent = foodDatesAfterOut.first(where: {$0 != foodDatesAfterOut[0]}) {
                                    self.dispatchNotification(for: firstDifferent, identifier: "\(firstDifferent)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                                }
                            }
                        } else {
                            self.removeNotification(for: dayAfter, type: "OUT")
                            self.dispatchNotification(for: firstDifferent, identifier: "\(firstDifferent)_OUT", title: "Aviso", message: "Há alimentos fora do prazo de consumo armazenados 😱", type: .outTarget, secondaryType: .generic)
                        }
                    }
                }
            }
        }
    }
    
    func checkAndRemoveIn(types: [Bool], data: Date,foodDay: [Food]) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        var components = calendar.dateComponents([.year, .month, .day], from: data)
            components.hour = 3
            components.minute = 0
            components.second = 0
        print(calendar.date(from: components)!)
        if types[0] == true {
            if types[1] == true {
                self.removeNotification(for: calendar.date(from: components)!, type: "IN")
            } else {
                if foodDay.count == 1 {
                    self.removeNotification(for: calendar.date(from: components)!, type: "IN")
                    self.dispatchNotification(for: calendar.date(from: components)!, identifier: "\(calendar.date(from: components)!)_IN", title: "Aviso", message: "O alimento \(foodDay[0].nome) está perto do prazo de consumo definido 😳", type: .inTarget, secondaryType: .specific)
                }
            }
        }
    }
    
    func removeNotification(for itemID: Date, type: String) {
        
        let notification = "\(itemID)_\(type)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification])
    }
}
