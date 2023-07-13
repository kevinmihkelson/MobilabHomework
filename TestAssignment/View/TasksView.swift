//
//  TasksView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI
import SimpleToast

struct TasksView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    private let toastOptions = SimpleToastOptions(
            hideAfter: 5
        )
    
    var body: some View {
        VStack {
            HStack {
                Text("Lists").font(.title).bold()
                Spacer()
            }.padding(.horizontal)
            NewListTextFieldView(taskViewModel: taskViewModel).padding(.horizontal)
            TasksListView(taskViewModel: taskViewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
        .simpleToast(isPresented: $taskViewModel.showAlert, options: toastOptions) {
            Label(taskViewModel.errorMessage, systemImage: "exclamationmark.triangle")
                .padding()
                .background(Color.red.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
            }
    }
}
