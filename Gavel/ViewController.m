#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSDynamoDB/AWSDynamoDB.h>

#import "ViewController.h"
#import "GIQuestionView.h"
#import "GIMakeQuestionViewController.h"
#import "GIQuestionController.h"

@interface ViewController ()<GIQuestionDelegate, GIQuestionDisplay>

@end

@implementation ViewController

- (void)loadView {
    GIQuestionAnswerModel *question = [[GIQuestionController questionController] nextQuestionQuestionDisplay:self];
    if (question) {
        self.view = [[GIQuestionView alloc] initWithQuestionAnswerModel:question];
        ((GIQuestionView *)self.view).delegate = self;
    } else {
        self.view = [[UIView alloc] init];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:spinner];
        self.view.backgroundColor = [UIColor whiteColor];
        spinner.center = self.view.center;
        [spinner startAnimating];
    }
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

- (void)receivedQuestion:(GIQuestionAnswerModel *)nextQuestion {
    self.view = [[GIQuestionView alloc] initWithQuestionAnswerModel:nextQuestion];
    ((GIQuestionView *)self.view).delegate = self;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(makeNewQuestion)];
}


@end

