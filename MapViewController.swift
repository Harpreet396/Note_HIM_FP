
import UIKit
import CoreLocation
import MapKit

class MapViewControler: UIViewController,MKMapViewDelegate {
    
    var notesCord = CLLocationCoordinate2D()
    

    @IBOutlet weak var locationMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = notesCord

        
        locationMapView.addAnnotation(annotation)
        
        locationMapView.delegate = self
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let location = CLLocationCoordinate2D(latitude: notesCord.latitude, longitude: notesCord.longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.locationMapView.setRegion(region, animated: true)
        self.locationMapView.isZoomEnabled = true
               
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "bookmark")
        annotationView.canShowCallout = true

        return annotationView
    }
    
}
