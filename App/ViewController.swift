//
//  MainWidgetViewController.swift
//  App
//
//  Created by IlanL on 18/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit
import Commandor

extension MainWidgetViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].itemData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WidgetCell
        
        let item = self.sections[indexPath.section].itemData[indexPath.row]
        let widget = item.handler
        let newView = widget!.getView()
        
        let topConstraint = NSLayoutConstraint(item: newView, attribute: .top, relatedBy: .equal, toItem: cell.containerView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: newView, attribute: .bottom, relatedBy: .equal, toItem: cell.containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: newView, attribute: .leading, relatedBy: .equal, toItem: cell.containerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: newView, attribute: .trailing, relatedBy: .equal, toItem: cell.containerView, attribute: .trailing, multiplier: 1, constant: 0)
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.containerView.addSubview(newView)
        cell.containerView.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        cell.containerView.layoutIfNeeded()
        cell.handler = widget
        
        return cell
    }
}

extension MainWidgetViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WidgetCell
        cell.handler.onClick(window: collectionView.window!) { (window, error) in
            print("back to main")
        }
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

class MainWidgetViewController: UIViewController {
    
    struct Item {
        var handler: WidgetProtocol?
        var name : String
        var size : CGSize
    }
    struct Section {
        var sectionName : String
        var itemData : [Item]
    }
    
    // MARK: - Properties
    private let reuseIdentifier = "WidgetCell"
    var sections : [Section] = []
    var gameTimer: Timer!
    var longPressGesture: UILongPressGestureRecognizer!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @objc func runTimedCode() {
        print("bla")
        self.collectionView?.performBatchUpdates({
            let section = 0
            let countItemsInSection = self.collectionView(self.collectionView, numberOfItemsInSection: 0)
            let id = "added \(countItemsInSection)"
            
            self.sections[section].itemData.append(Item(handler: Plugin2(json: ["id": id, "lines": 4]), name: id, size: .zero)) //add your object to data source first
            
            print("New count: \(countItemsInSection)")
            
            let indexPath = IndexPath(item: countItemsInSection, section: section)
            
            self.collectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        gameTimer.invalidate() // Timer stopped
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        
        SearchApi().query(nil, completion: { [weak self] (results, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let wSelf = self else { return }
            
            var i: Int = 1
            results?.results.forEach({ (w) in
                
                if (i == 1) {
                    wSelf.sections.append(MainWidgetViewController.Section(sectionName: "Section \(i)", itemData: []))
                }
                wSelf.sections[0].itemData.append(MainWidgetViewController.Item(handler: w, name: w.getIdentifier(), size: .zero))
                i += 1
            })
            
            let layout = WidgetLayout()
            layout.delegate = wSelf
            wSelf.collectionView.collectionViewLayout = layout
            wSelf.collectionView.dataSource = wSelf
            wSelf.collectionView.delegate = wSelf
            wSelf.collectionView.reloadData()
        })
    }
    
    // MARK: Reorder Items
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Starting Index: \(sourceIndexPath.item)")
        print("Ending Index: \(destinationIndexPath.item)")
        let movingItem = self.sections[sourceIndexPath.section].itemData[sourceIndexPath.row]
        self.sections[sourceIndexPath.section].itemData.remove(at: sourceIndexPath.row)
        print(movingItem.name)
        self.sections[sourceIndexPath.section].itemData.insert(movingItem, at: destinationIndexPath.row)
        
        let layout = self.collectionView.collectionViewLayout as! WidgetLayout
        layout.resetAllCache()
        
        // need to invalidate all layout
        self.collectionView.reloadItems(at: [sourceIndexPath, destinationIndexPath])
    }
    
}

