//
//  ConfigurableCoreDataStack.h
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

@import CoreData;


/// Data stack configuration object
@interface CoreDataStackConfiguration : NSObject
@property (strong, nonatomic) NSString *storeType;
@property (strong, nonatomic) NSString *modelName;
@property (strong, nonatomic) NSString *appIdentifier;
@property (strong, nonatomic) NSString *dataFileNameWithExtension;
@property (assign, nonatomic) NSSearchPathDirectory searchPathDirectory;
@end



/// Stack can be configured
@interface ConfigurableCoreDataStack : NSObject
-(instancetype)initWithConfiguration:(CoreDataStackConfiguration*)configuration;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@end
