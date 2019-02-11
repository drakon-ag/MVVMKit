/*
 GiphyMasterDetailViewController.swift
 
 Copyright (c) 2019 Alfonso Grillo
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import MVVMKit

class GiphyMasterDetailViewController: UIViewController, ViewModelOwner {
    typealias CustomViewModel = GiphyMasterDetailViewModel
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    var viewModel: GiphyMasterDetailViewModel? {
        didSet { viewModel?.binder = self }
    }
    
    func bind(viewModel: GiphyMasterDetailViewModel) {
        guard let stringUrl = viewModel.imageViewUrl, let url = URL(string: stringUrl) else { return }
        imageView.setGifImage(withUrl: url)
        activityIndicatorView.startAnimating()
        imageView.setGifImage(withUrl: url) { [weak self] _ in
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? GiphyViewController {
            let embeddedViewModel = GiphyViewModel()
            destinationViewController.viewModel = embeddedViewModel
            embeddedViewModel.delegate = viewModel
        }
    }
}