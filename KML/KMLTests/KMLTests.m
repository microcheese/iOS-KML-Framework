//
//  KMLTests.m
//  KMLTests
//
//  Created by Stephen Trainor on 05/12/2015.
//  Copyright © 2015 Crookneck Consulting LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KML/KML.h>

@interface KMLTests : XCTestCase

@end

@implementation KMLTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testKML
{
    NSString *path = [[NSBundle bundleForClass:[KMLParser class]] pathForResource:@"KML_Samples" ofType:@"kml"];
    
    KMLRoot *root = [KMLParser parseKMLAtPath:path];
    
    // kml
    XCTAssertNotNil(root);
    
    // kml > document
    XCTAssertTrue([root.feature isKindOfClass:[KMLDocument class]]);
    KMLDocument *document = (KMLDocument *)root.feature;
    XCTAssertEqualObjects(document.name, @"KML Samples");
    XCTAssertEqualObjects(document.descriptionValue, @"Unleash your creativity with the help of these examples!");
    
    // kml > All placemarks
    XCTAssertEqual(root.placemarks.count, 20U);
    
    KMLPlacemark *placemark;
    KMLCoordinate *coordinate;
    
    // placemark
    placemark = [root.placemarks objectAtIndex:0];
    XCTAssertEqualObjects(placemark.name, @"Simple placemark");
    XCTAssertEqualObjects(placemark.descriptionValue, @"Attached to the ground. Intelligently places itself at the\n          height of the underlying terrain.");
    XCTAssertTrue([placemark.geometry isKindOfClass:[KMLPoint class]]);
    XCTAssertEqual(((KMLPoint *)placemark.geometry).coordinate.latitude, 37.42228990140251f);
    XCTAssertEqual(((KMLPoint *)placemark.geometry).coordinate.longitude, -122.0822035425683f);
    
    placemark = [root.placemarks objectAtIndex:2];
    XCTAssertEqualObjects(placemark.name, @"Extruded placemark");
    XCTAssertEqualObjects(placemark.descriptionValue, @"Tethered to the ground by a customizable\n          &quot;tail&quot;");
    XCTAssertTrue([placemark.geometry isKindOfClass:[KMLPoint class]]);
    XCTAssertEqual(((KMLPoint *)placemark.geometry).coordinate.latitude, 37.42156927867553f);
    XCTAssertEqual(((KMLPoint *)placemark.geometry).coordinate.longitude, -122.0857667006183f);
    
    // line
    placemark = [root.placemarks objectAtIndex:10];
    XCTAssertEqualObjects(placemark.name, @"Relative Extruded");
    XCTAssertEqualObjects(placemark.descriptionValue, @"Opaque blue walls with red outline, height tracks terrain");
    XCTAssertTrue([placemark.geometry isKindOfClass:[KMLLineString class]]);
    KMLLineString *linestring = (KMLLineString *)placemark.geometry;
    XCTAssertEqual(linestring.coordinates.count, 11U);
    coordinate = [linestring.coordinates objectAtIndex:0];
    XCTAssertEqual(coordinate.latitude, 36.09445214722695f);
    XCTAssertEqual(coordinate.longitude, -112.2656634181359f);
    coordinate = [linestring.coordinates objectAtIndex:4];
    XCTAssertEqual(coordinate.latitude, 36.09679275951239f);
    XCTAssertEqual(coordinate.longitude, -112.2635746835406f);
    coordinate = [linestring.coordinates objectAtIndex:10];
    XCTAssertEqual(coordinate.latitude, 36.10149062823369f);
    XCTAssertEqual(coordinate.longitude, -112.2626894973474f);
    
    // polygon
    placemark = [root.placemarks objectAtIndex:19];
    XCTAssertEqualObjects(placemark.name, @"Relative Extruded");
    XCTAssertTrue([placemark.geometry isKindOfClass:[KMLPolygon class]]);
    KMLPolygon *polygon = (KMLPolygon *)placemark.geometry;
    XCTAssertNotNil(polygon.outerBoundaryIs);
    XCTAssertEqual(polygon.outerBoundaryIs.coordinates.count, 9U);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:0];
    XCTAssertEqual(coordinate.latitude, 36.1514008468736f);
    XCTAssertEqual(coordinate.longitude, -112.3348783983763f);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:4];
    XCTAssertEqual(coordinate.latitude, 36.1489624162954f);
    XCTAssertEqual(coordinate.longitude, -112.3358353861232f);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:8];
    XCTAssertEqual(coordinate.latitude, 36.1514008468736f);
    XCTAssertEqual(coordinate.longitude, -112.3348783983763f);
}

@end
