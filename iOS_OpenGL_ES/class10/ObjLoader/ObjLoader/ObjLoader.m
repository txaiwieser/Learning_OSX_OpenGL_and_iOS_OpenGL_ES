//
//  ObjLoader.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "ObjLoader.h"
#import "Material.h"
#import "ModelObject.h"

@implementation ObjLoader

+ (BOOL)processMtlPath:(NSString *)mtlPath objPath:(NSString *)objPath headerPath:(NSString *)headerPath implPath:(NSString *)implPath baseName:(NSString *)baseName error:(NSError **)error {

    NSString *mtlString = [NSString stringWithContentsOfFile:mtlPath encoding:NSASCIIStringEncoding error:error];
    if (!mtlString) return FALSE;
    
    NSString *objString = [NSString stringWithContentsOfFile:objPath encoding:NSASCIIStringEncoding error:error];
    if (!objString) return FALSE;
    
    //NSLog(@"MTL");
    //NSLog(@"---");
    //NSLog(@"%@", mtlString);
    
    NSDictionary *materials = [self materialsFromString:mtlString];
    //NSLog(@"Materials: %@", materials);
    
    //NSLog(@"OBJ");
    //NSLog(@"---");
    //NSLog(@"%@", objString);
    
    NSDictionary *objects = [self objectsFromString:objString materials:materials];
    //NSLog(@"Objects: %@", objects);
    
    NSString *header = [self headerFromObjects:objects];
    BOOL success = [header writeToFile:headerPath atomically:YES encoding:NSUTF8StringEncoding error:error];
    if (!success) return FALSE;
    
    NSString *impl = [self implementationFromObjects:objects baseName:baseName];
    success = [impl writeToFile:implPath atomically:YES encoding:NSUTF8StringEncoding error:error];
    if (!success) return FALSE;
    
    return TRUE;

}

+ (NSDictionary *)materialsFromString:(NSString *)mtlString {

    Material *material = nil;
    NSMutableDictionary * materials = [NSMutableDictionary dictionary];

    NSArray *lines = [mtlString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString * line in lines) {
    
        NSArray *components = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (components.count < 1) continue;
        
        NSString *command = (NSString *) components[0];
        if ([command isEqualToString:@"newmtl"]) {
            if (components.count < 2) continue;
            if (material) {
                [materials setObject:material forKey:material.name];
            }
            material = [[Material alloc] init];
            material.name = [components[1] stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        }
        if ([command isEqualToString:@"Ns"]) {
            if (components.count < 2) continue;
            material.shininess = [components[1] floatValue];
        }
        if ([command isEqualToString:@"Ka"]) {
            if (components.count < 4) continue;
            material.ambientR = [components[1] floatValue];
            material.ambientG = [components[2] floatValue];
            material.ambientB = [components[3] floatValue];
        }
        if ([command isEqualToString:@"Kd"]) {
            if (components.count < 4) continue;
            material.diffuseR = [components[1] floatValue];
            material.diffuseG = [components[2] floatValue];
            material.diffuseB = [components[3] floatValue];
        }
        if ([command isEqualToString:@"Ks"]) {
            if (components.count < 4) continue;
            material.specularR = [components[1] floatValue];
            material.specularG = [components[2] floatValue];
            material.specularB = [components[3] floatValue];
        }
        if ([command isEqualToString:@"d"]) {
            if (components.count < 2) continue;
            material.alpha = [components[1] floatValue];
        }        
    }
    if (material) {
        [materials setObject:material forKey:material.name];
    }
    
    return materials;
    
}

+ (NSDictionary *)objectsFromString:(NSString *)objectString materials:(NSDictionary *)materials {

    ModelObject *modelObject = nil;
    ModelObjectPart *modelObjectPart = nil;
    NSMutableDictionary * modelObjects = [NSMutableDictionary dictionary];

    NSArray *lines = [objectString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString * line in lines) {
    
        NSArray *components = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (components.count < 1) continue;
        
        NSString *command = components[0];
        if ([command isEqualToString:@"o"]) {
            if (components.count < 2) continue;
            if (modelObject) {
                [modelObjects setObject:modelObject forKey:modelObject.name];
            }
            modelObject = [[ModelObject alloc] init];
            modelObject.name = [components[1] stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        }
        if ([command isEqualToString:@"v"]) {
            if (components.count < 4) continue;
            Vector3 *vector = [[Vector3 alloc] init];
            vector.x = [components[1] floatValue];
            vector.y = [components[2] floatValue];
            vector.z = [components[3] floatValue];
            [modelObject.vertices addObject:vector];
        }
        if ([command isEqualToString:@"vt"]) {
            if (components.count < 3) continue;
            Vector2 *vector = [[Vector2 alloc] init];
            vector.x = [components[1] floatValue];
            vector.y = [components[2] floatValue];
            [modelObject.textureCoords addObject:vector];
        }
        if ([command isEqualToString:@"vn"]) {
            if (components.count < 4) continue;
            Vector3 *vector = [[Vector3 alloc] init];
            vector.x = [components[1] floatValue];
            vector.y = [components[2] floatValue];
            vector.z = [components[3] floatValue];
            [modelObject.normals addObject:vector];
        }
        if ([command isEqualToString:@"usemtl"]) {
            if (components.count < 2) continue;
            NSString *materialName = components[1];
            if (modelObjectPart) {
                [modelObject.modelObjectParts addObject:modelObjectPart];
            }
            modelObjectPart = [[ModelObjectPart alloc] init];
            modelObjectPart.material = materials[materialName];
        }
        if ([command isEqualToString:@"f"]) {
            if (components.count < 4) continue;
            [modelObjectPart.vertexInfos addObject:[[VertexInfo alloc] initWithString:components[1]]];
            [modelObjectPart.vertexInfos addObject:[[VertexInfo alloc] initWithString:components[2]]];
            [modelObjectPart.vertexInfos addObject:[[VertexInfo alloc] initWithString:components[3]]];
        }
    }
    
    if (modelObjectPart) {
        [modelObject.modelObjectParts addObject:modelObjectPart];
    }
    if (modelObject) {
        [modelObjects setObject:modelObject forKey:modelObject.name];
    }
    
    return modelObjects;
    
}

+ (NSString *)headerFromObjects:(NSDictionary *)objects {

    NSMutableString *retval = [NSMutableString string];

    [retval appendString:@"#import <GLKit/GLKit.h>\r\n\r\n"];
    [retval appendString:@"#import \"RWTVertex.h\"\r\n\r\n"];

    for (ModelObject *modelObject in objects.allValues) {
        for (ModelObjectPart *modelObjectPart in modelObject.modelObjectParts) {
            
            NSString * prefix = [NSString stringWithFormat:@"%@_%@", modelObject.name, modelObjectPart.material.name];
            
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_ambient;\r\n", prefix]];
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_diffuse;\r\n", prefix]];
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_specular;\r\n", prefix]];
            [retval appendString:[NSString stringWithFormat:@"const float %@_shininess;\r\n", prefix]];
            [retval appendString:[NSString stringWithFormat:@"const RWTVertex %@_Vertices[%lu];\r\n\r\n", prefix, (unsigned long)modelObjectPart.vertexInfos.count]];
            
        }
    }
    
    return retval;

}

+ (NSString *)implementationFromObjects:(NSDictionary *)objects baseName:(NSString *)baseName {

    NSMutableString *retval = [NSMutableString string];

    [retval appendString:[NSString stringWithFormat:@"#import \"%@.h\"\r\n\r\n", baseName]];
   
    for (ModelObject *modelObject in objects.allValues) {
        for (ModelObjectPart *modelObjectPart in modelObject.modelObjectParts) {
        
            NSString * prefix = [NSString stringWithFormat:@"%@_%@", modelObject.name, modelObjectPart.material.name];
            
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_ambient = {%f, %f, %f, %f};\r\n", prefix, modelObjectPart.material.ambientR, modelObjectPart.material.ambientG, modelObjectPart.material.ambientB, modelObjectPart.material.alpha]];
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_diffuse = {%f, %f, %f, %f};\r\n", prefix, modelObjectPart.material.diffuseR, modelObjectPart.material.diffuseG, modelObjectPart.material.diffuseB, modelObjectPart.material.alpha]];
            [retval appendString:[NSString stringWithFormat:@"const GLKVector4 %@_specular = {%f, %f, %f, %f};\r\n", prefix, modelObjectPart.material.specularR, modelObjectPart.material.specularG, modelObjectPart.material.specularB, modelObjectPart.material.alpha]];
            [retval appendString:[NSString stringWithFormat:@"const float %@_shininess = %f;\r\n\r\n", prefix, modelObjectPart.material.shininess]];
            
            [retval appendString:[NSString stringWithFormat:@"const RWTVertex %@_Vertices[%lu] = {\r\n", prefix, (unsigned long)modelObjectPart.vertexInfos.count]];
            
            for(VertexInfo *vertexInfo in modelObjectPart.vertexInfos) {
            
                Vector3 * position = [modelObject.vertices objectAtIndex:vertexInfo.vertexIdx - 1];
                Vector2 * texCoord = [modelObject.textureCoords objectAtIndex:vertexInfo.textureCoordIdx - 1];
                Vector3 * normal = [modelObject.normals objectAtIndex:vertexInfo.normalIdx - 1];
            
                [retval appendString:[NSString stringWithFormat:@"    {{%f, %f, %f}, {1, 1, 1, 1}, {%f, %f}, {%f, %f, %f}},\r\n",
                position.x, position.y, position.z, texCoord.x, texCoord.y, normal.x, normal.y, normal.z]];
                                                
            }
            
            [retval appendString:@"};\r\n\r\n"];
        
        }
    }
    
    return retval;

}

@end
