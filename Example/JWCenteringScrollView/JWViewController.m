//
//  JWViewController.m
//  JWCenteringScrollView
//
//  Created by jackwu on 12/03/2014.
//  Copyright (c) 2014 jackwu. All rights reserved.
//

#import "JWViewController.h"
#import "JWCenteringScrollView.h"

@interface JWViewController ()

@property (weak, nonatomic) IBOutlet JWCenteringScrollView *centeringScrollView;

@end

@implementation JWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage * kid = [UIImage imageNamed:@"kidOnBeach.JPG"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:kid];
    [self.centeringScrollView.subviewContainer addSubview:imageView];
    self.centeringScrollView.subviewSize = imageView.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
