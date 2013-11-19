//
//  ViewController.m
//  dbTest
//
//  Created by Lsr on 11/19/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#define DBNAME    @"TDB.sql"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}
- (IBAction)createDatabase:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"TDB.sql"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"fail");
    } else {
        NSLog(@"open OK");
        
    }
}
- (IBAction)createTable:(id)sender {
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
    [self execSql:sqlCreateTable];
}


- (IBAction)insertData:(id)sender {
    NSString *username = @"lsr";
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@') VALUES ('%@')",
                      TABLENAME, NAME,  username];
    
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@') VALUES ('%@')",
                      TABLENAME, NAME, username];
    [self execSql:sql1];
    [self execSql:sql2];
}

- (IBAction)getData:(id)sender {
    
    NSString *sqlQuery = @"SELECT * FROM PERSONINFO";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            
            NSLog(@"name:%@",nsNameStr);
        }
    }
    sqlite3_close(db);
}
- (IBAction)deleteData:(id)sender {
    NSString *sql = @"delete from PERSONINFO where 1!=2";
    [self execSql:sql];
    
}
- (IBAction)dropTable:(id)sender {
    NSString *sql2 = @"DROP TABLE PERSONINFO";
    [self execSql:sql2];
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"fail to operate!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
