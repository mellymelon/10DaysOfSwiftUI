//
//  ContentView.swift
//  WordScramble
//
//  Created by Yong Liang on 2/21/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
                .navigationBarTitle(rootWord)
                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "这个词已经用过了", message: "试试别的")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "这个词不可能由提示词的字母组成", message: "再试一下吧")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "这个词不存在", message: "字典里没这个词")
            return
        }
        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func startGame() {
        //如果start.txt的文件路径存在
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //如果路径指向的文件的内容存在
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
            }
            return
        }
        fatalError("无法从bundle加载start.txt")
    }

    //之前有没有猜过这个词
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    //有没有可能用rootWord的字母中组成用户猜的这个词
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    //英语字典里有没有这个词
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
