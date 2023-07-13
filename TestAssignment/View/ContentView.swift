//
//  ContentView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var taskViewModel: TaskViewModel = TaskViewModel()
    var body: some View {
        VStack {
            TasksView(taskViewModel: taskViewModel)
        }.onAppear {
            taskViewModel.getTaskLists()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
