# Ride Sharing System: OOP Principles in C++ and Smalltalk

---

## Introduction
This report explains how the Ride Sharing System demonstrates the object-oriented programming (OOP) principles of encapsulation, inheritance, and polymorphism in both C++ and Smalltalk. Sample code output and screenshots are included to illustrate system usage.

---

## 1. Encapsulation

### C++
- **Private/protected members:** All class attributes (e.g., `rideID`, `assignedRides`) are private or protected.
- **Public methods:** Access and modification are only possible through public methods (e.g., `addRide()`, `getDriverInfo()`).
- **Example:**
    - The `Driver` class keeps `assignedRides` private and only allows modification via `addRide()`.

### Smalltalk
- **Instance variables:** Attributes are only accessible via accessor methods (e.g., `rideID`, `assignedRides`).
- **Encapsulation enforced:** Direct access to variables is not possible outside the class.
- **Example:**
    - The `Driver` class uses `addRide:` to modify `assignedRides`.

---

## 2. Inheritance

### C++
- **Base class:** `Ride` is an abstract base class.
- **Derived classes:** `StandardRide` and `PremiumRide` inherit from `Ride` and override its methods.
- **Example:**
    - `StandardRide` and `PremiumRide` both implement their own `calculateFare()`.

### Smalltalk
- **Superclass:** `Ride` is the superclass.
- **Subclasses:** `StandardRide` and `PremiumRide` inherit from `Ride` and implement their own `calculateFare` methods.
- **Example:**
    - Both subclasses override `calculateFare` for different fare logic.

---

## 3. Polymorphism

### C++
- **Virtual methods:** `calculateFare()` and `rideDetails()` are virtual in `Ride` and overridden in subclasses.
- **Polymorphic usage:** A vector of `shared_ptr<Ride>` stores different ride types; calling `ride->calculateFare()` invokes the correct subclass method.
- **Example:**
    - The main function demonstrates calling overridden methods on a mixed list of rides.

### Smalltalk
- **Dynamic message passing:** `calculateFare` and `rideDetails` are sent to a collection of rides, and the correct subclass method is invoked.
- **Example:**
    - The demonstration script iterates over a collection of rides and calls `calculateFare` and `rideDetails` polymorphically.

---

## 4. Sample Output

### C++


![c++](https://github.com/user-attachments/assets/d2ec2846-1b7c-4f56-bfbb-9f71b51992c4)


### Smalltalk

![smalltalk](https://github.com/user-attachments/assets/bcbebd0b-9bdb-421b-9a13-811b52eac151)


