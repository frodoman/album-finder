//
//  AlbumDetailsViewController.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 02/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import UIKit
import AlbumSDK
import SafariServices

final class AlbumDetailsViewController: BaseViewController {

    public let albumInfo: AlbumInfo
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DesignConst.Margins.normal
        return stackView
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        
        return scrollView
    }()
    
    private lazy var buttonMoreInfo: UIButton = {
        let infoButton = UIButton(frame: .zero)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.setTitle("More Information", for: .normal)
        infoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: DesignConst.Fonts.medium)
        infoButton.setTitleColor(UIColor.black, for: .normal)
        infoButton.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        infoButton.addTarget(self, action: #selector(buttonMoreInfoTapped), for: .touchUpInside)
        infoButton.accessibilityIdentifier = AccessibilityIDs.detailsButton
        
        return infoButton
    }()
    
    init(with albumDetail: AlbumInfo) {
        self.albumInfo = albumDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - UI
    private func setupSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = albumInfo.name
        
        self.view.addSubview(mainScrollView)
        
        setupAlbumDetailView()
        setupConstraints()
    }
    
    private func setupAlbumDetailView() {
        
        // add a photo
        if let imgUrl = self.albumInfo.image?.first(where: {$0.size == .extralarge })?.text {
            let imageView = UIImageView(frame: .zero)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.imageFrom(urlString: imgUrl)
            imageView.heightAnchor.constraint(equalToConstant: DesignConst.Margins.imageHeight).isActive = true
            imageView.accessibilityIdentifier = AccessibilityIDs.detailsImage
            
            self.mainStackView.addArrangedSubview(imageView)
        }
        
        // add artist
        if let artist = self.albumInfo.artist {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: DesignConst.Fonts.medium)
            label.text = "Artist: " + artist
            label.textAlignment = .center
            label.accessibilityIdentifier = AccessibilityIDs.detailsName
            self.mainStackView.addArrangedSubview(label)
        }
        
        // add a button for more information
        self.mainStackView.addArrangedSubview(buttonMoreInfo)
    }
    
    private func setupConstraints() {
        self.mainScrollView.pinToSuperviewSafeEdges()
        self.mainStackView.pinToSuperviewEdges()
        
        // make the stack view scrollable
        self.mainStackView.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor, multiplier: 1.0).isActive = true
        self.mainStackView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width,
                                                 height: self.mainStackView.frame.size.height)
    }
    
    //MARK: - Actions
    @objc private func buttonMoreInfoTapped(_ sender: UIButton) {
        if let infoUrl = self.albumInfo.url {
            let webViewController = SFSafariViewController(url: URL(string: infoUrl)!)
            present(webViewController, animated: true) {}
        }
    }
}
