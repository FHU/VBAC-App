//
//  HospitalCell.h
//  Cesarean Rates
//
//  Created by Richard Simpson on 2/23/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentLabel;

@end
