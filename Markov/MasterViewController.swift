//
//  MasterViewController.swift
//  Markov
//
//  Created by William Robinson on 17/06/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UITextFieldDelegate {

	var detailViewController: DetailViewController? = nil
	var objects = NSMutableArray()
	var textBox = TextBox()
	//var textBox = NSMutableArray()

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}
	
	// #pragma mark - View Controller Configuration

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationItem.leftBarButtonItem = self.editButtonItem()

		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = controllers[controllers.endIndex-1].topViewController as? DetailViewController
		}
		var textSnippetSeuss1 = "Today you are you! That is truer than true! There is no one alive who is you-er than you!"
		var textSnippetSeuss2 = "How did it get so late so soon? Its night before its afternoon. December is here before its June. My goodness how the time has flewn. How did it get so late so soon?"
		var textSnippetSeuss3 = "Don't cry because it's over. Smile because it happened."
		var textSnippetSeuss4 = "Unless someone like you cares a whole awful lot, nothing is going to get better. It's not."
		var textSnippetSeuss5 = "Think left and think right and think low and think high. Oh, the thinks you can think up if only you try!"
		
		
		var textSnippetEinstein1 = "Look deep into nature, and then you will understand everything better."
		var textSnippetEinstein2 = "When you are courting a nice girl an hour seems like a second. When you sit on a red-hot cinder a second seems like an hour. That's relativity."
		var textSnippetEinstein3 = "Insanity: doing the same thing over and over again and expecting different results."
		var textSnippetEinstein4 = "Gravitation is not responsible for people falling in love."
		var textSnippetEinstein5 = "A person who never made a mistake never tried anything new."
		
		objects .addObject(textSnippetSeuss1)
		
		var seussTextBag = TextBag(name: "Dr Seuss")
		seussTextBag.bag = [textSnippetSeuss1, textSnippetSeuss2, textSnippetSeuss3, textSnippetSeuss4, textSnippetSeuss5]
		
		var einsteinTextBag = TextBag(name: "Albert Einstein")
		einsteinTextBag.bag = [textSnippetEinstein1, textSnippetEinstein2, textSnippetEinstein3, textSnippetEinstein4, textSnippetEinstein5]
		
		
		textBox.box = [seussTextBag, einsteinTextBag]
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func insertNewObject(sender: AnyObject) {
		if textBox == nil {
		    //textBox = NSMutableArray()
		}
		//objects.insertObject(NSDate.date(), atIndex: 0)
		
		textBox.box.insert(TextBag(name: "ihdjhdfjh"), atIndex: 0)
		
		let indexPath = NSIndexPath(forRow: 0, inSection: 0)
		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		
		
	}

	func textFieldShouldBeginEditing(_textField: UITextField!) -> Bool {
		
		var textfield = _textField
		
		textfield.isFirstResponder()
		return true
	}

	
	// #pragma mark - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    let indexPath = self.tableView.indexPathForSelectedRow()
//		    let object = objects[indexPath.row] as NSDate
//		    ((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).detailItem = object
//			
			
			var bag = textBox.box[indexPath.row]
			println(textBox.box[indexPath.row])
			println(indexPath.row)
			
			((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).textBag = bag
		}
	}
	
	// #pragma mark - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 44
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
				
		return textBox.box.count
	}
	
	override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
		
		return 44
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TextSnippetCell
		
		var textBag = textBox.box[indexPath.row]
		cell.name.text = textBag.name
		
		if indexPath.row == 0 {
			
			cell.name.isFirstResponder()
			
		}
		return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
		    textBox.box.removeAtIndex(indexPath.row)// removeObjectAtIndex(indexPath.row)
		    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
		    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    let object = objects[indexPath.row] as NSDate
		    self.detailViewController!.detailItem = object
			var bag = textBox.box[indexPath.row]
			self.detailViewController!.textBag = bag
			
			
		}
	}
}

class TextBag {
	
	let name: String
	var bag: String[] = []
	
	init(name:String) {
		
		self.name = name
	}
}

class TextBox {
	
	var box: TextBag[] = []
	
}