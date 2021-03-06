//
//  SQLStringModel.m
//  MessageUnit
//
//  Created by Jackdx on 2017/9/12.
//  Copyright © 2017年 UBTECH. All rights reserved.
//
#define SQLStringModel_isEmptyString(string) ((string == nil || string.length == 0) ? YES : NO)

#import "SQLStringModel.h"

@interface NSString (SQL)

- (NSString *)stringWithSQLParams:(NSDictionary *)params;

@end


@implementation NSString (SQL)

- (NSString *)stringWithSQLParams:(NSDictionary *)params
{
    NSMutableArray *keyList = [[NSMutableArray alloc] init];
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@":[\\w]*" options:0 error:NULL];
    NSArray *list = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    [list enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull checkResult, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *subString = [self substringWithRange:checkResult.range];
        [keyList addObject:[subString substringWithRange:NSMakeRange(1, subString.length-1)]];
    }];
    
    NSMutableString *resultString = [self mutableCopy];
    [keyList enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (params[key]) {
            NSRegularExpression *expressionForReplace = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@":%@\\b", key] options:0 error:NULL];
            NSString *value = [NSString stringWithFormat:@"%@", params[key]];
            if ([params[key] isKindOfClass:[NSString class]] && [keyList containsObject:params[key]] == NO && [key isEqualToString:@"primaryKeyValueListString"] == NO) {
                value = [NSString stringWithFormat:@"'%@'", params[key]];
            }
            [expressionForReplace replaceMatchesInString:resultString options:0 range:NSMakeRange(0, resultString.length) withTemplate:value];
        }
    }];
    
    return resultString;
}
@end

@implementation SQLStringModel

//create table sql
+ (NSString *)createTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo {
    if(SQLStringModel_isEmptyString(tableName) || columnInfo == nil) return nil;
    NSMutableArray *columnList = [NSMutableArray array];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *safeColumnName = key;
        NSString *safeDescription = obj;
        
        if(SQLStringModel_isEmptyString(safeDescription)) {
            [columnList addObject:[NSString stringWithFormat:@"'%@'", safeColumnName]];
        }else {
            [columnList addObject:[NSString stringWithFormat:@"'%@' %@", safeColumnName, safeDescription]];
        }
    }];
    
    NSString *columns = [columnList componentsJoinedByString:@","];
    
    return [[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (%@);", tableName, columns] copy];
}


+ (NSString *)dropTable:(NSString *)tableName {
    if(SQLStringModel_isEmptyString(tableName)) return nil;
    return [[NSString stringWithFormat:@"DROP TABLE IF EXISTS '%@';",tableName] copy];
}


+ (NSString *)addColumn:(NSString *)columnName columnInfo:(NSString *)columnInfo tableName:(NSString *)tableName {
    if(SQLStringModel_isEmptyString(columnName) || SQLStringModel_isEmptyString(columnInfo) || SQLStringModel_isEmptyString(tableName)) {
        return  nil;
    }
    return [NSString stringWithFormat:@"ALTER TABLE '%@' ADD COLUMN '%@' %@;", tableName, columnName, columnInfo];
}


//insert sql
+ (NSString *)insertTable:(NSString *)tableName withDataList:(NSArray *)dataList {
    if(SQLStringModel_isEmptyString(tableName) || dataList == nil) return nil;
    NSMutableArray *valueItemList = [NSMutableArray array];
    __block NSString *columString = nil;
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull description, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *columList = [NSMutableArray array];
        NSMutableArray *valueList = [NSMutableArray array];
        
        [description enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, id _Nonnull value, BOOL * _Nonnull stop) {
            [columList addObject:[NSString stringWithFormat:@"'%@'", colum]];
            
            if ([value isKindOfClass:[NSNull class]]) {
                [valueList addObject:@"NULL"];
            } else if([value isKindOfClass:[NSString class]]){
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            } else{
                [valueList addObject:[NSString stringWithFormat:@"%@", value]];
            }
        }];
        if (columString == nil) {
            columString = [columList componentsJoinedByString:@","];
        }
        NSString *valueString = [valueList componentsJoinedByString:@","];
        [valueItemList addObject:[NSString stringWithFormat:@"(%@)", valueString]];
    }];
    
    return [[NSString stringWithFormat:@"INSERT INTO '%@' (%@) VALUES %@;",tableName, columString, [valueItemList componentsJoinedByString:@","]] copy];
}



//update sql
+ (NSString *)updateTable:(NSString *)tableName withData:(NSDictionary *)data condition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams {
    NSMutableArray *valueList = [NSMutableArray array];
    [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, id  _Nonnull value, BOOL * _Nonnull stop) {
        if([value isKindOfClass:[NSString class]]) {
            [valueList addObject:[NSString stringWithFormat:@"'%@'='%@'", colum, value]];
        }else if ([value isKindOfClass:[NSNull class]]) {
            [valueList addObject:[NSString stringWithFormat:@"'%@'=NULL", colum]];
        } else {
            [valueList addObject:[NSString stringWithFormat:@"'%@'=%@", colum, value]];
        }
    }];
    NSString *valueString = [valueList componentsJoinedByString:@","];

    NSString *sqlString = [NSString stringWithFormat:@"UPDATE '%@' SET %@ ", tableName, valueString];
    
    return [[NSString stringWithFormat:@"%@%@", sqlString,[SQLStringModel where:condition params:conditionParams]] copy];
    
}


//delete sql
+ (NSString *)deleteTable:(NSString *)tableName withCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams {
    if(SQLStringModel_isEmptyString(tableName)) return nil;
    
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM '%@' ",tableName];
    
    return [[NSString stringWithFormat:@"%@%@", sqlString, [SQLStringModel where:condition params:conditionParams]] copy];
}




//fetch sql
+ (NSString *)select:(NSString *)columList isDistinct:(BOOL)isDistinct {
    if (columList == nil) {
        if (isDistinct) {
            return [[NSString stringWithFormat:@"SELECT DISTINCT * "] copy];
        } else {
            return [[NSString stringWithFormat:@"SELECT * "] copy];
        }
    } else {
        if (isDistinct) {
            return [[NSString stringWithFormat:@"SELECT DISTINCT '%@' ", columList] copy];
        } else {
            return [[NSString stringWithFormat:@"SELECT '%@' ",columList] copy];
        }
    }
}

+ (NSString *)from:(NSString *)fromList {
    if (fromList == nil) {
        return nil;
    }
    return [[NSString stringWithFormat:@"FROM '%@' ", fromList] copy];
}

+ (NSString *)where:(NSString *)condition params:(NSDictionary *)params {
    if (condition == nil) {
        return nil;
    }
    NSString *whereString = [condition stringWithSQLParams:params];
    return [[NSString stringWithFormat:@"WHERE %@ ",whereString] copy];
}

+ (NSString *)orderBy:(NSString *)orderBy isDESC:(BOOL)isDESC {
    if (orderBy == nil) {
        return nil;
    }
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendFormat:@"ORDER BY %@ ", orderBy];
    if (isDESC) {
        [sqlString appendString:@"DESC "];
    } else {
        [sqlString appendString:@"ASC "];
    }
    return sqlString.copy;
}

+ (NSString *)limit:(NSInteger)limit {
    if (limit == -1) {
        return nil;
    }
    return [[NSString stringWithFormat:@"LIMIT %lu ",(unsigned long)limit] copy];
}

+ (NSString *)offset:(NSInteger)offset {
    if (offset == -1) {
        return nil;
    }
    return [[NSString stringWithFormat:@"OFFSET %lu ",(unsigned long)offset] copy];
}

+ (NSString *)limit:(NSInteger)limit offset:(NSInteger)offset {
    NSString *str1 = [SQLStringModel  limit:limit];
    NSString *str2 = [SQLStringModel offset:offset];
    return [[NSString stringWithFormat:@"%@%@", str1, str2] copy];
}

+ (NSString *)countAll {
    return [[NSString stringWithFormat:@"SELECT COUNT(*) "] copy];
}







@end
