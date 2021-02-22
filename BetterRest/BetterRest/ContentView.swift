//
//  ContentView.swift
//  BetterRest
//
//  Created by Yong Liang on 2/17/21.
//  CoreML训练时间太长，没能成功创建计算用的Model
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime //早上7点
    @State private var coffeeAmount = 1
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("打算睡多久").font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g")小时")
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("打算什么时候起床").font(.headline)
                    DatePicker("输入时间", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("每天喝的咖啡").font(.headline)
                    Stepper(value: $coffeeAmount, in: 1...20) {
                        if(coffeeAmount == 1) {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
            }
                .navigationBarTitle("BetterRest")
                .navigationBarItems(trailing:
                        Button(action: calculateBedtime) {
                            Text("预测睡眠时间")
                    }
                )
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("提示"), message: Text("开发中"), dismissButton: .default(Text("好的")))
            }
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    func calculateBedtime() {
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
