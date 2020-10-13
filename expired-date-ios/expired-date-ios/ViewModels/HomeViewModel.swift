//
//  HomeViewModel.swift
//  expired-date-ios
//
//  Created by fit-sys on 2020/10/13.
//


import SwiftUI
import CoreData

class HomeViewModel : ObservableObject{
    
    @Published var content = ""
    @Published var date = Date()
    
    @Published var isNewData = false
    
    @Published var updateItem : Food!
    
    let calender = Calendar.current
    
    func checkDate()->String{
        
        if calender.isDateInToday(date){
            
            return "今日"
        }
        else if calender.isDateInTomorrow(date){
            return "明日"
        }
        else{
            return "その他"
        }
    }
    
    func updateDate(value: String){
        
        if value == "今日"{date = Date()}
        else if value == "明日"{
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }
        else{

        }
    }
    
    func writeData(context : NSManagedObjectContext){
        
        if updateItem != nil{
            
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()

            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        
        let newFood = Food(context: context)
        newFood.date = date
        newFood.content = content
        
        do{
            
            try context.save()

            isNewData.toggle()
            content = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: Food){
        
        updateItem = item

        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
}
