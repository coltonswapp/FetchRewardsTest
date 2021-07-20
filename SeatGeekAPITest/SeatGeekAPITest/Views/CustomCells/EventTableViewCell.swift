//
//  EventTableViewCell.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/19/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTypeButton: EventTypeButton!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventVenueLabel: UILabel!
    @IBOutlet weak var venueLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventFavoritedImage: UIImageView!
    
    var event: Event? {
        didSet {
            updateViewsForEvent()
        }
    }
    
    let cache = EventController.cache
    
    func updateViewsForEvent() {
        guard let event = event else { return }
        let eventType = event.type
        eventTypeButton.setTitle(eventType.uppercased(), for: .normal)
        eventTypeButton.backgroundColor = configButtonColor(type: eventType)
        eventNameLabel.text = event.title
        eventVenueLabel.text = event.venue.name
        venueLocationLabel.text = event.venue.displayLocation
        let eventDate = event.date
        eventDateLabel.text = eventDate.formatDate(eventDate)
        downloadImage(from: event.performers[0].image)
        eventImageView.layer.cornerRadius = 5
        if EventController.sharedInstance.favoritedEvents.contains(event.id) {
            eventFavoritedImage.isHidden = false
        } else {
            eventFavoritedImage.isHidden = true
        }
    }
    
    func configButtonColor(type: String) -> UIColor {
        switch type {
        case "nba":
            return UIColor.red
        case "mlb":
            return UIColor.blue
        case "nhl":
            return UIColor.purple
        case "hockey":
            return UIColor.purple
        case "concert":
            return UIColor.green
        case "music_festival":
            return UIColor.cyan
        default:
            return UIColor.systemGray3
        }
    }
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.eventImageView.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.eventImageView.image = image
            }
            
        }.resume()
    }

}
