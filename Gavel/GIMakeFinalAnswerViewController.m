#import "GIMakeFinalAnswerViewController.h"

#import "GIFillInView.h"
#import "GIQuestionAnswerModel.h"
#import <AWSDynamoDB/AWSDynamoDB.h>

@interface GIMakeFinalAnswerViewController ()<GIFillDelegate>

@end

@implementation GIMakeFinalAnswerViewController {
    NSString *_questionText;
    NSString *_answerText;
}

- (instancetype)initWithQuestionResult:(NSString *)question answerOne:(NSString *)answerOne {
    self = [super init];
    if (self) {
        _questionText = question;
        _answerText = answerOne;
    }
    return self;
}

- (void)loadView {
    self.view = [[GIFillInView alloc] initWithDescription:@"Answer Two" buttonText:@"Submit"];
    ((GIFillInView *)self.view).delegate = self;
}

- (void)nextTappedWithResult:(NSString *)text {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    GIQuestionAnswerModel *qA = [[GIQuestionAnswerModel alloc] init];
    // We will need to change this to an actual Unique In the future but to get it up and runnign it should work.
    qA.UniqueId = [NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]];
    qA.Timestamp = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
    qA.Question = _questionText;
    qA.FirstAnswer = _answerText;
    qA.SecondAnswer = text;
    qA.VotestFirst = [NSNumber numberWithInteger:0];
    qA.VotestSecond = [NSNumber numberWithInteger:0];
    [[dynamoDBObjectMapper save:qA]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         } else {
             //Do something with task.result or perform other operations.
         }
         return nil;
     }];
}

@end
