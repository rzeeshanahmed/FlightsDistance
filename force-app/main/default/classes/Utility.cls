/*
 * Created By Zeeshan Ahmed
 * Created on 28th June 2022
 * Description: Utility class contains method to calculate the distance between two locations
 * */
public class Utility {
    
    //Method to Calcualte the Distance between two points
    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1, Decimal latitude2, Decimal longitude2) {
        System.debug('L1: ' + latitude1 + ' L2: ' + latitude2);
        Integer earthRadius = 6371 * 1000; // in meters
        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;
        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) +
            Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) *
            Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);
        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres
        // converting distance from meters to KM
        return (distance/1000);
    }
}