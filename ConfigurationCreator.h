//
//  ConfigurationCreator.h
//  JustANote
//
//  Created by Martin Nash on 3/5/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStackConfiguration;


// Helper class to encapsulate stack configuration options

@interface ConfigurationCreator : NSObject
+(CoreDataStackConfiguration*)inMemoryStackConfiguration;
+(CoreDataStackConfiguration*)sqliteStackConfiguration;
+(CoreDataStackConfiguration*)alternativeSqliteStackConfiguration;
@end
