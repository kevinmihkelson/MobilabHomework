//
//  NewListTextFieldView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct NewListTextFieldView: View {
    @State var newListTitle: String = ""
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("New list", text: $newListTitle)
                    .accessibilityIdentifier("NewList")
                Button {
                    taskViewModel.addTaskList(taskList: TaskList(id: UUID().description, title: newListTitle, tasks: []))
                    newListTitle = ""
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add").bold()
                    }.foregroundColor(.gray)
                }.accessibilityIdentifier("SaveList")
            }.padding(.all)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
        }
    }
}
