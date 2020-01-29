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
    
//    let digits = [1,4,10,15]
//    let even = digits.filter { $0 % 2 == 0 }
    // [4, 10]
//    Inside of the braces you can make your return into one line.
//    You would return the .filter method on your books variable and filter through the hasBeenRead variable
//    Pretty similar to this example:
//    let even = digits.filter { $0 % 2 == 0 }
//    You start filtering through something inside of the braces next to the word filter and the $0 is a special character that means to filter through whatever variable you attach to it.
//    Hope that helps and makes sense.
    
    
    var readBooks: [Book] {
        books.filter { $0 .hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        books.filter { $0 .hasBeenRead == false}
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



