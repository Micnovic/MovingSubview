//
//  ContentView.swift
//  MovingSubview
//
//  Created by Глеб Михновец on 02.02.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()
    @Namespace private var animation
    
    var body: some View {
        HStack{
            
            VStack{
                ForEach(model.firstArray, id: \.id) { arrayElement in
                    
                    Text(String(arrayElement.value)).matchedGeometryEffect(id: arrayElement.id, in: animation)
                }
            }.frame(width: 50).animation(.easeInOut, value: model.firstArray.count)
            VStack{
                ForEach(model.secondArray, id: \.id) { arrayElement in
                    
                    Text(String(arrayElement.value)).matchedGeometryEffect(id: arrayElement.id, in: animation)
                }
            }.frame(width: 50).animation(.easeInOut, value: model.secondArray.count)
            
            VStack{
                Button(action: withAnimation{{model.move()}}){
                    Text("Move")
                }
                Button(action: withAnimation{{model.moveBack()}}){
                    Text("Move back")
                }
            }
            Spacer()
        }.frame(width: 210, height: 210)
    }
}


class Model: ObservableObject {
    struct element: Identifiable, Hashable {
        var value: Int
        let id = UUID()
        init(_ i: Int){
            value = i
        }
    }
    
    @Published var firstArray: [element] = [element(1),element(2),element(3),element(4)]
    @Published var secondArray: [element] = [element(5),element(6),element(7),element(8)]
    
    func move() -> Void {
        let elementToMove: element? = firstArray.last
        if elementToMove != nil {
            firstArray.removeLast()
            secondArray.append(elementToMove!)
        }
    }
    
    func moveBack() -> Void {
        let elementToMove: element? = secondArray.last
        if elementToMove != nil {
            secondArray.removeLast()
            firstArray.append(elementToMove!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
