//
//  ContentView.swift
//  Counter
//
//  Created by RadioHead Ache on 2021/3/31.
//

import SwiftUI

struct ContentView: View {
    @State var counter = 0
    var body: some View {
        VStack{
            Button(action: {
                self.counter += 1
            }, label: {
                Text("Tap Me!")
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(5)
            })
            
            if counter > 0 {
                Text("You've tapped \(counter) times")
            } else {
                Text("You've not tapped yet")
            }
        }.debug()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
