/*
 * Created By Zeeshan Ahmed
 * Created on 28th June 2022
 * Description: Test Data Factory class to create Test Data records
 * */
@isTest
public class TestDataFactory {
    
    //Method to Create Airpot records
	public static void createAirports(){
        List<Airport__c> lstAirports = new List<Airport__c>();
        Airport__c dAirport = new Airport__c();
        Airport__c aAirport = new Airport__c();
        
        dAirport.Airport_Location__Latitude__s = 41.29694444;
        dAirport.Airport_Location__Longitude__s = 2.078333333;
        dAirport.Name = 'Barcelona';
        dAirport.IATA__c = 'BCN';
        lstAirports.add(dAirport);
        
        aAirport.Airport_Location__Latitude__s = 40.4722222222222;
        aAirport.Airport_Location__Longitude__s = -3.56083333333333;
        aAirport.Name = 'Madrid';
        aAirport.IATA__c = 'MAD';
        lstAirports.add(aAirport);
        
        insert  lstAirports;
        
    }
}