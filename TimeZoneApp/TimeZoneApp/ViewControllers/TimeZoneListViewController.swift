import UIKit

class TimeZoneListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let timeZoneManager = TimeZoneManager.shared
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        title = "World Clocks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, 
            target: self, 
            action: #selector(addTimeZoneTapped)
        )
        
        // Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TimeZoneCell.self, forCellReuseIdentifier: "TimeZoneCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Add empty state view
        if timeZoneManager.selectedTimeZones.isEmpty {
            showEmptyState()
        }
    }
    
    private func showEmptyState() {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        
        let label = UILabel()
        label.text = "No timezones selected\nTap + to add timezones"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(label)
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            label.topAnchor.constraint(equalTo: emptyView.topAnchor),
            label.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor)
        ])
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func addTimeZoneTapped() {
        let vc = TimeZoneSelectionViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TimeZoneListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeZoneManager.shared.selectedTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZoneCell", for: indexPath) as! TimeZoneCell
        let timeZone = TimeZoneManager.shared.selectedTimeZones[indexPath.row]
        
        let currentTime = TimeZoneManager.shared.getFormattedTime(for: timeZone.identifier)
        let currentDate = TimeZoneManager.shared.getFormattedDateTime(for: timeZone.identifier)
        
        cell.configure(with: timeZone.name, time: currentTime, date: currentDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let timeZone = TimeZoneManager.shared.selectedTimeZones[indexPath.row]
            TimeZoneManager.shared.removeTimeZone(timeZone)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if TimeZoneManager.shared.selectedTimeZones.isEmpty {
                showEmptyState()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
