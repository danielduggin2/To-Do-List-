//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Daniel Wade Duggin on 2/13/23.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    let SecondAccentColor = Color("SecondAccentColor")
    var body: some View {
        ScrollView{
            VStack{
                Text("You have no items")
                    .foregroundColor(Color("Text"))
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Have some things you need to get done today? If so, click the add button below to create your list!")
                    .foregroundColor(Color("Text"))
                    .padding(.bottom, 20)
                
                NavigationLink(destination: AddView(), label: {
                    Text("Add Something")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .background(animate ? SecondAccentColor : Color.accentColor)
                        .cornerRadius(10)
                })
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? SecondAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0.0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        //.background(Color("Background"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation(){
        guard !animate else{return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
