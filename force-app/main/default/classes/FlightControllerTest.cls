/*
 * Created By Zeeshan Ahmed
 * Created on 28th June 2022
 * Description: FlightControllerTest class to unit test the flight controller class
 * */
@isTest
public class FlightControllerTest {
	@testSetup
    public static void setup(){
        TestDataFactory.createAirports();
    }
    
    @isTest
    static void createFlightPositiveCase() {
        
        Id departureAirportId;
        Id arrivalAirportId;
        List<Airport__c> airportData=[SELECT Id,Name FROM Airport__c
                                      WHERE Name IN ('Barcelona','Madrid')
                                      LIMIT 2];
        
        for(Airport__c ap : airportData) {
            if(ap.Name == 'Barcelona'){
                departureAirportId = ap.Id;
            }else{
                arrivalAirportId = ap.Id;
            }
        }
        
        Flight__c flight = new Flight__c();
        flight.Arrival__c = arrivalAirportId;
        flight.Departure__c = departureAirportId;
        ApexPages.standardController stdCon = new ApexPages.standardController(flight);
        
        FlightController c = new FlightController(stdCon);

        Test.startTest();
        c.save();
        Test.stopTest();
        
        Flight__c createdFlight = [SELECT Id, Distance_in_km__c, Departure__c, Arrival__c
                                   FROM Flight__c
                                   WHERE ID =: flight.Id
                                   LIMIT 1 ];
        
        System.assertEquals(482.8, createdFlight.Distance_in_km__c.setScale(1),'Distance not calculated Successfully!'); 
    }
    
    @isTest
    static void createFlightNegativeCase() {
        
        Id departureAirportId;
        Id arrivalAirportId;
        List<Airport__c> airportData=[SELECT Id,Name FROM Airport__c
                                      WHERE Name IN ('Barcelona','Madrid')
                                      LIMIT 2];
        
        for(Airport__c ap : airportData) {
            if(ap.Name == 'Barcelona'){
                departureAirportId = ap.Id;
            }else{
                arrivalAirportId = ap.Id;
            }
        }
        
        Flight__c flight = new Flight__c();
        flight.Arrival__c = arrivalAirportId;
        flight.Departure__c = departureAirportId;
        ApexPages.standardController stdCon = new ApexPages.standardController(flight);
        
        FlightController c = new FlightController(stdCon);

        Test.startTest();
        c.save();
        
        Flight__c flight1 = new Flight__c();
        flight1.Arrival__c = arrivalAirportId;
        flight1.Departure__c = departureAirportId;
        ApexPages.standardController stdCon1 = new ApexPages.standardController(flight1);
        
        FlightController c1 = new FlightController(stdCon1);

        c1.save();
        Test.stopTest();
        
        System.assertEquals(null, Flight1.Id); 
    }
}