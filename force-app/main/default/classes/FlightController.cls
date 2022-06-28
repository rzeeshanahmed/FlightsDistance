/*
 * Created By Zeeshan Ahmed
 * Created on 28th June 2022
 * Description: This class works as an extension of a FlightDistanceCalculator Page
 * */
public class FlightController {
    
    // Variable to store the flight information
    public Flight__c flight { get; set; }
    
    //Flag to show/hide the flight detail section
    public boolean status { get; set; }
    
    //Constructor to initialize the flight object of class
    public FlightController(ApexPages.StandardController stdController) {
        this.flight = (Flight__c)stdController.getRecord();
    }
    
    // Wrapper to store the airport details
    public class AirportDetails {
        public String name;
        public Decimal lat;
        public Decimal lng;
    }
    
    /*
     * Description: Save method is used to create a new flight and avoid duplicate record creation.
     * 
     * */
    public PageReference save(){
        
        //Validation to stop creating a flight with same departure and destination location
        if(flight.Departure__c == flight.Arrival__c){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Departure and Arrival Location cannot be same!'));
        } else {
            try{
                //list of store all related airports
                List<Airport__c> lstAirports = new List<Airport__c>();
                //lsit to store the existing flights information
                List<Flight__c> existingFlights = new List<Flight__c>();
                
                //Wrappers to store the departure and arrival airport information
                AirportDetails dAirport = new AirportDetails();
                AirportDetails aAirport = new AirportDetails();
                
                //SOQL to get the existing flights
                existingFlights = [SELECT id,Distance_in_km__c,Departure__r.Name,Arrival__r.Name FROM Flight__c WHERE Departure__c =: flight.Departure__c AND Arrival__c =: flight.Arrival__c];
                //If we have existing flights on the same route then throw ane exception
                if(existingFlights.size() > 0) {
                    this.flight = existingFlights.get(0);
                    this.status = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'There is an existing flight with these details!'));
                } else {
                    //Getting list of airports
                    lstAirports = [SELECT Id, Name, Airport_Location__Latitude__s, Airport_Location__Longitude__s
                                   FROM Airport__c WHERE Id =: flight.Departure__c OR Id =: flight.Arrival__c LIMIT 50000];
                    
                    //Iterating over a list of airports and getting the name and coordinates
                    for(Airport__c airport : lstAirports) {
                        if(airport.Id == flight.Departure__c) {
                            dAirport.lat = airport.Airport_Location__Latitude__s;
                            dAirport.lng = airport.Airport_Location__Longitude__s;
                            dAirport.name = airport.Name;
                        } else {
                            aAirport.lat = airport.Airport_Location__Latitude__s;
                            aAirport.lng = airport.Airport_Location__Longitude__s;
                            aAirport.name = airport.Name;
                        }
                    }
                    
                    //Calculating the distance between two locations and storing it in object field.
                    flight.Distance_in_km__c = Utility.calculateDistance(dAirport.lat,dAirport.lng,aAirport.lat,aAirport.lng);
                    //Updating the flight name as per the locations selected
                    flight.Name = dAirport.name + ' - ' + aAirport.name;
                    insert flight;
                    flight = [SELECT id,Distance_in_km__c,Departure__r.Name,Arrival__r.Name FROM Flight__c WHERE Id =: flight.Id Limit 1];
                    //Updating the flag to show the flight details
                    status = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Flight has been added successfully!'));
                }
            } catch(Exception ex){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getMessage()));
                status = false;
            }
        }
        return null;
    }
}