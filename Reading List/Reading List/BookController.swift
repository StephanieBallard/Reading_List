//
//  BookController.swift
//  Reading List
//
//  Created by Stephanie Ballard on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    
//    init() {
//       loadFromPersistentStore()
//    }
//
    
    var books: [Book]
    
    
    
    
    func createBook(with title: String, reason: String) {
        let book = Book(title: title, reasonToRead: reason)
        
        books.append(book)
        
        saveToPersistanceStore()
        
    }
    
    var readBooks: [Book] {
       return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
       return books.filter { $0.hasBeenRead == false}
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
            
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let booksURL = documentsDir.appendingPathComponent("ReadingList.plist")
        
        return booksURL
        
    }

    func saveToPersistanceStore() {
        
        guard let fileURL = readingListURL else { return }
        
        do {
            
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: fileURL)
            
        } catch {
            print("Error encoding books array: \(books)")
            
        }
        
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = readingListURL else { return }
        
        do {
            
            let booksData = try Data(contentsOf: fileURL)
            
            let decoder = PropertyListDecoder()
            
            let booksArray = try decoder.decode([Book].self, from: booksData)
            
            self.books = booksArray
            
        } catch {
            print("Error decoding books: \(error)")
            
        }
        
    }
    
    
    func removeBook(named book: Book) {
      guard let index = books.firstIndex(of: book) else { return }
      books.remove(at: index)
      
        saveToPersistanceStore()
        
       
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
            
        books[index].hasBeenRead.toggle()
            
        saveToPersistanceStore()
        
    }
    
    func updateTitleOrReason(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].title = book.title
        books[index].reasonToRead = book.reasonToRead
        
        saveToPersistanceStore()
    }

//    func updateHasBeenRead(for book: Book) {
//        var hasBeenRead = false
//        switch hasBeenRead{
//        case true:
//            hasBeenRead.toggle()
//        default:
//            hasBeenRead.toggle()
//        }
//    }
}



