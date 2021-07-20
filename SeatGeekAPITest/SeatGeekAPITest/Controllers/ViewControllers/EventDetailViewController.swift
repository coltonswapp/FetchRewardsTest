//
//  EventDetailViewController.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/19/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTypeButton: EventTypeButton!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var showMapsButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    let cache = EventController.cache
    var event: Event?
    
    func setupViews() {
        guard let event = event else { return }
        eventTitleLabel.text = event.title
        let eventType = event.type
        eventTypeButton.setTitle(eventType.uppercased(), for: .normal)
        eventTypeButton.backgroundColor = configButtonColor(type: eventType)
        
        eventDateLabel.text = event.date.formatDate(event.date)
        eventLocationLabel.text = "\(event.venue.name) - \(event.venue.displayLocation)"
        
        let cacheKey = NSString(string: event.performers[0].image)
        
        if let image = cache.object(forKey: cacheKey) {
            self.eventImageView.image = image
        } else {
            print("Something went wrong fetching the image from the cache.")
        }
        
        eventImageView.layer.cornerRadius = 10
        showMapsButton.layer.cornerRadius = 10
        addFavoriteButton.layer.cornerRadius = 10
        configureFavoriteButton()

        
    }
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let event = event else { return }
        if !EventController.sharedInstance.favoritedEvents.contains(event.id) {
            activateFavoriteButton()
            EventController.sharedInstance.addFavoriteEvent(event: event)
        } else {
            deactivateFavoriteButton()
            EventController.sharedInstance.removeFavoritedEvent(event: event)
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
    
    func configureFavoriteButton() {
        guard let event = event else { return }
        if EventController.sharedInstance.favoritedEvents.contains(event.id) {
            addFavoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            addFavoriteButton.tintColor = .white
            addFavoriteButton.setTitle("Favorited", for: .normal)
            addFavoriteButton.setTitleColor(.white, for: .normal)
            addFavoriteButton.layer.backgroundColor = UIColor.systemRed.cgColor
            addFavoriteButton.layer.borderWidth = 0
        } else {
            addFavoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            addFavoriteButton.tintColor = .black
            addFavoriteButton.setTitle("Add to Favorites", for: .normal)
            addFavoriteButton.layer.backgroundColor = UIColor.white.cgColor
            addFavoriteButton.setTitleColor(.black, for: .normal)
            addFavoriteButton.layer.borderWidth = 2
            addFavoriteButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func activateFavoriteButton() {
        addFavoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        addFavoriteButton.tintColor = .white
        addFavoriteButton.setTitle("Favorited", for: .normal)
        addFavoriteButton.setTitleColor(.white, for: .normal)
        addFavoriteButton.layer.borderWidth = 0
        UIView.animate(withDuration: 0.4) {
            self.addFavoriteButton.layer.backgroundColor = UIColor.systemRed.cgColor
        }
    }
    
    func deactivateFavoriteButton() {
        addFavoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        addFavoriteButton.tintColor = .black
        addFavoriteButton.setTitle("Add to Favorites", for: .normal)
        addFavoriteButton.setTitleColor(.black, for: .normal)
        addFavoriteButton.layer.borderWidth = 2
        addFavoriteButton.layer.borderColor = UIColor.black.cgColor
        UIView.animate(withDuration: 0.4) {
            self.addFavoriteButton.layer.backgroundColor = UIColor.white.cgColor
        }
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView" {
            guard let event = event,
                  let destination = segue.destination as? MapViewViewController else { return }
            
            destination.event = event
        }
    }
    

}
