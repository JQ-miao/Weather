//
//  WeatherCell.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2016年 himjq.com. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var w_image: UIImageView!
    @IBOutlet weak var w_city: UILabel!
    @IBOutlet weak var w_description: UILabel!
    @IBOutlet weak var w_wind: UILabel!
    @IBOutlet weak var w_temperature: UILabel!
    @IBOutlet weak var w_temperature_range: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
