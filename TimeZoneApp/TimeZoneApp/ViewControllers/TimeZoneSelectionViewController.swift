import UIKit

class TimeZoneSelectionViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let timeZoneManager = TimeZoneManager.shared
    private var filteredTimeZones: [TimeZoneData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        title = "Select Timezone"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel, 
            target: self, 
            action: #selector(cancelTapped)
        )
        
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search timezones"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TimeZoneSelectionCell.self, forCellReuseIdentifier: "TimeZoneSelectionCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        filteredTimeZones = timeZoneManager.commonTimeZones
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    private func filterTimeZones(with searchText: String) {
        if searchText.isEmpty {
            filteredTimeZones = timeZoneManager.commonTimeZones
        } else {
            filteredTimeZones = timeZoneManager.commonTimeZones.filter { timeZone in
                timeZone.name.lowercased().contains(searchText.lowercased()) ||
                timeZone.identifier.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TimeZoneSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZoneSelectionCell", for: indexPath) as! TimeZoneSelectionCell
        let timeZone = filteredTimeZones[indexPath.row]
        
        let isSelected = timeZoneManager.selectedTimeZones.contains { $0.identifier == timeZone.identifier }
        
        cell.configure(with: timeZone.name, identifier: timeZone.identifier, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let timeZone = filteredTimeZones[indexPath.row]
        
        if timeZoneManager.selectedTimeZones.count >= 6 && 
           !timeZoneManager.selectedTimeZones.contains(where: { $0.identifier == timeZone.identifier }) {
            let alert = UIAlertController(
                title: "Maximum Reached", 
                message: "You can only select up to 6 timezones. Remove one to add another.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        timeZoneManager.toggleTimeZone(timeZone)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TimeZoneSelectionCell {
            let isSelected = timeZoneManager.selectedTimeZones.contains { $0.identifier == timeZone.identifier }
            cell.configure(with: timeZone.name, identifier: timeZone.identifier, isSelected: isSelected)
        }
    }
}

// MARK: - UISearchResultsUpdating

extension TimeZoneSelectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterTimeZones(with: searchController.searchBar.text ?? "")
    }
}
