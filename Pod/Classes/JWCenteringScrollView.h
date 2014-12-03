//
//  JWCenteringScrollView.h
//  Clashogram
//
//  Created by Jack Wu on 2014-11-05.
//  Copyright (c) 2014 Extreme Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kCenteringScrollViewDidScrollNotification = @"kCenteringScrollViewDidScrollNotification";

@interface JWCenteringScrollView : UIScrollView <UIScrollViewDelegate>

@property (assign, nonatomic) CGSize subviewSize;
@property (strong, nonatomic) UIView * subviewContainer;

- (void)updateZoom;
@end
