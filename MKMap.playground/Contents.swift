//: Playground - noun: a place where people can play

import MapKit
import CoreLocation


var annotation: MKAnnotation // the annotation; treat as if read-only
var image: UIImage // instead of the pin, for example (not an image on the callout)
var leftCalloutAccessoryView: UIView // maybe a UIImageView
var rightCalloutAccessoryView: UIView // maybe a "disclosure" UIButton
var enabled: Bool // false means it ignore touch events, no delegation method, no callout
var centerOffset: CGPoint // where is the "head of the pin" is relative to the image
var draggable: Bool // only works if the annotation's coordinate property is { get set }

// configure the map view's display type
var mapType: MKMapType

// Showing the user's current location
var showsUserLocation: Bool
var isUserLocationVisible: Bool
var userLocation: MKUserLocation

// Restricting the user's interaction with the map
var zoomEnabled: Bool
var scrollEnabled: Bool
var pitchEnabled: Bool // 3D
var rotateEnabled: Bool

// Setting where the user is seeing the map from (in 3D)
var camera: MKMapCamera // property in MKMapView

// How are MKAnnotationViews created and associated with annotations?
func mapView(sender: MKMapView, viewForAnnotation: MKAnnotation) -> MKAnnotationView {
    var view: MKAnnotationView! = sender.dequeueReusableAnnotationViewWithIdentifier(IDENT)
    if view == nil {
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: IDENT)
        view.canShowCallout = true or false
    }
    view.annotation = annotation // yes, this happens twice if no dequeue
    // prepare and (if not too expensive) load up accessory views here
    // or reset them and wait until mapView(didSelectAnnotationView:) to load actual data
    return view
}

// if you set one of the callout accessory views to be a UIControl
view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
func mapView(MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped: UIControl) {}

// Using didSelectAnnotationView: to load callout accessories
func mapView(MKMapView, didSelectAnnotationView aView: MKAnnotationView) {
    if let imageView = aView.leftCalloutAccessoryView as? UIImageView {
        imageView.image = // ... if you do this on another thread, be careful, views are reused!
    }
}

// Controlling the region (part of the world) the map is displaying
var region: MKCoordinateRegion
struct MKCoordinateRegion {
    var center: CLLocationCoordinate2D
    var span: MKCoordinateSpan
}
struct MKCoordinateSpan {
    var latitudeDelta: CLLocationDegrees
    var longitudeDelta: CLLocationDegrees
}
func setRegion(MKCoordinateRegion, animated: Bool) {}

// can also set the center point only or set to show annotations
var centerCoordinate: CLLocationCoordinate2D
func setCenterCoordinate(CLLocationCoordinate2D, animated: Bool)
func showAnnotations([MKAnnotation], animated: Bool)

// Converting to/from map points/rects from/to view coordinates
func mapPointForPoint(CGPoint) -> MKMapPoint
func mapRectForRect(CGRect) -> MKMapRect
func pointForMapPoint(MKMapPoint) -> CGPoint
func rectForMapRect(MKMapRect) -> CGRect
// etc

// a good place to "chain animations to the map"
func mapView(MKMapView, didChangeRegionAnimated: Bool)

// searching for places in the world
// MKLocalSearch
var request = MKLocalSearchRequest()
request.naturalLanguageQuery = "Ike's"
request.region = //... e.g. Stanford campus
let search = MKLocalSearch(request: request)
search.startWithCompletionHandler { (MKLocalSearchResponse?, NSError?) in
    // response contains an array of MKMapItem which contains MKPlacemark
    // MKPlacemark contains location, name of location, postalCode, region, etc.
}

// MKMapItem. You can open a MKMapItem that you get back f a MKLocalSearch in the Maps app...
func openInMapsWithLaunchOptions([String: AnyObject]?) -> Bool // the options can specific region, show traffic, etc

// MKDirections
MKRoute // incluces a name for the route, turn-by-turn directions, expected travel time, etc.

MKPolyline // blue line of the directions

// Overlays: - like annotations for maps, but for directions, drawing path















































