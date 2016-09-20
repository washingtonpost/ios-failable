//
//  ViewController.swift
//  FailableExample
//
//  Copyright (c) 2016 The Washington Post
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
                case .success(let characters):
                    strongSelf.charactersArray = characters
                    DispatchQueue.main.async(execute: { () -> Void in
                        strongSelf.tableView.reloadData()
                    })
                case .failure(let error):
                    DispatchQueue.main.async(execute: { () -> Void in
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

    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: false, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BasicCell"

        let  cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)

        guard let name = charactersArray?[(indexPath as NSIndexPath).row].name,
            let imageURL = charactersArray?[(indexPath as NSIndexPath).row].thumbnailURL else {
            return cell
        }

        if let textLabel = cell.textLabel,
            let imageView = cell.imageView {
                textLabel.text = name
                imageView.af_setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"), filter: nil, imageTransition: .None, completion: { (response) -> Void in
                    // if needed
                })
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
