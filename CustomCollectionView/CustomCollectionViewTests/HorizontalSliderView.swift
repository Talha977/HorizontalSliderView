//
//  HorizontalSliderView.swift
//  CustomCollectionViewTests
//
//  Created by Talha Asif on 21/01/2023.
//

import UIKit

public protocol HorizontalSliderViewDelegate {
    func tappedOnCell(row:Int,section:Int)
}

public class HorizontalSliderView: UIView {
    
    // MARK: - OUTLETS
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - VARIABLES
    public var itemsArray:[CellData]
    public var cellHeight = CGFloat()
    public var cellWidth = CGFloat()
    var isSelectionEnabled = false
    public var delegate:HorizontalSliderViewDelegate?
    var screenWidth: CGFloat {
        return self.frame.width
    }
    
    // MARK: - INITIALIZER
    
    public override init(frame: CGRect) {
        self.itemsArray = []
        super.init(frame: frame)
        customInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.itemsArray = []
        super.init(coder: aDecoder)
        customInit()
    }
    
    // MARK: - Public Functions
    
    public func customInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("HorizontalSliderView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        initCollectionView()
        self.cellWidth = self.screenWidth/1.4 - 10
        self.cellHeight = 240
        self.itemsArray = []
        
    }
    
    public func initCollectionView() {
        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: frameworkBundle), forCellWithReuseIdentifier: "CustomCollectionViewCell")

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
}

// MARK: - COLLECTION VIEW DELEGATE AND DATA SOURCE

extension HorizontalSliderView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = self.itemsArray.count
        return itemsArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.imageCell.image = self.itemsArray[indexPath.row].imageCell
        cell.labelText.text = self.itemsArray[indexPath.row].stringCell
        cell.tag = indexPath.row
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let screenWidth = self.view.bounds.width
        return CGSize(width: self.cellWidth,height: self.cellHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.tappedOnCell(row: indexPath.row, section: indexPath.section)
    }
    
    // MARK: - SCROLL VIEW DELEGATE
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = self.collectionView.visibleCells
        for cell in cells {
            let cellFrame = cell.frame
            let window = self.window!
            let rect = window.convert(cellFrame, from: cell.superview!)
            let inter = rect.intersection(window.bounds)
            let ratio = (inter.width * inter.height) / (cellFrame.width * cellFrame.height)
            let rep = ((Int(ratio * 100)))
            if rep > 50 {
                self.pageControl.currentPage = cell.tag
            }
        }
    }
}

var frameworkBundle:Bundle? {
    let bundleId = "com.test.app123.CustomCollectionView"
    return Bundle(identifier: bundleId)
}
