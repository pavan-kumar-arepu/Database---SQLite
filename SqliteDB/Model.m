//
//  Model.m
//  
//
//  Created by Pavankumar Arepu on 12/10/2015.
//
//

#import "Model.h"

@interface Model()
{
    sqlite3 *database;
    sqlite3_stmt *statement;
}

@end

@implementation Model

static Model *sharedModel = nil;
+(Model *)sharedModel
{
    @synchronized(self)
    {
        if (sharedModel == nil)
        {
            sharedModel =[[Model alloc] init]; // assignment not done here
        }
    }
    return sharedModel;
}



-(void)creatingDB
{
    
    Model *model1 = [[Model alloc]init];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *writableDBPath = [self getDocumentaryPath];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (success)
        success=[fileManager removeItemAtPath:writableDBPath error:&error];
    //return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]
                              stringByAppendingPathComponent:@"student.sqlite"];
    
    success = [fileManager copyItemAtPath:defaultDBPath
                                   toPath:writableDBPath
                                    error:&error];
}

-(NSString *)getDocumentaryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"student.sqlite"];
}

-(BOOL)validateLoinCredentials:(NSString*)userName andPassword:(NSString*)password
{
    BOOL success;
    NSString *sqliteDBFilePath = [self getDocumentaryPath];
    
    if (sqlite3_open([sqliteDBFilePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *loginQuery = [NSString stringWithFormat:@"SELECT * FROM logintable where UserID=\"%@\" and LoginPassword=\"%@\"",userName,password];
        
        if (sqlite3_prepare_v2(database, [loginQuery UTF8String], -1, &statement, NULL) ==  SQLITE_OK)
            {
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                    success=YES;
                }
            }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return success;
}




-(NSMutableArray *)fetchStudentData
{

        int rc=0;
    
    NSMutableArray *employeeNameArray = [[NSMutableArray alloc]init];
    
    NSString *sqliteDBFilePath = [self getDocumentaryPath];
    
    if (sqlite3_open([sqliteDBFilePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *selectQuery = @"SELECT * from student";
        
        
        rc =sqlite3_prepare_v2(database, [selectQuery UTF8String], -1, &statement, NULL);
        if(rc == SQLITE_OK)
        {
        while (sqlite3_step(statement) == SQLITE_ROW) //get each row in loop
         {
                NSMutableDictionary *nameDict = [[NSMutableDictionary alloc]init];
                [nameDict setValue:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(statement, 0)] forKey:@"name"];
                [nameDict setValue:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(statement, 1)] forKey:@"course"];
                [nameDict setValue:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(statement, 2)] forKey:@"duration"];

                [employeeNameArray addObject:nameDict];
            }
        }
    }
    
    NSLog(@"employeeName Arrya:%@",employeeNameArray);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return employeeNameArray;
}


-(int)insertStudentData:(NSString *)course withName:(NSString *)name withDuration:(NSString *)duration{
    sqlite3* db = NULL;
    int rc=0;
    NSString *sqliteDBFilePath = [self getDocumentaryPath];

    rc = sqlite3_open_v2([sqliteDBFilePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"INSERT INTO student(name,course,duration) VALUES (\"%@\",\"%@\",\"%@\")",name,course,duration];
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert record  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(db);
    }
    return rc;
}

@end
