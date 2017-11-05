#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSDynamoDB/AWSDynamoDB.h>

#import "ViewController.h"
#import "GIQuestionView.h"
#import "GIMakeQuestionViewController.h"


@interface ViewController ()<GIQuestionDelegate>

@end

@implementation ViewController

- (void)loadView {
    self.view = [[GIQuestionView alloc] initWithQuestion:@"What should I do today?" answer1:@"Play Video Games" answer2:@"Keep working on this project dummy"];
    ((GIQuestionView *)self.view).delegate = self;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(makeNewQuestion)];
}

- (void)makeNewQuestion {
    [self.navigationController pushViewController:[[GIMakeQuestionViewController alloc] init] animated:YES];
}

- (void)nextQuestion {
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

