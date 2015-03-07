//
//  ConfigurableCoreDataStack.h
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

@import CoreData;
@class CoreDataStackConfiguration;
@protocol StackConfigurator;

/// Stack can be configured
@interface ConfigurableCoreDataStack : NSObject

-(instancetype)initWithConfiguration:(CoreDataStackConfiguration*)configuration;
-(instancetype)initWithConfigurator:(id<StackConfigurator>)configurator;
+(instancetype)stackWithConfiguration:(CoreDataStackConfiguration*)configuration;
+(instancetype)stackWithConfigurator:(id<StackConfigurator>)configurator;

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, readonly, nonatomic) NSURL* dataFileURL;

-(void)removeCoreDataFilesFromDisk;

@end
