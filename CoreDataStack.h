//
//  Created by Martin Nash on 2/26/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface CoreDataStack : NSObject

/// creates new in-memory stack
+(CoreDataStack*)inMemoryStack;

/// creates new sqlite stack
+(CoreDataStack*)sqliteStack;


/// moc for interacting with your core data stack
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;



// Exposing to enable overriding in subclass
-(NSString*)dataModelName;
-(NSString*)appReverseDomainIdentifier;
-(NSString*)dataFileNameWithExtension;
-(NSSearchPathDirectory)searchPathDirectory;


@end
