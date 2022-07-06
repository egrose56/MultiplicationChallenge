//
//  TextFieldClearButon.swift
//  MultiplicationFun
//  Code created by Martin Albrecht
//  File Created by Elizabeth Rose on 7/4/22.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct UsingClearButton: View {
    @State var exampleText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Type in your Text here...", text: $exampleText)
                        .modifier(TextFieldClearButton(text: $exampleText))
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("Clear button example")
        }
    }
}
