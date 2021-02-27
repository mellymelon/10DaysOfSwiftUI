//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Yong Liang on 2/25/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: []) var ships: FetchedResults<Ship>
    @State private var lastNameFilter = "A"
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        VStack {
//            List(wizards, id: \.self) { wizard in
//                Text(wizard.name ?? "Unknown")
//            }
//            Button("Add") {
//                let wizard = Wizard(context: viewContext)
//                wizard.name = "Harry Potter"
//            }
//            Button("Save") {
//                do {
//                    try viewContext.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: viewContext)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: viewContext)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: viewContext)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: viewContext)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? viewContext.save()
//            }

//            Button("Add Examples") {
//                let taylor = Singer(context: viewContext)
//                taylor.firstName = "Taylor"
//                taylor.lastName = "Swift"
//
//                let ed = Singer(context: viewContext)
//                ed.firstName = "Ed"
//                ed.lastName = "Sheeran"
//
//                let adele = Singer(context: viewContext)
//                adele.firstName = "Adele"
//                adele.lastName = "Adkins"
//
//                try? viewContext.save()
//            }
//            FilteredList(filter: lastNameFilter)
//            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//
//            Button("Show A") {
//                lastNameFilter = "A"
//            }
//
//            Button("Show S") {
//                lastNameFilter = "S"
//            }
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: viewContext)
                candy1.name = "Mars"
                candy1.origin = Country(context: viewContext)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: viewContext)
                candy2.name = "KitKat"
                candy2.origin = Country(context: viewContext)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: viewContext)
                candy3.name = "Twix"
                candy3.origin = Country(context: viewContext)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: viewContext)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: viewContext)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? viewContext.save()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
