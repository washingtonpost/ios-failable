//
//  ViewController.swift
//  FailableExample
//
//  Created by Davis, William on 5/23/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

import UIKit
import Failable
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var charactersArray: [MarvelCharacter]?

    override func viewDidLoad() {
        super.viewDidLoad()

        //ToNEVERDo add pagination
        FailableAPIExample.instance.getMarvelCharacters { [weak self] (data) in
            guard let strongSelf = self else {
                return
            }

            switch data {
                case .Success(let characters):
                    strongSelf.charactersArray = characters
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        strongSelf.tableView.reloadData()
                    })
                case .Failure(let error):
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let error = error as? FailableError {
                            strongSelf.presentAlert(error.description)
                        }
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
        return charactersArray?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "BasicCell"

        let  cell = tableView.dequeueReusableCellWithIdentifier(identifier) ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)

        guard let name = charactersArray?[indexPath.row].name,
            imageURL = charactersArray?[indexPath.row].thumbnailURL else {
            return cell
        }

        if let textLabel = cell.textLabel,
            imageView = cell.imageView {
                textLabel.text = name
                imageView.af_setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"), filter: nil, imageTransition: .None, completion: { (response) -> Void in
                    // if needed
                })
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
