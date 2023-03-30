//
//  NewTabBar.swift
//  ToDoList
//
//  Created by Daniel Wade Duggin on 3/6/23.
//

import SwiftUI

struct NewTabBar: View {
    @Binding var selectedTab: String
    
    //storing each tab midpoints to animate in future.
    
    @State var tabPoints : [CGFloat] = []
    
    var body: some View {
        HStack (spacing: 0) {
            
            //Tab bar buttons
            
            tabButton(image: "bubble.left", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            
            tabButton(image: "takeoutbag.and.cup.and.straw", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            
            tabButton(image: "graduationcap", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            tabButton(image: "gearshape", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
           
        }
        .padding()
        .background(
            Color(.red) //this is the new tab bar color. TabBar is useless rn
            //Color.theme.TabBar
//                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15)))
            )
        .overlay (
          Circle()
            .fill(Color.white)
            .frame(width:10,height:10)
            .offset(x:getCurvePoint() - 213)
          ,alignment: .bottom
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    func getCurvePoint() -> CGFloat {
        //if tabpoint is empty...
        if tabPoints.isEmpty{
            return 10
        }
        else {
            switch selectedTab {
            case "bubble.left":
                return tabPoints[0]
            case "takeoutbag.and.cup.and.straw":
                return tabPoints[1]
            case "graduationcap":
                return tabPoints[2]
            case "gearshape":
                return tabPoints[3]
            
            default:
                return tabPoints[3]
            }
        }
    }
}


struct tabButton: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    var body: some View {
        //mid point of each button for curve animation...
        GeometryReader{reader -> AnyView in
            
            //extracting midpoint and storing
            let midX = reader.frame(in:.global).midX
            
            DispatchQueue.main.async {
                
                //avoiding junk data
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
           return AnyView(
            Button(action: {
                //changing tab...
                //spring animation...
                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.5,blendDuration: 0.5)){
                    selectedTab = image
                }
            }, label: {
                
                
                //filling the color if its selected
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size:25,weight:.semibold))
                    
                    .foregroundColor(Color.black)
                    // Lifting View
                    //if its selected
                    .offset(y:selectedTab == image ? -10 : 0)
            })
            .frame(maxWidth:.infinity, maxHeight:.infinity)
           
           )
        }
        //maxHeight
        .frame(height:50)
    }
}


struct NewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
