//
//  ContentView.swift
//  Calculator
//
//  Created by RadioHead Ache on 2021/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var brain: CalculatorBrain = .left("0")
    
    // use scale to opt different screens
    let scale = UIScreen.main.bounds.size.width / 414
    var body: some View {
        VStack(alignment: .center, spacing: 12, content: {
            Spacer()
            Text(brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .lineLimit(1)
                .frame(
                    minWidth: 0, idealWidth: nil, maxWidth: .infinity, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .trailing)
            CalculatorButtonPad(brain: $brain).padding(.bottom)
        }).scaleEffect(scale)
    }
}


extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height, alignment: .center)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        })
    }
}

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    @Binding var brain: CalculatorBrain
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName) {
                    self.brain = self.brain.apply(item: item)
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    @Binding var brain: CalculatorBrain

    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row, brain: self.$brain)
            }
        })
    }
}
