//
//  EventSearchTableViewController.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/19/21.
//

import UIKit

class EventSearchTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var datasource: [Event] = []
    
    func configure() {
        EventController.sharedInstance.loadFromPersistentStore()
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datasource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        let event = datasource[indexPath.row]
        
        cell.event = event
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let event = datasource[indexPath.row]
        
        let favorited: Bool = EventController.sharedInstance.favoritedEvents.contains(event.id)
        
        let favoriteAction = UIContextualAction(style: .normal, title: favorited ? "Unfavorite" : "Favorite") { _, view, actionPerformed in
            print("\(event.id) favorited")
            favorited ? EventController.sharedInstance.removeFavoritedEvent(event: event) : EventController.sharedInstance.addFavoriteEvent(event: event)
            tableView.reloadData()
        }
        favoriteAction.backgroundColor = favorited ? .systemGray2 : .systemRed
        favoriteAction.image = UIImage(systemName: "suit.heart")
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        searchBar.resignFirstResponder()
//    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else { return }
            let eventToSend = datasource[indexPath.row]
            destination.event = eventToSend
        }
    }
}

extension EventSearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        EventController.fetchEvents(searchTerm: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    print("Houston, we have touchdown with SeatGeek")
                    self.datasource = events
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Mayday, mayday.")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        searchBar.showsCancelButton = true
        EventController.fetchEvents(searchTerm: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    print("Houston, we have touchdown with SeatGeek")
                    self.datasource = events
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Mayday, mayday.")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        datasource = []
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
}
