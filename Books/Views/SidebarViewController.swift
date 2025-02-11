//
//  SidebarViewController.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

class SidebarViewController: UITableViewController {
    
    private let viewModel: SidebarViewModel
    private let router: BooksRouter!
    
    init(viewModel: SidebarViewModel, router: BooksRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.menuItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.rawValue
        content.image = UIImage(systemName: item.icon)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.menuItems[indexPath.row]
        router.routeTo(selectedItem)
    }
    
    @objc private func orientationChanged() {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            print("Portrait mode")
        case .landscapeLeft, .landscapeRight:
            print("Landscape mode")
        default:
            break
        }
    }
}
