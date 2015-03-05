//
//  CoreDataChangeObserver.h
//  Inventory
//
//  Created by Martin Nash on 3/2/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^InsertionBlock)(NSManagedObject* object, NSUInteger newIndex);
typedef void(^DeletionBlock)(NSManagedObject* object, NSUInteger oldIndex);
typedef void(^MovementBlock)(NSManagedObject* object, NSUInteger oldIndex, NSUInteger newIndex);
typedef void(^MultipleDeletionBlock)(NSArray* objects, NSIndexSet *indexes);
typedef void(^VoidBlock)();

@interface CoreDataChangeObserver : NSObject

-(instancetype)initWithFetchRequest:(NSFetchRequest*)fr andMoc:(NSManagedObjectContext*)moc;
-(void)performFetch;

@property (strong, nonatomic, readonly) NSManagedObjectContext *moc;
@property (strong, nonatomic, readonly) NSArray *fetchedObjects;

// Callbacks
@property (copy, nonatomic) VoidBlock beginChangesHandler;
@property (copy, nonatomic) VoidBlock endChangesHandler;
@property (copy, nonatomic) InsertionBlock insertionHandler;
@property (copy, nonatomic) MovementBlock movementHandler;
@property (copy, nonatomic) DeletionBlock deletionHandler;
@property (copy, nonatomic) MultipleDeletionBlock multipleDeletionHandler;
@end
