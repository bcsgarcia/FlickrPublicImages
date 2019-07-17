//
//  PhotoCell.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var ivPhoto: UIImageView!
    
    
    var photoCellViewModel: PhotoCellViewModel! {
        didSet {
            if self.photoCellViewModel.imageSizeList.count == 0 {
                photoCellViewModel.getImageList { (sizeList) in
                    self.photoCellViewModel.imageSizeList = sizeList
                    self.ivPhoto.loadImageUsingUrlString(urlString: sizeList[4].source)
                }
            } else {
                self.ivPhoto.loadImageUsingUrlString(urlString: self.photoCellViewModel.imageSizeList[4].source)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        // Reset the cell for new row's data
        //self.ivPhoto.image = nil
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
    
