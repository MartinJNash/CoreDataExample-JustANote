//
//  Note.m
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "Note.h"


@implementation Note

@dynamic contents;
@dynamic creationDate;

-(void)awakeFromInsert
{
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
    self.contents = @"";
}

@end
