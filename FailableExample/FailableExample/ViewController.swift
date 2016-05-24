//
//  ViewController.swift
//  FailableExample
//
//  Created by Davis, William on 5/23/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

import UIKit
import Failable

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var charactersArray: [MarvelCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FailableAPIExample.instance.getMarvelCharacters { [weak self] (data) in
            guard let strongSelf = self else {
                return
            }

            switch data {
                case .Success(let charactersWrapper):
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        strongSelf.charactersArray = charactersWrapper.characters ?? []
                        strongSelf.tableView.reloadData()
                    })
                case .Failure(let error):
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        strongSelf.presentAlert(error.localizedDescription)
                    })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let dismiss = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(dismiss)
        presentViewController(alert, animated: false, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(charactersArray.count)
        return charactersArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "BasicCell"

        let  cell = tableView.dequeueReusableCellWithIdentifier(identifier) ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)

        guard let name = charactersArray[indexPath.row].name else {
            return cell
        }

        cell.textLabel!.text = name
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
