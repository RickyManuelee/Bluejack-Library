CREATE DATABASE BluejackLibrary
GO
USE BluejackLibrary
GO
CREATE TABLE [BLStaff] (
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR(100) NOT NULL,
	StaffGender VARCHAR(10) CHECK (StaffGender = 'MALE' OR StaffGender = 'FEMALE') NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	StaffPhoneNumber VARCHAR(15) CHECK (StaffPhoneNumber LIKE '+62%') NOT NULL,
	StaffSalary INT NOT NULL
);

INSERT INTO [BLStaff] VALUES 
('SF001', 'Andi', 'Male', 'Sudirman Avenue', '+6285601242039', 4500000),
('SF002', 'Reza', 'Male', 'Tanggerang Avenue', '+6281817593618', 6500000),
('SF003', 'Fikri', 'Male', 'Kuningan Village', '+6289885191745', 5500000),
('SF004', 'Caca', 'Female', 'Surabaya Street', '+6285879362452', 5000000),
('SF005', 'Mia', 'Female', 'Pedurenan Avenue', '+6285615287363', 4500000),
('SF006', 'Rudy', 'Male', 'Kampung Bali Village', '+6288772861861', 4500000),
('SF007', 'Lia', 'Female', 'Menteng Street', '+6287841729427', 5500000),
('SF008', 'Frank', 'Male', 'Ahmad Yani Avenue', '+6285861647316', 5000000),
('SF009', 'Ruri', 'Female', 'Kebayoran Street', '+6281889413869', 6500000),
('SF010', 'Yuni', 'Female', 'Pegangsaan Village', '+6288712936959', 5000000);

CREATE TABLE [BLStudent] (
	StudentID CHAR(5) PRIMARY KEY CHECK (StudentID LIKE 'ST[0-9][0-9][0-9]'),
	StudentName VARCHAR(100) NOT NULL,
	StudentGender VARCHAR(10) CHECK (StudentGender = 'MALE' OR StudentGender = 'FEMALE'),
	StudentAddress VARCHAR(100) NOT NULL,
	StudentEmail VARCHAR(100) CHECK(StudentEmail LIKE '%@%') NOT NULL
);

INSERT INTO [BLStudent] VALUES 
('ST001', 'Chloe', 'Female', 'Cempaka Putih Avenue', 'ChloeImoetz@gmail.com'),
('ST002', 'Jay', 'Male', 'Gambir Street', 'ItsmeJayy@gmail.com'),
('ST003', 'Kevin', 'Male', 'Kemayoran Street', 'KevinChip13@yahoo.com'),
('ST004', 'Lisa', 'Female', 'Menteng Street', 'Lilisaa@gmail.com'),
('ST005', 'Darren', 'Male', 'Tanah Abang Avenue', 'Darren1040@yahoo.com'),
('ST006', 'Rose', 'Female', 'Hayam Wuruk Village', 'Roseanne@yahoo.com'),
('ST007', 'Jean', 'Female', 'Gajah Mada Street', 'JeanEmerald@yahoo.com'),
('ST008', 'Jake', 'Male', 'Senen Village', 'JakeTheReap@gmail.com'),
('ST009', 'James', 'Male', 'Fatmawati Village', 'JamesBonk@gmail.com'),
('ST010', 'Tifanny', 'Female', 'Ismail Marzuki Avenue', 'Tifa.fanny@yahoo.com');

CREATE TABLE [BLDonator] (
	DonatorID CHAR(5) PRIMARY KEY CHECK (DonatorID LIKE 'DR[0-9][0-9][0-9]'),
	DonatorName VARCHAR(100) NOT NULL,
	DonatorGender VARCHAR(10) CHECK (DonatorGender = 'MALE' OR DonatorGender = 'FEMALE') NOT NULL,
	DonatorAddress VARCHAR(100) NOT NULL,
	DonatorPhoneNumber VARCHAR(15) CHECK (DonatorPhoneNumber LIKE '+62%') NOT NULL
);

INSERT INTO [BLDonator] VALUES
('DR001', 'Eleni Zara', 'Female', 'Pajajaran Street', '+6288711349169'),
('DR002', 'Zunaira', 'Female', 'Kampung Melayu Avenue', '+6285644895662'),
('DR003', 'Felicia', 'Female', 'Ahmad Yani Street', '+6285645561556'),
('DR004', 'Osama Conway', 'Male', 'Tanah Abang Village', '+6285833225212'),
('DR005', 'Holli Gibson', 'Male', 'Rasuna Said Street', '+6281892816373'),
('DR006', 'Denzel Barclay', 'Male', 'Kebon Sirih Avenue', '+6288796317914'),
('DR007', 'Rheanna Doherty', 'Female', 'Jatibaru Village', '+6289833646826'),
('DR008', 'Zishan', 'Male', 'Petojo Street', '+6287828488964'),
('DR009', 'Kristopher James', 'Male', 'Utan Kayu Village', '+6288729375436'),
('DR010', 'Alyce Lawrence', 'Female', 'Mangga Dua Avenue', '+6281881657192');

CREATE TABLE [BLBookCategory] (
	BookCategoryID CHAR(5) PRIMARY KEY CHECK (BookCategoryID Like 'BC[0-9][0-9][0-9]'),
	BookCategoryName VARCHAR(50) NOT NULL
);

INSERT INTO [BLBookCategory] VALUES 
('BC001', 'Fantasy'),
('BC002', 'Mystery'),
('BC003', 'Education'),
('BC004', 'Romance'),
('BC005', 'Sci-fi');

CREATE TABLE [BLBook] (
    BookID CHAR(5) PRIMARY KEY CHECK (BookID LIKE 'BK[0-9][0-9][0-9]'),
    BookCategoryID CHAR(5) FOREIGN KEY REFERENCES BLBookCategory(BookCategoryID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    BookTittle VARCHAR(100) NOT NULL,
	BookPublishDate DATE NOT NULL,
    BookStock INT NOT NULL,
    BookRating FLOAT NOT NULL
);

INSERT INTO [BLBook] VALUES 
('BK001','BC001', 'A Dark Crime', '2011-01-25', '23', '4.4'),
('BK002','BC002', 'Artemis', '2012-02-24', '13','5.0'),
('BK003','BC003', 'Laskar Pelangi', '2013-03-23', '17','4.7'),
('BK004','BC004', 'Harry Potter', '2014-04-22', '12','5.0'),
('BK005','BC005', 'Divergent', '2015-05-21', '15','4.5'),
('BK006','BC001', 'Red Queen', '2016-06-20', '32','3.5'),
('BK007','BC002', 'Never Let Me go', '2017-07-19', '19','4.3'),
('BK008','BC003', 'A Simple Plan', '2018-08-18', '28','2.9'),
('BK009','BC004', 'Outlander', '2019-09-17', '12','3.8'),
('BK010','BC005', 'Strange the Dreamer', '2020-10-16', '20','4.5'),
('BK011','BC001', 'Odyssey', '2019-11-15', '29', '4.3'),
('BK012','BC002', 'The Road', '2018-12-14', '25','2.9'),
('BK013','BC003', 'The Wedding Games', '2017-11-13', '18','3.2'),
('BK014','BC004', 'Fahrenheit 451', '2016-10-12', '19','3.1'),
('BK015','BC005', 'The Missing Rose', '2015-09-11', '32','4.1'),
('BK016','BC001', 'Robin Hood', '2014-08-10', '32','5.0'),
('BK017','BC002', 'Love Letters', '2013-07-09', '30','5.0'),
('BK018','BC003', 'The BFG', '2012-06-08', '18','3.7'),
('BK019','BC004', 'The Golden Son', '2015-05-07', '23','4.0'),
('BK020','BC005', 'Saga', '2016-04-06', '19','3.5'),
('BK021','BC001', 'The Martian', '2017-03-05', '12', '3.8'),
('BK022','BC002', 'Champion', '2018-02-04', '21','5.0'),
('BK023','BC003', 'Protector', '2019-01-03', '37','4.6'),
('BK024','BC004', 'Dust', '2020-02-02', '11','2.9'),
('BK025','BC005', 'Pokemon', '2011-03-01', '12','4.3');

CREATE TABLE [BLBorrowTransaction] (
	BorrowTransactionID CHAR(5) PRIMARY KEY CHECK (BorrowTransactionID LIKE 'BT[0-9][0-9][0-9]'),
	StudentID CHAR(5) FOREIGN KEY REFERENCES BLStudent(StudentID) ON UPDATE CASCADE ON DELETE CASCADE,
	StaffID CHAR(5) FOREIGN KEY REFERENCES BLStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE,
	BorrowDate DATE NOT NULL,
	ReturnDate DATE NOT NULL
);

INSERT INTO [BLBorrowTransaction] VALUES 
('BT001','ST001','SF001','2011-07-09','2011-07-16'),
('BT002','ST002','SF002','2015-08-27','2015-09-03'),
('BT003','ST003','SF003','2013-12-11','2013-12-18'),
('BT004','ST004','SF004','2020-10-13','2020-10-20'),
('BT005','ST005','SF005','2018-11-25','2018-12-02'),
('BT006','ST006','SF006','2016-02-18','2016-02-25'),
('BT007','ST007','SF007','2020-09-20','2020-09-27'),
('BT008','ST008','SF008','2013-06-14','2013-06-21'),
('BT009','ST009','SF009','2020-12-02','2020-12-07'),
('BT010','ST010','SF010','2019-10-06','2019-10-13'),
('BT011','ST001','SF001','2020-09-02','2020-09-07'),
('BT012','ST002','SF002','2015-12-25','2015-12-30'),
('BT013','ST003','SF003','2019-05-16','2019-05-23'),
('BT014','ST004','SF004','2020-04-19','2020-04-25'),
('BT015','ST005','SF005','2015-05-13','2015-05-16'),
('BT016','ST006','SF006','2016-09-23','2016-09-25'),
('BT017','ST007','SF007','2020-03-04','2020-03-08'),
('BT018','ST008','SF008','2013-01-01','2013-01-07'),
('BT019','ST009','SF009','2020-12-12','2020-12-15'),
('BT020','ST010','SF010','2019-07-10','2019-07-15'),
('BT021','ST001','SF001','2020-10-05','2020-10-10'),
('BT022','ST002','SF002','2015-09-25','2015-09-26'),
('BT023','ST003','SF003','2019-02-09','2019-02-15'),
('BT024','ST004','SF004','2020-11-13','2020-11-18'),
('BT025','ST005','SF005','2015-08-29','2015-09-04');

CREATE TABLE [BLBorrowDetail] (
	BorrowTransactionID CHAR(5) PRIMARY KEY REFERENCES BLBorrowTransaction(BorrowTransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	BookID CHAR(5) FOREIGN KEY REFERENCES BLBook(BookID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	BorrowQuantity INT NOT NULL,
);

INSERT INTO [BLBorrowDetail] VALUES
('BT001','BK001','3'),
('BT002','BK002','1'),
('BT003','BK003','2'),
('BT004','BK004','1'),
('BT005','BK005','3'),
('BT006','BK006','2'),
('BT007','BK007','2'),
('BT008','BK008','3'),
('BT009','BK009','1'),
('BT010','BK010','3'),
('BT011','BK011','2'),
('BT012','BK012','4'),
('BT013','BK013','1'),
('BT014','BK014','5'),
('BT015','BK015','2'),
('BT016','BK016','4'),
('BT017','BK017','3'),
('BT018','BK018','1'),
('BT019','BK019','2'),
('BT020','BK020','5'),
('BT021','BK021','3'),
('BT022','BK022','4'),
('BT023','BK023','2'),
('BT024','BK024','1'),
('BT025','BK025','3');

CREATE TABLE [BLDonationTransaction] (
	DonationTransactionID CHAR(5) PRIMARY KEY CHECK (DonationTransactionID LIKE 'DT[0-9][0-9][0-9]'),
	DonatorID CHAR(5) FOREIGN KEY REFERENCES BLDonator(DonatorID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES BLStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DonationTransactionDate DATE NOT NULL
);

INSERT INTO [BLDonationTransaction] VALUES
('DT001', 'DR001', 'SF001', '11-2-2021'),
('DT002', 'DR002', 'SF002', '5-21-2021'),
('DT003', 'DR003', 'SF003', '3-14-2021'),
('DT004', 'DR004', 'SF004', '9-7-2021'),
('DT005', 'DR005', 'SF005', '5-28-2021'),
('DT006', 'DR006', 'SF006', '1-19-2021'),
('DT007', 'DR007', 'SF007', '12-8-2021'),
('DT008', 'DR008', 'SF008', '10-10-2021'),
('DT009', 'DR009', 'SF009', '4-12-2021'),
('DT010', 'DR010', 'SF010', '12-27-2021'),
('DT011', 'DR001', 'SF001', '5-2-2021'),
('DT012', 'DR002', 'SF002', '8-28-2021'),
('DT013', 'DR003', 'SF003', '9-2-2021'),
('DT014', 'DR004', 'SF004', '4-10-2021'),
('DT015', 'DR005', 'SF005', '12-31-2021');

CREATE TABLE [BLDonationDetail] (
	DonationTransactionID CHAR(5) PRIMARY KEY REFERENCES BLDonationTransaction(DonationTransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	BookID CHAR(5) FOREIGN KEY REFERENCES BLBook(BookID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DonationQuantity INT NOT NULL,
);

INSERT INTO BLDonationDetail VALUES
('DT001', 'BK001', '70'),
('DT002', 'BK002', '101'),
('DT003', 'BK003', '58'),
('DT004', 'BK004', '170'),
('DT005', 'BK005', '338'),
('DT006', 'BK006', '215'),
('DT007', 'BK007', '254'),
('DT008', 'BK008', '90'),
('DT009', 'BK009', '414'),
('DT010', 'BK010', '310'),
('DT011', 'BK011', '123'),
('DT012', 'BK012', '65'),
('DT013', 'BK013', '10'),
('DT014', 'BK014', '70'),
('DT015', 'BK015', '150');

DROP DATABASE BluejackLibrary