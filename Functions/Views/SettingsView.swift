//
//  SettingsView.swift
//  Functions
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI
import AudioToolbox
import KeyboardShortcuts
import LaunchAtLogin

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("showingButtons") private var showingButtons = true
    @AppStorage("trigMode") private var trigMode: Mode = .degree
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // MARK: - Calculator Mode
            Picker(selection: $trigMode, content: {
                Text("Degree").tag(Mode.degree)
                Text("Radian").tag(Mode.radian)
            }, label: {})
            .pickerStyle(.segmented)
            
            // MARK: - Display and Change Global Shortcut
            KeyboardShortcuts.Recorder(for: .togglePopover)
            
            // MARK: - Toggle Launch at Login
            LaunchAtLogin.Toggle()
            
            // MARK: - Toggle Button View
            Toggle(isOn: $showingButtons, label: {
                Text("Show Buttons").padding(.leading, 4)
            })
            
            // MARK: - Clear History
            Button {
                withAnimation(.easeOut(duration: 0.1)) {
                    deleteAllData("History")
                    AudioServicesPlaySystemSound(0xf) // plays dock item poof sound
                }
            } label: {
                Image(systemName: "trash")
                Text("Clear History")
            }
            .buttonStyle(.plain)
            
            // MARK: - Quit
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Image(systemName: "clear")
                Text("Quit")
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
        }
    }
    
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
            }
        } catch let error {
            print("Delete all data in \(entity) error :", error)
        }
    }
}

// For picking the calculator trig mode
enum Mode: String, CaseIterable, Identifiable  {
    case radian, degree
    var id: Self { self }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
