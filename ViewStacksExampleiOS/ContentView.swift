
import SwiftUI


//
//  ContentView.swift
//  StackViewsExample
//
//  Created by Landon Johnson on 3/29/23.
//

import SwiftUI

struct ImageInfo:  View {
    var title: String;
    var color: Color;
    var body: some View {
        ZStack() {
            
            
            ZStack{
                Text(title)
                    .foregroundColor(color)
                    .font(.system(size: 25))
                    .shadow(color: Color("TextDrop"), radius: 0)
                    .padding(10)
                    .background(.ultraThickMaterial)
                    .cornerRadius(7)


            }

                .frame(height: 80)
                .shadow(color: Color("TextDrop"), radius: 10)

               
        }
    }
}

struct ExampleOne: View {
    var body: some View {
        VStack() {
            Image("ImageNameInAssets")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(7)
            
            ImageInfo(title: "Light Painting", color: Color.black)
        }
    }
}

struct ExampleTwo: View {
    var body: some View {
        HStack() {
            // By default the views inside the HStack would
            // render starting from the left
            // Image would render first
            Image("ImageNameInAssets")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(7)
            
            ImageInfo(title: "Light Painting", color: Color.black)
        }
    }
}

struct ExampleThree: View {
    var body: some View {
        ZStack() {
            // Image would render first (Underneath)
            Image("ImageNameInAssets")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(7)
            
            // ImageInfo would render on top
            ImageInfo(title: "Light Painting", color: Color.black)
        }
    }
}


enum SelectableViews: String, CaseIterable   {
    case VStack
    case HStack
    case ZStack
}

func getViewForPicker (viewName:String) -> some View {
    switch(viewName){
    case "VStack":
        return ExampleOne()
    case "HStack":
        return ExampleTwo()
    case "ZStack":
        return ExampleThree()
    default:
        return ExampleOne()
    }
    
}

struct ContentView: View {
    @State public var selectedView = "VStack"
    
    let viewList: [String] = SelectableViews.allCases.map { $0.rawValue }
    var viewToRender: some View  {
        return getViewForPicker(viewName: selectedView)
    }
    
    
    var body: some View {
        ZStack{
            Color("Backdrop").edgesIgnoringSafeArea(.all)
            ZStack{
                VStack{
                    Spacer()
                    VStack(alignment: .center){
                        viewToRender
                    }.padding(20)
                    Spacer()
                    Spacer()
                    ZStack{
                        Color.white
                        VStack{
                            Picker("StackView", selection: $selectedView) {
                                ForEach(viewList, id: \.self) {
                                    Text($0)
                                }
                            }.pickerStyle(.segmented)
                        }.frame(height: 80)
                        
                        
                    }.frame(height: 50)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
