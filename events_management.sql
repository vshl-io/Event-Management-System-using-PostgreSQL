--Create Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(250) NOT NULL,
    Event_Description TEXT NOT NULL -- used TEXT data type to store longer descriptions
);

--Create Attendees Table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL, -- used VARCHAR to store ISD & STD codes
    Attendee_Email VARCHAR(100) UNIQUE NOT NULL,
    Attendee_City VARCHAR(100) NOT NULL
);

--Create Registrations Table
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT REFERENCES Events(Event_Id),
    Attendee_Id INT REFERENCES Attendees(Attendee_Id),
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(6, 1) NOT NULL,
    UNIQUE (Event_Id, Attendee_Id)
);

--Inserting data into Events table
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Startup Expo', '2025-05-20', 'Chennai', 'Showcasing innovative startups and technology solutions.'),
('Fintech Summit', '2025-08-15', 'Coimbatore', 'Conference on latest trends in financial technology.'),
('AI & Robotics Expo', '2025-11-10', 'Trichy', 'Exhibition on artificial intelligence and robotics advancements.'),
('Cyber-security Forum', '2025-06-18', 'Madurai', 'Discussions and workshops on cyber security best practices.'),
('Green Tech Conference', '2025-09-05', 'Salem', 'Focus on sustainable and green technology innovations.'),
('Maritime Tech Fair', '2025-10-12', 'Tuticorin', 'Showcase of maritime technology and logistics solutions.'),
('HealthTech Summit', '2025-07-22', 'Vellore', 'Innovations in healthcare technology and medical devices.'),
('IoT Expo', '2025-12-02', 'Erode', 'Internet of Things (IoT) technology demonstrations and talks.'),
('Blockchain Conference', '2025-11-25', 'Nagercoil', 'Exploring blockchain applications and fintech use cases.'),
('Data Science Workshop', '2025-08-30', 'Tirunelveli', 'Hands-on sessions on data science and analytics.');

--Inserting data into attendees table
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Kumar Raj', '+91-9840123456', 'kumar.raj@yahoo.com', 'Chennai'),
('Saradha Devi', '+91-9444123456', 'saradha.devi@gmail.com', 'Coimbatore'),
('Arun Prakash', '+91-9003123456', 'arun.prakash@gmail.com', 'Trichy'),
('Ramya Vasanth', '+91-9952123456', 'ramya.vasanth@gmail.com', 'Madurai'),
('Mani Subramanian', '+91-9876543210', 'mani.subramanian@hotmail.com', 'Salem'),
('Divya Krishnan', '+91-9444001122', 'divya.krishnan@gmail.com', 'Tuticorin'),
('Raghav Arjun', '+91-909009001', 'raghav.arjun@gmail.com', 'Vellore'),
('Anjali Raj', '+91-9888777666', 'anjali.raj@gmail.com', 'Erode'),
('Karthik Balaji', '+91-9900112233', 'karthik.balaji@gmail.com', 'Nagercoil'),
('Meena Ramesh', '+91-9876123456', 'meena.ramesh@gmail.com', 'Tirunelveli');

--Inserting data into registrations table
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1, 2, '2025-05-01', 300.0),
(2, 2, '2025-05-10', 300.0),
(3, 3, '2025-08-01', 400.0),
(3, 4, '2025-10-20', 350.0),
(4, 5, '2025-10-25', 350.0),
(5, 6, '2025-06-10', 250.0),
(7, 8, '2025-09-01', 300.0),
(8, 9, '2025-10-05', 280.0),
(9, 10, '2025-07-15', 320.0),
(10, 1, '2025-11-20', 270.0);

--Inserting a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES (
    'AgriTech Innovation Fair',
    '2025-12-20',
    'Thanjavur',
    'An exhibition focused on agricultural technologies and smart farming solutions.'
);

/* Updating an Event's Information
Example: Update the location and description of the event "Fintech Summit" */
UPDATE Events
SET 
    Event_Location = 'Chennai',
    Event_Description = 'Updated summit focusing on digital payments and blockchain in finance.'
WHERE 
    Event_Id = 2;  -- Fintech Summit's event id

/* Deleting an event:
Example: Delete the event named "Green Tech Conference" */

--Step1: Delete registrations linked to the event 
DELETE FROM Registrations WHERE Event_Id = 5;

--Step2: Delete the event itself 
DELETE FROM Events WHERE Event_Id = 5;

-- Inserting a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES (
    'Deepa Narayanan', '+91-9876543211', 'deepa.narayanan@gmait.com', 'Chennai'
);

/* Registering an Attendee for an Event */
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES 
(2, 11, '2025-08-10', 450.0);

--Retrieve Event Information: List all events (basic details)
SELECT * FROM registrations

--Generate attendee lists
SELECT r.event_id, r.attendee_id, e.event_name, a.attendee_name, r.registration_date, e.event_date  FROM registrations r
JOIN  attendees a
ON r.attendee_id = a.attendee_id
JOIN events e
ON r.event_id = e.event_id
ORDER BY r.event_id, e.event_date;

--Calculate event attendance statistics
SELECT e.event_id, e.event_name, e.event_date, e.event_location, COUNT(*) as total_attendees FROM events e
JOIN registrations r
ON e.event_id = r.event_id
GROUP by e.event_id, e.event_name, e.event_date, e.event_location
ORDER BY event_date;














