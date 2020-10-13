//
//  Home.swift
//  expired-date-ios
//
//  Created by fit-sys on 2020/10/13.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    // Fetching Data.....
    @FetchRequest(entity: Food.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Food>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("賞味期限管理")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                // Empty View....
                
                if results.isEmpty{
                    
                    Spacer()
                    
                    Text("からっぽ !!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading,spacing: 20){
                            
                            ForEach(results){food in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(food.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    Text(food.date ?? Date(),style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu{
                                    
                                    Button(action: {homeData.EditItem(item: food)}, label: {
                                        Text("修正")
                                    })
                                    
                                    Button(action: {
                                        context.delete(food)
                                        try! context.save()
                                    }, label: {
                                        Text("削除")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            // Add Button...
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewFoodView(homeData: homeData)
        })
    }
}

