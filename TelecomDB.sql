DROP DATABASE IF EXISTS TelecomDB;
CREATE DATABASE TelecomDB;
USE TelecomDB;
CREATE DATABASE IF NOT EXISTS TelecomDB;
USE TelecomDB;

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address TEXT,
    JoinDate DATE NOT NULL,
    Status ENUM('Active', 'Inactive') NOT NULL
);

CREATE TABLE Plan (
    PlanID INT AUTO_INCREMENT PRIMARY KEY,
    PlanName VARCHAR(100) NOT NULL,
    PlanType ENUM('Prepaid', 'Postpaid') NOT NULL,
    MonthlyFee DECIMAL(10,2) NOT NULL,
    CallRate DECIMAL(5,2) NOT NULL,
    SMSRate DECIMAL(5,2) NOT NULL,
    DataRate DECIMAL(5,2) NOT NULL,
    ValidityPeriod INT NOT NULL
);

CREATE TABLE Subscription (
    SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PlanID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Status ENUM('Active', 'Cancelled') NOT NULL
);

CREATE TABLE UsageRecord (
    UsageID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    UsageType ENUM('Call', 'SMS', 'Data') NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME,
    DataUsedMB DECIMAL(10,2),
    DurationSec INT,
    Charge DECIMAL(10,2) NOT NULL
);

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    BillMonth VARCHAR(7) NOT NULL,
    TotalUsageCharge DECIMAL(10,2) NOT NULL,
    MonthlyFee DECIMAL(10,2) NOT NULL,
    TotalBill DECIMAL(10,2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid') NOT NULL,
    GeneratedDate DATE NOT NULL
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod ENUM('Card', 'BankTransfer', 'Cash', 'Online') NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentReference VARCHAR(100)
);
ALTER TABLE Subscription
ADD CONSTRAINT fk_Subscription_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
ADD CONSTRAINT fk_Subscription_Plan FOREIGN KEY (PlanID) REFERENCES Plan(PlanID);

ALTER TABLE UsageRecord
ADD CONSTRAINT fk_UsageRecord_Subscription FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID);

ALTER TABLE Billing
ADD CONSTRAINT fk_Billing_Subscription FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID);

ALTER TABLE Payment
ADD CONSTRAINT fk_Payment_Billing FOREIGN KEY (BillID) REFERENCES Billing(BillID);
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, Address, JoinDate, Status)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street', '2024-01-01', 'Active'),
('John', 'Smith', 'john.smith0@example.com', '9666677217', '246 Main St', '2024-06-27', 'Inactive'),
('Jane', 'Khan', 'jane.khan1@example.com', '5803294525', '237 Oak St', '2024-06-01', 'Inactive'),
('Ali', 'Fernandez', 'ali.fernandez2@example.com', '5587313403', '68 Main St', '2024-01-11', 'Active'),
('Maria', 'Müller', 'maria.müller3@example.com', '4892645209', '558 Pine St', '2024-03-16', 'Active'),
('Leo', 'Patel', 'leo.patel4@example.com', '2048673383', '910 Main St', '2024-06-17', 'Active'),
('Anika', 'Schmidt', 'anika.schmidt5@example.com', '2102366108', '481 Cedar St', '2024-05-26', 'Active'),
('Liam', 'Brown', 'liam.brown6@example.com', '3871769545', '244 Main St', '2024-04-26', 'Active'),
('Olivia', 'Garcia', 'olivia.garcia7@example.com', '6874370056', '904 Main St', '2024-05-05', 'Inactive'),
('Noah', 'Jones', 'noah.jones8@example.com', '1389178729', '252 Pine St', '2024-01-03', 'Active'),
('Emma', 'Davis', 'emma.davis9@example.com', '4744183033', '269 Pine St', '2024-01-25', 'Inactive'),
('Ava', 'Rodriguez', 'ava.rodriguez10@example.com', '5355604423', '695 Cedar St', '2024-03-15', 'Inactive'),
('Ethan', 'Martinez', 'ethan.martinez11@example.com', '8911372600', '199 Main St', '2024-05-21', 'Active'),
('Mia', 'Lee', 'mia.lee12@example.com', '3508835939', '59 Pine St', '2024-06-10', 'Active'),
('Lucas', 'Walker', 'lucas.walker13@example.com', '7569357084', '100 Main St', '2024-03-28', 'Inactive'),
('Ella', 'Hall', 'ella.hall14@example.com', '8457106300', '225 Cedar St', '2024-04-24', 'Inactive'),
('Mason', 'Young', 'mason.young15@example.com', '2977971119', '195 Cedar St', '2024-02-15', 'Active'),
('Sofia', 'Allen', 'sofia.allen16@example.com', '6726202972', '299 Main St', '2024-06-05', 'Inactive'),
('Logan', 'King', 'logan.king17@example.com', '9895111318', '527 Pine St', '2024-04-28', 'Inactive'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Maple Avenue', '2024-02-15', 'Active');
SELECT * FROM Customer;

INSERT INTO Plan (PlanName, PlanType, MonthlyFee, CallRate, SMSRate, DataRate, ValidityPeriod)
VALUES
('Basic Prepaid', 'Prepaid', 0.00, 0.5, 0.3, 0.1, 28),
('Premium Postpaid', 'Postpaid', 25.00, 0.3, 0.2, 0.05, 30);
INSERT INTO Subscription (CustomerID, PlanID, StartDate, EndDate, Status)
VALUES
(1, 1, '2024-03-01', NULL, 'Active'),
(2, 2, '2024-03-10', NULL, 'Active'),
(3, 2, '2024-03-15', NULL, 'Active'),
(4, 1, '2024-03-13', NULL, 'Active'),
(5, 2, '2024-03-13', '2024-06-09', 'Cancelled'),
(6, 1, '2024-03-14', NULL, 'Active'),
(7, 2, '2024-03-15', NULL, 'Active'),
(8, 1, '2024-03-19', NULL, 'Active'),
(9, 2, '2024-03-24', '2024-06-26', 'Cancelled'),
(10, 1, '2024-03-22', NULL, 'Active'),
(11, 2, '2024-03-06', NULL, 'Active'),
(12, 1, '2024-03-26', '2024-06-06', 'Cancelled'),
(13, 2, '2024-03-06', NULL, 'Active'),
(14, 1, '2024-03-08', NULL, 'Active'),
(15, 2, '2024-03-20', '2024-06-17', 'Cancelled'),
(16, 1, '2024-03-09', NULL, 'Active'),
(17, 2, '2024-03-08', '2024-06-18', 'Cancelled'),
(18, 1, '2024-03-18', NULL, 'Active'),
(19, 2, '2024-03-07', NULL, 'Active'),
(20, 1, '2024-03-09', NULL, 'Active');
SELECT * FROM Subscription;

INSERT INTO UsageRecord (SubscriptionID, UsageType, StartTime, EndTime, DataUsedMB, DurationSec, Charge)
VALUES
(1, 'Call', '2024-06-01 10:00:00', '2024-06-01 10:05:00', NULL, 300, 1.50),
(1, 'SMS', '2024-06-01 11:00:00', NULL, NULL, NULL, 0.30),
(1, 'Data', '2024-06-01 12:00:00', NULL, 200.5, NULL, 20.05),

(2, 'Call', '2024-06-02 09:00:00', '2024-06-02 09:15:00', NULL, 900, 2.70),
(2, 'Data', '2024-06-02 10:00:00', NULL, 500, NULL, 25.00),
(3, 'Data', '2024-06-16 20:00:00', NULL, 438.66, NULL, 21.93),
(3, 'Data', '2024-06-25 09:00:00', NULL, 375.26, NULL, 18.76),
(4, 'Call', '2024-06-09 09:00:00', '2024-06-09 09:01:28', NULL, 88, 0.44),
(4, 'Call', '2024-06-28 20:00:00', '2024-06-28 20:04:07', NULL, 247, 1.24),
(5, 'SMS', '2024-06-20 08:00:00', NULL, NULL, NULL, 0.44),
(5, 'Data', '2024-06-01 15:00:00', NULL, 518.63, NULL, 25.93),
(6, 'SMS', '2024-06-05 08:00:00', NULL, NULL, NULL, 0.38),
(6, 'Call', '2024-06-24 19:00:00', '2024-06-24 19:03:19', NULL, 199, 0.99),
(7, 'Data', '2024-06-24 19:00:00', NULL, 792.62, NULL, 39.63),
(7, 'SMS', '2024-06-12 10:00:00', NULL, NULL, NULL, 0.28),
(8, 'SMS', '2024-06-10 14:00:00', NULL, NULL, NULL, 0.39),
(8, 'Call', '2024-06-19 09:00:00', '2024-06-19 09:02:24', NULL, 144, 0.72),
(9, 'Data', '2024-06-12 11:00:00', NULL, 702.6, NULL, 35.13),
(9, 'Data', '2024-06-21 14:00:00', NULL, 562.92, NULL, 28.15),
(10, 'SMS', '2024-06-28 16:00:00', NULL, NULL, NULL, 0.43),
(10, 'SMS', '2024-06-28 20:00:00', NULL, NULL, NULL, 0.45),
(11, 'SMS', '2024-06-15 17:00:00', NULL, NULL, NULL, 0.29),
(11, 'Data', '2024-06-07 20:00:00', NULL, 410.41, NULL, 20.52),
(12, 'SMS', '2024-06-03 10:00:00', NULL, NULL, NULL, 0.38),
(12, 'SMS', '2024-06-17 08:00:00', NULL, NULL, NULL, 0.49),
(13, 'Data', '2024-06-23 19:00:00', NULL, 515.02, NULL, 25.75),
(13, 'SMS', '2024-06-28 09:00:00', NULL, NULL, NULL, 0.36),
(14, 'Data', '2024-06-13 17:00:00', NULL, 245.15, NULL, 12.26),
(14, 'Call', '2024-06-06 12:00:00', '2024-06-06 12:08:00', NULL, 480, 2.40)
;

INSERT INTO Billing (SubscriptionID, BillMonth, TotalUsageCharge, MonthlyFee, TotalBill, PaymentStatus, GeneratedDate)
VALUES
(1, '2024-06', 21.85, 0.00, 21.85, 'Unpaid', '2024-06-30'),
(2, '2024-06', 27.70, 25.00, 52.70, 'Paid', '2024-06-30'),
(3, '2024-06', 36.67, 0.0, 36.67, 'Paid', '2024-06-30'),
(4, '2024-06', 27.45, 25.0, 52.45, 'Paid', '2024-06-30'),
(5, '2024-06', 7.77, 0.0, 7.77, 'Paid', '2024-06-30'),
(6, '2024-06', 42.68, 25.0, 67.68, 'Paid', '2024-06-30'),
(7, '2024-06', 36.9, 0.0, 36.9, 'Unpaid', '2024-06-30'),
(8, '2024-06', 18.41, 25.0, 43.41, 'Paid', '2024-06-30'),
(9, '2024-06', 8.05, 0.0, 8.05, 'Paid', '2024-06-30'),
(10, '2024-06', 15.61, 25.0, 40.61, 'Unpaid', '2024-06-30'),
(11, '2024-06', 11.16, 0.0, 11.16, 'Unpaid', '2024-06-30'),
(12, '2024-06', 39.14, 25.0, 64.14, 'Unpaid', '2024-06-30'),
(13, '2024-06', 42.8, 0.0, 42.8, 'Paid', '2024-06-30'),
(14, '2024-06', 23.0, 25.0, 48.0, 'Paid', '2024-06-30'),
(15, '2024-06', 33.92, 0.0, 33.92, 'Unpaid', '2024-06-30'),
(16, '2024-06', 9.6, 25.0, 34.6, 'Unpaid', '2024-06-30'),
(17, '2024-06', 6.57, 0.0, 6.57, 'Unpaid', '2024-06-30'),
(18, '2024-06', 22.35, 25.0, 47.35, 'Paid', '2024-06-30'),
(19, '2024-06', 14.63, 0.0, 14.63, 'Paid', '2024-06-30'),
(20, '2024-06', 30.2, 25.0, 55.2, 'Paid', '2024-06-30');

INSERT INTO Payment (BillID, PaymentDate, PaymentMethod, AmountPaid, PaymentReference)
VALUES
(2, '2024-07-01', 'Card', 52.70, 'TXN123456'),
(3, '2024-07-01', 'Cash', 36.67, 'TXN838594'),
(4, '2024-07-01', 'BankTransfer', 52.45, 'TXN150029'),
(5, '2024-07-01', 'Card', 7.77, 'TXN831422'),
(6, '2024-07-01', 'Online', 67.68, 'TXN140845'),
(8, '2024-07-01', 'Online', 43.41, 'TXN341802'),
(9, '2024-07-01', 'BankTransfer', 8.05, 'TXN291408'),
(13, '2024-07-01', 'Online', 42.8, 'TXN237533'),
(14, '2024-07-01', 'Card', 48.0, 'TXN931970'),
(18, '2024-07-01', 'BankTransfer', 47.35, 'TXN333371'),
(19, '2024-07-01', 'Online', 14.63, 'TXN264175'),
(20, '2024-07-01', 'Cash', 55.2, 'TXN707605');

SELECT CustomerID, FirstName, LastName, Email, PhoneNumber
FROM Customer
WHERE Status = 'Active';
SELECT 
    s.SubscriptionID,
    c.FirstName,
    c.LastName,
    p.PlanName,
    p.PlanType,
    s.Status
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Plan p ON s.PlanID = p.PlanID
WHERE s.Status = 'Active';
SELECT 
    u.UsageType,
    u.StartTime,
    u.EndTime,
    u.DataUsedMB,
    u.DurationSec,
    u.Charge
FROM UsageRecord u
WHERE u.SubscriptionID = 2 ;
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    b.BillMonth,
    b.TotalUsageCharge,
    b.MonthlyFee,
    b.TotalBill,
    b.PaymentStatus
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
JOIN Billing b ON s.SubscriptionID = b.SubscriptionID;
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    b.BillMonth,
    b.TotalBill
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
JOIN Billing b ON s.SubscriptionID = b.SubscriptionID
WHERE b.TotalBill > 50;
SELECT 
    c.FirstName,
    c.LastName,
    b.BillMonth,
    b.TotalBill
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
JOIN Billing b ON s.SubscriptionID = b.SubscriptionID
WHERE b.PaymentStatus = 'Unpaid';
