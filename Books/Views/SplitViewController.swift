//
//  Untitled.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    init() {
        super.init(style: .doubleColumn)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.preferredSplitBehavior = .tile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func orientationChanged() {
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            preferredDisplayMode = .secondaryOnly
        case .landscapeLeft, .landscapeRight:
            preferredDisplayMode = .oneBesideSecondary
        default:
            preferredDisplayMode = .automatic
        }
    }
    
    func collapseSidebar() {
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            UIView.animate(withDuration: 0.3, delay: 0.3) { [weak self] in
                self?.preferredDisplayMode = .secondaryOnly
            }
        default:
            break
        }
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        return .primary
    }
}
