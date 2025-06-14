"Ride Sharing System in Smalltalk
This implementation demonstrates object-oriented programming principles:
- Encapsulation: Private instance variables with public accessor methods
- Inheritance: Ride as base class with StandardRide and PremiumRide subclasses
- Polymorphism: Dynamic method dispatch and message passing"

"=============================================================================="
" Ride Class - Base Class"
"=============================================================================="

Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance fare'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

!Ride methodsFor: 'initialization'!
initializeWithID: anID pickup: aPickup dropoff: aDropoff distance: aDistance
    "Initialize a new ride with the given parameters.
    Validates that distance is positive."
    (aDistance <= 0) ifTrue: [self error: 'Distance must be greater than 0'].
    rideID := anID.
    pickupLocation := aPickup.
    dropoffLocation := aDropoff.
    distance := aDistance.
    fare := 0.
! !

!Ride methodsFor: 'accessing'!
rideID
    "Return the ride ID"
    ^rideID
!
pickupLocation
    "Return the pickup location"
    ^pickupLocation
!
dropoffLocation
    "Return the dropoff location"
    ^dropoffLocation
!
distance
    "Return the distance"
    ^distance
!
fare
    "Return the calculated fare"
    ^fare
! !

!Ride methodsFor: 'operations'!
calculateFare
    "Abstract method to be implemented by subclasses"
    self subclassResponsibility
!

rideDetails
    "Return a formatted string with ride details"
    ^'Ride ID: ', (rideID printString), 
     ' | Pickup: ', pickupLocation,
     ' | Dropoff: ', dropoffLocation,
     ' | Distance: ', (distance printString), ' km',
     ' | Fare: $', (fare printString)
! !

"Class methods for Ride"
!Ride class methodsFor: 'instance creation'!
newWithID: anID pickup: aPickup dropoff: aDropoff distance: aDistance
    "Create a new ride instance with the given parameters"
    ^self new initializeWithID: anID pickup: aPickup dropoff: aDropoff distance: aDistance
! !


"=============================================================================="
" StandardRide Class - Subclass of Ride"
"=============================================================================="

Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: 'BASE_RATE'
    poolDictionaries: ''
    category: 'RideSharing'.

!StandardRide class methodsFor: 'initialization'!
initialize
    "Initialize class variables"
    BASE_RATE := 2.
! !

!StandardRide class methodsFor: 'accessing'!
BASE_RATE
    ^BASE_RATE
! !

!StandardRide methodsFor: 'operations'!
calculateFare
    "Calculate fare for standard ride: distance * base rate"
    fare := distance * self class BASE_RATE.
!

rideDetails
    "Return ride details with standard ride indicator"
    ^super rideDetails, ' (Standard)'
! !


"=============================================================================="
" PremiumRide Class - Subclass of Ride"
"=============================================================================="

Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: 'BASE_RATE'
    poolDictionaries: ''
    category: 'RideSharing'.

!PremiumRide class methodsFor: 'initialization'!
initialize
    "Initialize class variables"
    BASE_RATE := 4.
! !

!PremiumRide class methodsFor: 'accessing'!
BASE_RATE
    ^BASE_RATE
! !

!PremiumRide methodsFor: 'operations'!
calculateFare
    "Calculate fare for premium ride: distance * premium rate"
    fare := distance * self class BASE_RATE.
!

rideDetails
    "Return ride details with premium ride indicator"
    ^super rideDetails, ' (Premium)'
! !


"=============================================================================="
" Driver Class"
"=============================================================================="

Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

!Driver methodsFor: 'initialization'!
initializeWithID: anID name: aName rating: aRating
    "Initialize a new driver with the given parameters.
    Validates that rating is between 0 and 5."
    (aRating < 0 or: [aRating > 5]) ifTrue: [self error: 'Rating must be between 0 and 5'].
    driverID := anID.
    name := aName.
    rating := aRating.
    assignedRides := OrderedCollection new.
! !

!Driver methodsFor: 'accessing'!
driverID
    "Return the driver ID"
    ^driverID
!
name
    "Return the driver name"
    ^name
!
rating
    "Return the driver rating"
    ^rating
! !

!Driver methodsFor: 'operations'!
addRide: aRide
    "Add a ride to the driver's assigned rides.
    Validates that the ride is not nil."
    aRide ifNil: [self error: 'Cannot add nil ride'].
    assignedRides add: aRide.
!

getDriverInfo
    "Display driver information in a formatted way"
    Transcript show: 'Driver ID: ', (driverID printString); cr.
    Transcript show: 'Name: ', name; cr.
    Transcript show: 'Rating: ', (rating printString), '/5'; cr.
    Transcript show: 'Completed Rides: ', (assignedRides size printString); cr.
! !

"Class methods for Driver"
!Driver class methodsFor: 'instance creation'!
newWithID: anID name: aName rating: aRating
    "Create a new driver instance with the given parameters"
    ^self new initializeWithID: anID name: aName rating: aRating
! !


"=============================================================================="
" Rider Class"
"=============================================================================="

Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

!Rider methodsFor: 'initialization'!
initializeWithID: anID name: aName
    "Initialize a new rider with the given parameters"
    riderID := anID.
    name := aName.
    requestedRides := OrderedCollection new.
! !

!Rider methodsFor: 'accessing'!
riderID
    "Return the rider ID"
    ^riderID
!
name
    "Return the rider name"
    ^name
! !

!Rider methodsFor: 'operations'!
requestRide: aRide
    "Add a ride to the rider's requested rides.
    Validates that the ride is not nil."
    aRide ifNil: [self error: 'Cannot request nil ride'].
    requestedRides add: aRide.
!

viewRides
    "Display rider information and ride history in a formatted way"
    Transcript show: 'Rider ID: ', (riderID printString); cr.
    Transcript show: 'Name: ', name; cr.
    Transcript show: 'Requested Rides History:'; cr.
    requestedRides isEmpty ifTrue: [
        Transcript show: 'No rides requested yet.'; cr.
        ^self
    ].
    requestedRides do: [:aRide |
        Transcript show: (aRide rideDetails); cr.
    ].
! !

"Class methods for Rider"
!Rider class methodsFor: 'instance creation'!
newWithID: anID name: aName
    "Create a new rider instance with the given parameters"
    ^self new initializeWithID: anID name: aName
! !


"=============================================================================="
" System Functionality Demonstration"
"=============================================================================="

"Initialize class variables"
StandardRide initialize.
PremiumRide initialize.

"Create drivers"
Transcript show: '=== Creating Drivers ==='; cr.
driver1 := Driver newWithID: 101 name: 'John Doe' rating: 5.
driver2 := Driver newWithID: 102 name: 'Jane Smith' rating: 4.
driver1 getDriverInfo.
driver2 getDriverInfo.
Transcript cr.

"Create riders"
Transcript show: '=== Creating Riders ==='; cr.
rider1 := Rider newWithID: 201 name: 'Alice'.
rider2 := Rider newWithID: 202 name: 'Bob'.
rider1 viewRides.
rider2 viewRides.
Transcript cr.

"Create a list of rides"
Transcript show: '=== Creating Rides ==='; cr.
rides := OrderedCollection new.
rides add: (StandardRide newWithID: 1 pickup: 'Downtown' dropoff: 'Suburb' distance: 10).
rides add: (PremiumRide newWithID: 2 pickup: 'Airport' dropoff: 'Hotel' distance: 20).
rides add: (StandardRide newWithID: 3 pickup: 'Park' dropoff: 'Museum' distance: 5).

"Demonstrate Polymorphism"
Transcript show: '=== Ride Details & Fare Calculation (Polymorphism) ==='; cr.
rides do: [:aRide |
    aRide calculateFare.       "Polymorphic call"
    Transcript show: (aRide rideDetails); cr. "Polymorphic call"
].
Transcript cr.

"Assign rides to drivers and riders"
driver1 addRide: (rides at: 1).
rider1 requestRide: (rides at: 1).

driver2 addRide: (rides at: 2).
rider1 requestRide: (rides at: 2).

driver1 addRide: (rides at: 3).
rider2 requestRide: (rides at: 3).

"Display final information"
Transcript show: '=== Final Driver Information ==='; cr.
driver1 getDriverInfo.
driver2 getDriverInfo.
Transcript cr.

Transcript show: '=== Final Rider Information ==='; cr.
rider1 viewRides.
Transcript cr.
rider2 viewRides.

"Test error handling"
Transcript show: '=== Testing Error Handling ==='; cr.
[
    Driver newWithID: 103 name: 'Invalid' rating: 6.
] on: Error do: [:ex |
    Transcript show: 'Caught expected error: ', ex messageText; cr.
].

[
    StandardRide newWithID: 4 pickup: 'Start' dropoff: 'End' distance: -5.
] on: Error do: [:ex |
    Transcript show: 'Caught expected error: ', ex messageText; cr.
].