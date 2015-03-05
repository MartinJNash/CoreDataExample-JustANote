//
//  ConfigurableCoreDataStack.h
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

@import CoreData;


/// Data stack configuration protocol
@protocol StackConfigurator <NSObject>
-(NSString*)storeType;
-(NSString*)modelName;
-(NSString*)appIdentifier;
-(NSString*)dataFileNameWithExtension;
-(NSSearchPathDirectory)searchPathDirectory;
@end



/// Data stack configuration object
@interface CoreDataStackConfiguration : NSObject <StackConfigurator>
-(instancetype)initWithConfigurator:(id<StackConfigurator>)config;
@property (copy, nonatomic) NSString *storeType;
@property (copy, nonatomic) NSString *modelName;
@property (copy, nonatomic) NSString *appIdentifier;
@property (copy, nonatomic) NSString *dataFileNameWithExtension;
@property (assign, nonatomic) NSSearchPathDirectory searchPathDirectory;
@end



/// Stack can be configured
@interface ConfigurableCoreDataStack : NSObject
-(instancetype)initWithConfiguration:(CoreDataStackConfiguration*)configuration;
-(instancetype)initWithConfigurator:(id<StackConfigurator>)configurator;
+(instancetype)stackWithConfiguration:(CoreDataStackConfiguration*)configuration;
+(instancetype)stackWithConfigurator:(id<StackConfigurator>)configurator;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@end
