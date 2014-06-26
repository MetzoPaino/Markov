//
//  EditTextViewController.swift
//  Markov
//
//  Created by William Robinson on 25/06/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

import UIKit

class EditTextViewController: UIViewController {

	@IBOutlet var textView_snippet: UITextView
	var textSnippet = ""
	var indexInBag = 0
	
	init(coder aDecoder: NSCoder!)
	{
		super.init(coder: aDecoder)
	}
	
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
			textView_snippet.text = textSnippet
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func undo(sender: AnyObject) {
		
		if textView_snippet.text != textSnippet {
			
			textView_snippet.text = textSnippet
		}
		
	}
}
