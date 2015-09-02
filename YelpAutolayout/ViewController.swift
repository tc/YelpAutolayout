//
//  ViewController.swift
//  YelpAutolayout
//
//  Created by Tommy Chheng on 9/1/15.
//  Copyright (c) 2015 Tommy Chheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!

    let yelpClient = YelpClient.sharedInstance
    var businesses:[Business] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.delegate = self
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
   
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        updateData("mexican")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Search
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        updateData(searchBar.text)
    }

    //MARK: Data
    func updateData(term:String) {
        Business.searchWithTerm(term, sort: .Distance, categories: [], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    func showErrorView() {
        let errorLabel = UILabel(frame: CGRectMake(self.view.frame.width / 2 - 100, 20, 200, 20))
        errorLabel.backgroundColor = UIColor.grayColor()
        errorLabel.text = "Error Loading"
        self.tableView.addSubview(errorLabel)
    }
    
    //MARK: Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SearchResultTableCell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! SearchResultTableCell
        
        let business = self.businesses[indexPath.row]
        
        cell.titleLabel?.text = business.name
        cell.photoThumbView.setImageWithURL(business.imageURL)
        cell.addressLabel.text = business.address
        cell.categoriesLabel.text = business.categories
        cell.reviewCountLabel.text = "\(business.reviewCount!) Reviews"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    //Mark: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationView = segue.destinationViewController as! BusinessDetailViewController
        let indexPath = tableView.indexPathForCell(sender as! SearchResultTableCell)!
        
        let business = businesses[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        destinationView.business = business
    }

}

