# 2LEIC03T5

# UniLift Development Report

Welcome to the documentation pages of UniLift !

You can find here details about UniLif, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities:
* [Business modeling](#Business-Modelling) 
  * [Product Vision](#Product-Vision)
  * [Features and Assumptions](#Features-and-Assumptions)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)
  * [Vertical prototype](#Vertical-Prototype)
* [Project management](#Project-Management)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

* Ana Baptista - up202207334
* Bernardo Sousa - up202206009
* Eduardo Santos - up202207521
* Martim Moniz - up202206958
* Pedro Pedro - up202206961
 
## Business Modelling

### Product Vision
<Product Vision > 
For students who want to travel sustainably and comfortably to college, UniLift is a ridesharing platform that simplifies the process of sharing rides among students.

### Features and Assumptions

* Create trips
* List trips
* Reserve seat 
* Trip chats
* Cancel trip
* Create profile 
* Rate profile
* Register with college e-mail

### Elevator Pitch

Imagine an easy and safe way for college students to get around town: meet **UniLift**! UniLift is more than just a carpooling app, it's an **exclusive community for college students** to connect with others **to share rides**.

With UniLift, you can forget about waiting for crowded buses or dealing with expensive parking. Simply **open the app**, **input your route**, and **find other students heading in the same direction**. It's a convenient way to **save time**, **money**, and, of course, **reduce your carbon footprint**.

And the best part? UniLift is designed with student safety in mind. **All users are verified as college students**, and you can see reviews from other colleagues before deciding on your ride.

Join the UniLift community and be part of a smarter, friendlier way to get around town.

## Requirements

<Domain Model and Descritive text>
 
### Domain Model

<p align="center" justify="center">
  <img src="images/UML_UNILIFT.png"
</p>

The student is characterized by their name, course, email, and password. They can assume two distinct roles: driver or passenger. As a driver, they will be associated with one or more cars, containing information such as brand, model, fuel consumption per kilometer, year of manufacture, type of fuel (gasoline, diesel, electric), engine, and capacity. As a passenger, they can search for trips that meet their needs.

As a driver, the user has the ability to create a trip, specifying origin, destination, departure time, and date. Each trip includes a chat where all members can communicate and make agreements, with the trip status being confirmed, pending, or canceled.


## Architecture and Design 

### Logical Architecture

<p align="center" justify="center">
  <img src="images/LogicalArchitecture.png"
</p>

### Physical Architecture

<p align="center" justify="center">
  <img src="images/PhysicalArchitecture.png"
</p>


### Vertical prototype

<p align="center" justify="center">
  <img src="images/VerticalPrototypeMap.png"
</p>

## Project management

You can find below information and references related with the project management in our team: 

* Backlog management: Product backlog and Iteration backlog in a [github projects board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/28/views/1) ;
* Release management: 
  * [v0.0]
   

* Sprint planning and retrospectives::

## Iteration 0

### Plans:

### Development Board

Beginning

![DevelopmentBoard](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/9d3fdd3e-0d4a-4ec2-841b-ddc908f255fc)

End

![DevelopmentBoard](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/a6c3419d-b842-40be-8b08-99fda363d9de)

### Retrospectives: 

This iteration does not introduce any new functionalities to the application. It serves as a vertical prototype aimed at testing the compatibility and effectiveness of various technologies for UniLift's intended purpose. <br>


<br>

## Iteration 1

### Plans:

### Development Board

Beginning

![image](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/eec23886-6090-4ec1-ab6a-9c8c4f99a2c3)

End

![Captura de ecrã de 2024-04-16 10-01-50](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/a1c0b979-80d4-42d9-abb1-12d3983fc5bf)


### Retrospectives:

As we started working on the app, we focused our first iteration on learning the basics of the flutter engine, implementing the first pages.
We have already developed the following pages: Login, Create Account, Profile and Lift Page. <br>
In this iteration, we also:
- Explored and implemented the basic structure of navigation between pages;
- Learned and applied fundamental Flutter concepts such as widgets, layouts, and state management;
- Began to understand the overall architecture of the application and how each page integrates into the user flow. <br>


<br>

## Iteration 2

### Plans:

### Development Board

Beginning

![Captura de ecrã de 2024-05-01 23-35-29](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/146183808/8f9a00f2-7e7d-4ae8-a69f-e1d2ab818f77)

End

![Captura de ecrã de 2024-05-01 23-37-43](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/146183808/4fc0a363-cc92-43c4-ae11-0727397c7883)


### Retrospectives:
The main focus of our third iteration was integrating Firebase data into our app. We spent time setting up trip creation and list features, making minor design adjustments to the main page, and finalizing everything concerning the profile page, particularly the ability to edit profiles. These improvements streamlined our app and made it more user-friendly.
In this iteration, we also:
  - Improved our skills with controllers.
  - Figured out how to update information in Firebase, the storage system we use for our app's data.
 <br>

## Iteration 3

### Plans:

### Development Board

Beginning

![Captura de ecrã de 2024-05-21 08-55-42](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/26440f2d-2d68-4736-9a07-8da1b0ed76cf)

End

![image](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC03T5/assets/160529556/c0dec0da-edf4-48bf-bb52-04778182c860)


### Retrospectives:
This iteration aimed primarily at adding value for the user by implementing the following features:

- Create Trip: Users can now create new trips, specifying details such as destination, departure date, number of passengers.

- Join a Trip: We have added the functionality for users to join trips already created by other members.

- Trip Chat: We implemented a specific chat for each trip. This feature allows participants to communicate with each other, enabling passengers to know the driver's location before being picked up.

- View Trip Details: Users can now view all the important details of a trip in one place. This includes information about the itinerary, number of participants, meeting points, and any other relevant notes. This feature helps keep all members informed and prepared.

- Cancel Trip: We added the ability to cancel trips. Organizers can now cancel a trip.
