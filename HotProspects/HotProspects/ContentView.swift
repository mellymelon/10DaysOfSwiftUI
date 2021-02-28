//
//  ContentView.swift
//  HotProspects
//
//  Created by Yong Liang on 2/27/21.
//

import SwiftUI
import UserNotifications
//import SamplePackage

struct ContentView: View {
    @State private var selectedTab = 0
    enum NetworkError: Error {
        case badURL, requestFailed, unknown
    }
//    @ObservedObject var updater = DelayedUpdater()
    @State private var backgroundColor = Color.red
    var prospects = Prospects()

    var body: some View {

        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
            }
        }.environmentObject(prospects)
//        Text("Hello, World!")
//            .onAppear {
//                fetchData(from: "https://www.apple.com") { result in
//                    switch result {
//                    case .success(let str):
//                        print(str)
//                    case .failure(let error):
//                        switch error {
//                        case .badURL:
//                            print("Bad URL")
//                        case .requestFailed:
//                            print("Network problems")
//                        case .unknown:
//                            print("Unknown error")
//                        }
//                    }
//                }
//        }
    }

    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // 检查链接是否正常
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // 返回主线程
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

//class DelayedUpdater: ObservableObject {
////    @Published var value = 0
//    var value = 0 {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    init() {
//        for i in 1...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
