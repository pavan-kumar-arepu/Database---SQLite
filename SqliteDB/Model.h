//
//  Model.h
//  
//
//  Created by Pavankumar Arepu on 12/10/2015.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface Model : NSObject
+(Model *)sharedModel;

-(void)creatingDB;
-(BOOL)validateLoinCredentials:(NSString*)userName andPassword:(NSString*)password;
-(NSMutableArray*)fetchStudentData;
-(int)insertStudentData:(NSString *)course withName:(NSString *)name withDuration:(NSString *)duration;

@end
