//
//  EventController.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/16/21.
//

import UIKit

class EventController {
    
    static let sharedInstance = EventController()
    
    var favoritedEvents: [Int] = []
    
    static let cache = NSCache<NSString, UIImage>()
    
    static let clientID = "MjI1NDg1OTN8MTYyNjQ0Nzg5Ni42MTM5MDcz"
    
    func addFavoriteEvent(event: Event) {
        let eventID = event.id
        if !favoritedEvents.contains(eventID) {
            favoritedEvents.append(eventID)
        }
        saveToPersistentStore()
    }
    
    func removeFavoritedEvent(event: Event) {
        let eventID = event.id
        if favoritedEvents.contains(eventID) {
            guard let index = favoritedEvents.firstIndex(of: eventID) else { return }
            favoritedEvents.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    
    static func fetchEvents(searchTerm: String, completion: @escaping (Result<[Event], NetworkError>) -> Void) {
        
        let url = URL(string: "https://api.seatgeek.com/2/events")
        
        guard let baseURL = url else { return completion(.failure(.invalidURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let eventQuery = URLQueryItem(name: "q", value: searchTerm)
        let clientQuery = URLQueryItem(name: "client_id", value: clientID)
        let pageQuery = URLQueryItem(name: "per_page", value: "25")
        
        components?.queryItems = [eventQuery, clientQuery, pageQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("Call status code: \(response.statusCode)")
                if response.statusCode != 200 {
                    return completion(.failure(.unauthorized))
                }
            }

            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let events = try JSONDecoder().decode(Events.self, from: data)
                let eventsDecoded = events.events
                completion(.success(eventsDecoded))
            } catch {
                completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    // MARK: - Persistence
    
    func createPersistenceStore() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "FavoriteEvents.json"
        let fileURL = documentDirectory.appendingPathComponent(filename)
        return fileURL
        
    }
    
    func saveToPersistentStore() {
        
        do {
            let data = try JSONEncoder().encode(favoritedEvents)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: createPersistenceStore())
            
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            favoritedEvents = try JSONDecoder().decode([Int].self, from: data)
            
        } catch {
            print("Error loading data drom disk \(error)")
            
        }
    }
}
