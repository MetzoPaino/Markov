//
//  DetailViewController.swift
//  Markov
//
//  Created by William Robinson on 17/06/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISplitViewControllerDelegate {

	@IBOutlet var detailDescriptionLabel: UILabel
	@IBOutlet var tableView: UITableView
	var masterPopoverController: UIPopoverController? = nil

	var textBag = TextBag(name: "")

	var detailItem: AnyObject? {
		didSet {
		    // Update the view.
		    self.configureView()

		    if self.masterPopoverController != nil {
		        self.masterPopoverController!.dismissPopoverAnimated(true)
		    }
		}
	}

	func configureView() {
		// Update the user interface for the detail item.
		if let detail: AnyObject = self.detailItem {
		    if let label = self.detailDescriptionLabel {
		        label.text = detail.description
		    }
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// #pragma mark - Split view

	func splitViewController(splitController: UISplitViewController, willHideViewController viewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController popoverController: UIPopoverController) {
	    barButtonItem.title = "Master" // NSLocalizedString(@"Master", @"Master")
	    self.navigationItem.setLeftBarButtonItem(barButtonItem, animated: true)
	    self.masterPopoverController = popoverController
	}

	func splitViewController(splitController: UISplitViewController, willShowViewController viewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
	    // Called when the view is shown again in the split view, invalidating the button and popover controller.
	    self.navigationItem.setLeftBarButtonItem(nil, animated: true)
	    self.masterPopoverController = nil
	}
	func splitViewController(splitController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
	    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
	    return true
	}
	
	// #pragma mark - Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Edit Text" {
			
			let indexPath = self.tableView.indexPathForSelectedRow()
			var snippet = textBag.bag[indexPath.row]
			
			//let viewController = segue.destinationViewController as EditTextViewController
			var navigationController = segue.destinationViewController as UINavigationController
			
			var viewController = navigationController.topViewController as EditTextViewController

			//((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).textBag = bag
			
			
			viewController.textSnippet = snippet
			viewController.indexInBag = indexPath.row
			
		}
		
		if segue.identifier == "Scramble Text" {
		
			var navigationController = segue.destinationViewController as UINavigationController
			
			var viewController = navigationController.topViewController as ScrambledTextCollectionViewController
			
			viewController.scrambledArray = textBag.bag
		}
	}
	
	// #pragma mark - Table View
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	 func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 44
	}
	
	 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return textBag.bag.count
	}
	
	 func tableView(tableView: UITableView!, estimatedheightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
				
		return 44
	}
	
	 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TextSnippetCell
		cell.label.font = UIFont .preferredFontForTextStyle(UIFontTextStyleBody)
		cell.label.text = textBag.bag[indexPath.row]
		
		cell.label.numberOfLines = 20
		
		return cell
	}
	
	 func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	 func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			//textBag.bag.removeObjectAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}
	
	 func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}

}

