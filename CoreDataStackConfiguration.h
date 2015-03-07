//
//  CoreDataStackConfiguration.h
//  Pods
//
//  Created by Martin Nash on 3/5/15.
//
//

@import Foundation;


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
+(instancetype)configurationWithStoreType:(NSString*)storeType modelName:(NSString*)modelName appIdentifier:(NSString*)appid dataFileNameWithExtension:(NSString*)dataFileName searchPathDirectory:(NSSearchPathDirectory)spd;
@property (copy, nonatomic) NSString *storeType;
@property (copy, nonatomic) NSString *modelName;
@property (copy, nonatomic) NSString *appIdentifier;
@property (copy, nonatomic) NSString *dataFileNameWithExtension;
@property (assign, nonatomic) NSSearchPathDirectory searchPathDirectory;
@end


