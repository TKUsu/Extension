//
//  MultipleOptionView.swift
//  Lucker
//
//  Created by SuJustin on 2021/4/28.
//

import UIKit

class MultipleOptionView: UIView, NibOwnerLoadable {
    
    let nibString = String(describing: MultipleOptionView.self)
    var items: [String] = [] {
        didSet {
            guard collectionView != nil else { return }
            collectionView.reloadData()
        }
    }
    var selectedItem: [String] = []
    
    // MARK: Property
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var optinal: Bool = true {
        didSet {
            needFlagLabel.isHidden = optinal
        }
    }
    
    @IBOutlet weak var needFlagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var otherHintView: UIView!
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    private let cellNib = String(describing: MultipleOptionCollectionViewCell.self)
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        titleLabel.text = title
        needFlagLabel.isHidden = optinal
    }
    
    // MARK: Initialier
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    // MARK: Custom Init
    private func customInit() {
        loadNibContent()
    }
    
    // MARK: Awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = title
        needFlagLabel.isHidden = optinal
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellNib)
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = flowLayout
    }
    
    @objc func updateCollectionViewHeight() {
        collectionHeightConstraint.constant = items.count == 0 ? 0 : collectionView.contentSize.height + 8
    }
}

extension MultipleOptionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(updateCollectionViewHeight), object: nil)
        perform(#selector(updateCollectionViewHeight), with: nil, afterDelay: 0.01)
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNib, for: indexPath) as! MultipleOptionCollectionViewCell
        
        cell.text = items[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectedItem.append(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        guard let index = selectedItem.firstIndex(of: item) else { return }
        selectedItem.remove(at: index)
    }
}
