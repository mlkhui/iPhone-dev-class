//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by Ken Hui on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;
@interface HomepwnerItemCell : UITableViewCell {
	UILabel *valueLabel;
	UILabel *nameLabel;
	UIImageView *imageView;
}

-(void)setPossession:(Possession *)possession;
@end
