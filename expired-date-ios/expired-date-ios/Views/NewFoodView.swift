//
//  NewFoodView.swift
//  expired-date-ios
//
//  Created by fit-sys on 2020/10/13.
//


import SwiftUI

struct NewFoodView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("賞味期限 \(homeData.updateItem == nil ? "登録" : "修正")")
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            TextEditor(text: $homeData.content)
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack{
                
                Text("いつまで")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 10){
                
                ExpiredDateButton(title: "今日", homeData: homeData)
                
                ExpiredDateButton(title: "明日", homeData: homeData)
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            Button(action: {homeData.writeData(context: context)}, label: {
                
                Label(
                    title: { Text(homeData.updateItem == nil ? "登録" : "更新")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                    
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}

