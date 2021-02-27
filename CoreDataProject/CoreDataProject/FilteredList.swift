//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Yong Liang on 2/25/21.
//

import SwiftUI
import CoreData

//struct FilteredList: View {
//支持任意类型的entity的任意类型key
struct FilteredList<T: NSManagedObject, Content: View>: View {
//    var fetchRequest: FetchRequest<Singer>
    var fetchRequest: FetchRequest<T>
//    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    //this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        //如果不喜欢用fetchRequest.wrappedValue就用singers
        List(singers, id: \.self) { singer in
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            content(singer)
        }
    }

//    init(filter: String) {
//        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
