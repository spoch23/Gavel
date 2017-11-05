#import "GIQuestionAnswerModel.h"

@implementation GIQuestionAnswerModel

+ (NSString *)dynamoDBTableName {
    return @"GavelQuestios2";
}

+ (NSString *)hashKeyAttribute {
    return @"UniqueId";
}

@end
