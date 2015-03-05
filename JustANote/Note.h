//
//  Note.h
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, strong) NSString * contents;
@property (nonatomic, strong) NSDate *creationDate;

@end
