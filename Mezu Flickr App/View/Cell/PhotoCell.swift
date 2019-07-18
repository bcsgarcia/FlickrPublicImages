//
//  PhotoCell.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblFavoriteCount: UILabel!
    @IBOutlet weak var lblComentCount: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    
    var photoCellViewModel: PhotoCellViewModel! {
        didSet {
            
            self.lblComentCount.text = self.photoCellViewModel.photo.count_comments
            self.lblFavoriteCount.text = self.photoCellViewModel.photo.count_faves
            self.lblUsername.text = self.photoCellViewModel.photo.title//self.photoCellViewModel.person.username._content
            
            
            self.ivPhoto.loadImageUsingUrlString(urlString: self.photoCellViewModel.photo.url_n)
            if let url = self.photoCellViewModel.person.profileUrl {
                self.ivProfile.loadImageUsingUrlString(urlString: url )
            }
            
            self.ivProfile.layer.cornerRadius = 18.0
            self.ivProfile.layer.masksToBounds = true
            //self.ivProfile.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
            //self.ivProfile.layer.borderWidth = 1.0;
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        // Reset the cell for new row's data
        //self.ivPhoto.image = #imageLiteral(resourceName: "flickr-icon-logo.png")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
    
