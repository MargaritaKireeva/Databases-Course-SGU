CREATE DATABASE HotelSystem
COLLATE Cyrillic_General_100_CI_AI
GO
CREATE TABLE Country 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Country PRIMARY KEY,
	Name varchar(255) NOT NULL,
)
GO
CREATE TABLE City 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_City PRIMARY KEY,
	Name varchar(255) NOT NULL,
	CountryID int NOT NULL,
	CONSTRAINT FK_Country_ID FOREIGN KEY(CountryID) REFERENCES Country(ID)
)
GO
CREATE TABLE Hotel 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Hotel PRIMARY KEY,
	CityID int NOT NULL,
	CONSTRAINT FK_City_ID FOREIGN KEY(CityID) REFERENCES City(ID)
)
GO
CREATE TABLE RoomType 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_RoomType PRIMARY KEY,
	Price int NOT NULL,
	TypeName varchar(255) NOT NULL,
	CountOfSeats int NOT NULL,
	CountOfBeds int NOT NULL,
)
GO
CREATE TABLE Room 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Room PRIMARY KEY,
	HotelID int NOT NULL,
	TypeID int NOT NULL,
	CONSTRAINT FK_Hotel_ID FOREIGN KEY(HotelID) REFERENCES Hotel(ID),
	CONSTRAINT FK_RoomType_ID FOREIGN KEY(TypeID) REFERENCES RoomType(ID)
)
GO
CREATE TABLE Client (
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Client PRIMARY KEY,
	Name varchar(255) NOT NULL,
	Passport varchar(255) NOT NULL,
)
GO
CREATE TABLE BookingInfo 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_BookingInfo PRIMARY KEY,
	ClientID int NOT NULL,
	RoomTypeID int NOT NULL,
	ArrivalDate datetime NOT NULL,
	DepartureDate datetime NOT NULL,
	BookingDate datetime NOT NULL,
	HotelID int NOT NULL,
	RealizationInfo varchar(255) NOT NULL,
	CONSTRAINT FK_Client_ID FOREIGN KEY(ClientID) REFERENCES Client(ID),
	CONSTRAINT FK_RoomTypeID FOREIGN KEY(RoomTypeID) REFERENCES RoomType(ID),
	CONSTRAINT FK_HotelID FOREIGN KEY(HotelID) REFERENCES Hotel(ID)
)
GO
CREATE TABLE AccommodationInfo 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_AccommodationInfo PRIMARY KEY,
	ClientID int NOT NULL,
	RoomID int NOT NULL,
	BookingID int,
	ArrivalDate datetime NOT NULL,
	DepartureDate datetime NOT NULL,
	Cost int NOT NULL,
	CONSTRAINT FK_ClientID FOREIGN KEY(ClientID) REFERENCES Client(ID),
	CONSTRAINT FK_Room_ID FOREIGN KEY(RoomID) REFERENCES Room(ID),
	CONSTRAINT FK_BookingInfo_ID FOREIGN KEY(BookingID) REFERENCES BookingInfo(ID)
)
GO
CREATE TABLE RoomService 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_RoomService PRIMARY KEY,
	ServiceName varchar(255) NOT NULL,
	ServicePrice int NOT NULL,
)
GO

CREATE TABLE Employee 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Employee PRIMARY KEY,
	Name varchar(255) NOT NULL,
	HotelID int NOT NULL,
	CONSTRAINT FK_HotelID_Employee FOREIGN KEY(HotelID) REFERENCES Hotel(ID)
)
GO
CREATE TABLE ServicesRendered 
(
	ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ServicesRendered PRIMARY KEY,
	AccommodationID int NOT NULL,
	ServiceDate datetime NOT NULL,
	ServiceID int NOT NULL,
	EmployeeID int NOT NULL,
	Price int NOT NULL,
	CONSTRAINT FK_AccommodationInfo_ID FOREIGN KEY(AccommodationID) REFERENCES AccommodationInfo(ID),
	CONSTRAINT FK_RoomService_ID FOREIGN KEY(ServiceID) REFERENCES RoomService(ID),
	CONSTRAINT FK_Employee_ID FOREIGN KEY(EmployeeID) REFERENCES Employee(ID)
)
GO
CREATE TABLE TypeServicesConnection 
(
	ServiceID int NOT NULL,
	TypeID int NOT NULL,
	CONSTRAINT FK_RoomServiceID_Connect FOREIGN KEY(ServiceID) REFERENCES RoomService(ID),
	CONSTRAINT FK_RoomTypeID_Connect FOREIGN KEY(TypeID) REFERENCES RoomType(ID)
)
GO
INSERT INTO Country
VALUES ('Россия');
INSERT INTO Country
VALUES ('Латвия');
INSERT INTO Country
VALUES ('Турция');

INSERT INTO City
VALUES ('Москва', 1);
INSERT INTO City
VALUES ('Сочи', 1);
INSERT INTO City
VALUES ('Рига', 2);
INSERT INTO City
VALUES ('Анталья', 3);

INSERT INTO Hotel
VALUES (1);
INSERT INTO Hotel
VALUES (4);
INSERT INTO Hotel
VALUES (2);
INSERT INTO Hotel
VALUES (2);

INSERT INTO RoomType
VALUES (2500, 'Стандарт 1', 2, 1);

INSERT INTO Room
VALUES (1, 1);
INSERT INTO Room
VALUES (1, 1);

INSERT INTO Client
VALUES ('Киреева Маргарита Николаевна', '6315 612826');

--INSERT INTO BookingInfo 
--VALUES (1, 1, '');

DELETE City WHERE ID=3 -- удалили город Рига

DELETE Client -- очистили полностью таблицу Клиент
