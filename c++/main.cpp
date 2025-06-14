#include <iostream>
#include <vector>
#include <string>
#include <memory>
#include <iomanip>
#include <stdexcept>
#include <algorithm>

/**
 * @brief Base Ride class that holds core ride details
 * Demonstrates encapsulation by keeping ride details private
 */
class Ride {
protected:
    int rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;
    double fare;

public:
    Ride(int id, const std::string& pickup, const std::string& dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist), fare(0.0) {
        if (dist <= 0) {
            throw std::invalid_argument("Distance must be greater than 0");
        }
    }

    virtual ~Ride() = default;

    // Pure virtual function to be implemented by derived classes
    virtual void calculateFare() = 0;

    // Virtual function that can be overridden by derived classes
    virtual void rideDetails() const {
        std::cout << "Ride ID: " << rideID
                  << "\nPickup: " << pickupLocation
                  << "\nDropoff: " << dropoffLocation
                  << "\nDistance: " << distance << " miles"
                  << "\nFare: $" << std::fixed << std::setprecision(2) << fare;
    }

    double getFare() const { return fare; }
    int getRideID() const { return rideID; }
    const std::string& getPickupLocation() const { return pickupLocation; }
    const std::string& getDropoffLocation() const { return dropoffLocation; }
    double getDistance() const { return distance; }
};

/**
 * @brief StandardRide class - demonstrates inheritance from Ride
 * Implements basic fare calculation
 */
class StandardRide : public Ride {
public:
    StandardRide(int id, const std::string& pickup, const std::string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    // Override the calculateFare method - demonstrates polymorphism
    void calculateFare() override {
        fare = distance * 1.50; // $1.50 per mile
    }

    // Override the rideDetails method - demonstrates polymorphism
    void rideDetails() const override {
        Ride::rideDetails();
        std::cout << " (Standard Ride)" << std::endl;
    }
};

/**
 * @brief PremiumRide class - demonstrates inheritance from Ride
 * Implements premium fare calculation
 */
class PremiumRide : public Ride {
public:
    PremiumRide(int id, const std::string& pickup, const std::string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    // Override the calculateFare method - demonstrates polymorphism
    void calculateFare() override {
        fare = distance * 3.00; // $3.00 per mile
    }

    // Override the rideDetails method - demonstrates polymorphism
    void rideDetails() const override {
        Ride::rideDetails();
        std::cout << " (Premium Ride)" << std::endl;
    }
};

/**
 * @brief Driver class - demonstrates encapsulation
 * Keeps driver details private and provides public methods for access
 */
class Driver {
private:
    int driverID;
    std::string name;
    double rating;
    std::vector<std::shared_ptr<Ride> > assignedRides;

public:
    Driver(int id, const std::string& name, double rating)
        : driverID(id), name(name), rating(rating) {
        if (rating < 0 || rating > 5) {
            throw std::invalid_argument("Rating must be between 0 and 5");
        }
    }

    void addRide(const std::shared_ptr<Ride>& ride) {
        if (!ride) {
            throw std::invalid_argument("Invalid ride pointer");
        }
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        std::cout << "Driver ID: " << driverID
                  << "\nName: " << name
                  << "\nRating: " << std::fixed << std::setprecision(2) << rating
                  << "\nCompleted Rides: " << assignedRides.size() << std::endl;
    }

    int getDriverID() const { return driverID; }
    const std::string& getName() const { return name; }
    double getRating() const { return rating; }
};

/**
 * @brief Rider class - demonstrates encapsulation
 * Keeps rider details private and provides public methods for access
 */
class Rider {
private:
    int riderID;
    std::string name;
    std::vector<std::shared_ptr<Ride> > requestedRides;

public:
    Rider(int id, const std::string& name)
        : riderID(id), name(name) {}

    void requestRide(const std::shared_ptr<Ride>& ride) {
        if (!ride) {
            throw std::invalid_argument("Invalid ride pointer");
        }
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        std::cout << "Rider ID: " << riderID
                  << "\nName: " << name
                  << "\nRequested Rides History:" << std::endl;
        
        if (requestedRides.empty()) {
            std::cout << "No rides requested yet." << std::endl;
            return;
        }

        for (const auto& ride : requestedRides) {
            ride->rideDetails();
        }
    }

    int getRiderID() const { return riderID; }
    const std::string& getName() const { return name; }
};

int main() {
    try {
        std::cout << "=== Testing Common Scenarios ===\n" << std::endl;

        // Test Scenario 1: Basic ride creation and fare calculation
        std::cout << "Test 1: Basic Ride Creation" << std::endl;
        std::cout << "------------------------" << std::endl;
        auto standardRide = std::make_shared<StandardRide>(1, "Home", "Work", 5.0);
        auto premiumRide = std::make_shared<PremiumRide>(2, "Home", "Airport", 15.0);
        
        standardRide->calculateFare();
        premiumRide->calculateFare();
        
        std::cout << "Standard Ride (5 miles):" << std::endl;
        standardRide->rideDetails();
        std::cout << "\nPremium Ride (15 miles):" << std::endl;
        premiumRide->rideDetails();
        std::cout << std::endl;

        // Test Scenario 2: Driver with multiple rides
        std::cout << "Test 2: Driver with Multiple Rides" << std::endl;
        std::cout << "------------------------" << std::endl;
        Driver driver(101, "John Doe", 4.8);
        
        auto ride1 = std::make_shared<StandardRide>(3, "Downtown", "Mall", 3.0);
        auto ride2 = std::make_shared<PremiumRide>(4, "Mall", "Airport", 12.0);
        
        ride1->calculateFare();
        ride2->calculateFare();
        
        driver.addRide(ride1);
        driver.addRide(ride2);
        
        driver.getDriverInfo();
        std::cout << std::endl;

        // Test Scenario 3: Rider with ride history
        std::cout << "Test 3: Rider with Ride History" << std::endl;
        std::cout << "------------------------" << std::endl;
        Rider rider(201, "Alice");
        
        auto ride3 = std::make_shared<StandardRide>(5, "Home", "Gym", 2.0);
        auto ride4 = std::make_shared<PremiumRide>(6, "Gym", "Restaurant", 4.0);
        
        ride3->calculateFare();
        ride4->calculateFare();
        
        rider.requestRide(ride3);
        rider.requestRide(ride4);
        
        rider.viewRides();
        std::cout << std::endl;

        // Test Scenario 4: Polymorphism demonstration
        std::cout << "Test 4: Polymorphism Demonstration" << std::endl;
        std::cout << "------------------------" << std::endl;
        std::vector<std::shared_ptr<Ride> > mixedRides;
        mixedRides.push_back(std::make_shared<StandardRide>(7, "Point A", "Point B", 8.0));
        mixedRides.push_back(std::make_shared<PremiumRide>(8, "Point C", "Point D", 8.0));
        
        std::cout << "Same distance (8 miles), different ride types:" << std::endl;
        for (const auto& ride : mixedRides) {
            ride->calculateFare();
            ride->rideDetails();
        }
        std::cout << std::endl;

        // Test Scenario 5: Error handling
        std::cout << "Test 5: Error Handling" << std::endl;
        std::cout << "------------------------" << std::endl;
        try {
            Driver invalidDriver(102, "Invalid", 6.0); // Should throw exception
        } catch (const std::exception& e) {
            std::cout << "Caught expected error: " << e.what() << std::endl;
        }

        try {
            auto invalidRide = std::make_shared<StandardRide>(9, "Start", "End", -5.0); // Should throw exception
        } catch (const std::exception& e) {
            std::cout << "Caught expected error: " << e.what() << std::endl;
        }
        std::cout << std::endl;

    } catch (const std::exception& e) {
        std::cerr << "Unexpected error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
} 