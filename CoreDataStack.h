//
//  CoreDataStack.h
//  DataBoom
//
//  Created by Martin Nash on 2/26/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface CoreDataStack : NSObject
+(CoreDataStack*)inMemoryStack;
+(CoreDataStack*)sqliteStack;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
