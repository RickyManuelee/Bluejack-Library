/*1.Display StudentName, StudentAddress, BorrowTransactionID, BorrowTransactionDate,
and number of books borrowed (obtained from the total number of books borrowed) for
every borrow transaction happened in 2020 by student whose address ends with ‘ Street’.*/

SELECT 
	[Student Name] = bs.StudentName, 
	[Student Address] = bs.StudentAddress, 
	[Borrow Transaction ID] = bt.BorrowTransactionID, 
	[Book Date] = bt.BorrowDate, 
	[Books Borrowed] = SUM(bd.BorrowQuantity)
FROM BLStudent bs
JOIN BLBorrowTransaction bt
ON bs.StudentID = bt.StudentID
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
WHERE YEAR(BorrowDate) = 2020 AND bs.StudentAddress LIKE '%Street'
GROUP BY bs.StudentName, bs.StudentAddress, bt.BorrowTransactionID, bt.BorrowDate

/*2.Display BookTitle, Publish Month (obtained from the month of the book publish date),
BookCategoryName, and Total Sum Donation (obtained from the total donation quantity)
for each book whose category name contains ‘y’ and published in an odd month. */

SELECT 
	[Book Tittle] = bb.BookTittle, 
	[Publish Month] = MONTH(bb.BookPublishDate), 
	[Book Category Name] = bc.BookCategoryName, 
	[Total Sum Donation] = SUM(dd.DonationQuantity)
FROM BLBook bb
JOIN BLDonationDetail dd
ON dd.BookID = bb.BookID
JOIN BLBookCategory bc
ON bb.BookCategoryID = bc.BookCategoryID
WHERE bb.BookTittle LIKE ('%y%') AND MONTH(bb.BookPublishDate)%2 = 1
GROUP BY bb.BookTittle, MONTH(bb.BookPublishDate), bc.BookCategoryName

/*3.Display BorrowTransactionID, Borrow Transaction Date (obtained from
BorrowTransactionDate with ‘dd mon yyyy’ format), StudentName, Books Borrowed
(obtained from the total number of borrowed books), and Average Book Rating
(obtained from the average rating of borrowed books) for every borrow transaction
whose student has ‘gmail’ domain email and Average Book Rating more than 4.0.  */

SELECT 
	[Borrow Transaction ID] = bt.BorrowTransactionID, 
	[Borrow Date] = CONVERT(VARCHAR, bt.BorrowDate, 106),
	[Student Name] = bs.StudentName,
	[Books Borrowed] = SUM(bd.BorrowQuantity),
	[Average Book Rating] = AVG(bb.BookRating)
FROM BLBorrowTransaction bt
JOIN BLStudent bs
ON bt.StudentID = bs.StudentID
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
JOIN BLBook bb
ON bd.BookID = bb.BookID
WHERE bs.StudentEmail LIKE ('%gmail%')
GROUP BY bt.BorrowTransactionID, bt.BorrowDate, bs.StudentName
HAVING AVG(bb.BookRating) > 4.0

/*4.Display DonatorName (obtained from DonatorName and started with ‘Ms.’),
DonationDate (obtained from DonationDate with ‘Mon dd, yyyy’ format), Books Donated
(obtained from the number of donated books), and Average Rating (obtained from the
average rating of the donated books) for each donation happened in the first two weeks
(inclusively between the 1st and the 14th day) from a female donator. */

SELECT 
	[DonatorName] = 'Ms.' + CAST(bd.DonatorName AS VARCHAR(100)), 
	[Donation Transaction Date] = CONVERT(VARCHAR, dt.DonationTransactionDate, 107),  
	[Books Donated] = dd.DonationQuantity, 
	[AverageRating] = AVG(bb.BookRating)
FROM BLDonator bd
JOIN BLDonationTransaction dt
ON bd.DonatorID = dt.DonatorID
JOIN BLDonationDetail dd
ON dt.DonationTransactionID = dd.DonationTransactionID
JOIN BLBook bb
ON dd.BookID = bb.BookID
WHERE bd.DonatorGender = 'Female'
GROUP BY bd.DonatorName, dt.DonationTransactionDate, dd.DonationQuantity, bb.BookRating
HAVING DAY(dt.DonationTransactionDate) BETWEEN '1' AND '14'

/*5.Display DonatorName, DonationDate, StaffName, StaffGender, and StaffSalary
(obtained from StaffSalary and started with ‘Rp.’) for every donation completed by
staff whose salary is more than the average staff salary and its donator name consists
of minimum two words. Sort the result by DonationDate in descending order.
(alias subquery)
*/

SELECT 
	[Donator Name] = bd.DonatorName, 
	[Donation Date] = dt.DonationTransactionDate, 
	[Staff Name] = bs.StaffName, 
	[Staff Gender] = bs.StaffGender,
	[Staff Salary] = 'Rp. ' + CAST(bs.StaffSalary AS VARCHAR(255))
FROM BLDonator bd
JOIN BLDonationTransaction dt
ON bd.DonatorID = dt.DonatorID
JOIN BLStaff bs
ON dt.StaffID = bs.StaffID
WHERE bs.StaffSalary > (
	SELECT AVG(StaffSalary)
	FROM BLStaff
) AND bd.DonatorName LIKE '% %'
ORDER BY DonationTransactionDate DESC

/*6.Display DonationID, BookTitle (obtained from removing all white spaces from
BookTitle), Rating Percentage (obtained from multiplying the BookRating with 20 and
added with ‘%’ at the end), Quantity, and DonatorPhone for each donation with book
rating more than the average rating and DonatorAddress consists of more than 15 characters. 
(alias subquery)*/

SELECT 
	[Donator ID] = bd.DonatorID, 
	[Book Tittle] = REPLACE(bb.BookTittle, ' ', '') , 
	[Book Rating] = CAST(bb.BookRating * 20 AS VARCHAR(50)) + '%' , 
	[Quantity] = bb.BookStock, 
	[Donator Phone] = bd.DonatorPhoneNumber
FROM BLDonator bd
JOIN BLDonationTransaction dt
ON bd.DonatorID = dt.DonatorID
JOIN BLDonationDetail dd
ON dt.DonationTransactionID = dd.DonationTransactionID
JOIN BLBook bb
ON dd.BookID = bb.BookID
WHERE bb.BookRating > (
	SELECT AVG(BookRating)
	FROM BLBook
) AND LEN(bd.DonatorAddress) > 15

/*7.Display BorrowTransactionID, Borrow Date (obtained from BorrowTransactionDate
in ‘mm-dd-yyyy’ format), Return Day (obtained from the day name of the return date),
BookTitle, BookRating (obtained from BookRating followed by ‘ star(s)’), and
BookCategoryName for each borrow transaction which contains book(s) whose rating is
equal to the minimum rating or the maximum rating of all available books while also
have more than 10 stocks. Sort the result based on the BorrowTransactionID in descending
order.
(alias subquery) */

SELECT 
	[Borrow Transaction ID] = bt.BorrowTransactionID,
	[Borrow Date] = CONVERT(VARCHAR, bt.BorrowDate, 110),
	[Return Day] = LEFT(DATENAME(WEEKDAY, bt.ReturnDate), 3),
	[Book Tittle] = bb.BookTittle,
	[Book Rating] = CAST(bb.BookRating AS VARCHAR(50)) + ' star(s)',
	[Book Category Name] = bc.BookCategoryName
FROM BLBorrowTransaction bt
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
JOIN BLBook bb
ON bd.BookID = bb.BookID
JOIN BLBookCategory bc
ON bb.BookCategoryID = bc.BookCategoryID,
(
	SELECT 
		[Min Book Rate] = MIN(BookRating),
		[Max Book Rate] = MAX(BookRating)
	FROM BLBook
) x
WHERE bb.BookStock > 10 AND bb.BookRating IN (x.[Max Book Rate], x.[Min Book Rate])
GROUP BY bt.BorrowTransactionID, bt.BorrowDate, bt.ReturnDate, bb.BookTittle, bb.BookRating, bc.BookCategoryName
ORDER BY bt.BorrowTransactionID DESC

/*8. Display StudentName (obtained from StudentName added with ‘Mr. ’ at the beginning),
StudentEmail (obtained by removing ‘.com’ from StudentEmail), Books Borrowed (obtained
from the total number of books borrowed) for each borrow transaction done by male student
and served by staff whose salary is more than the average staff salary. Then, combine
it with StudentName (obtained from StudentName added with ‘Ms. ’ at the beginning),
StudentEmail (obtained by removing ‘.com’ from StudentEmail), Books Borrowed (obtained
from the total number of books borrowed) for each borrow transaction done by female
student and served by staff whose salary is less than the average staff salary.
(alias subquery)
*/

SELECT
	[Student Name] = 'Mr.' + CAST(st.StudentName AS VARCHAR(100)),
	[Student Email] = REPLACE(st.StudentEmail, '.com', ''),
	[Books Borrowed] = SUM(bd.BorrowQuantity)
FROM BLStudent st 
JOIN BLBorrowTransaction bt 
ON st.StudentID = bt.StudentID
JOIN BLStaff sf
ON bt.StaffID = sf.StaffID
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
WHERE sf.StaffSalary > (
	SELECT [Average Staff Salary] = AVG(StaffSalary)
	FROM BLStaff
) AND st.StudentGender = 'Male'
GROUP BY st.StudentName, st.StudentEmail
UNION
SELECT
	[Student Name] = 'Ms.' + CAST(st.StudentName AS VARCHAR(100)),
	[Student Email] = REPLACE(st.StudentEmail, '.com', ''),
	[Books Borrowed] = SUM(bd.BorrowQuantity)
FROM BLStudent st 
JOIN BLBorrowTransaction bt 
ON st.StudentID = bt.StudentID
JOIN BLStaff sf
ON bt.StaffID = sf.StaffID
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
WHERE sf.StaffSalary > (
	SELECT [Average Staff Salary] = AVG(StaffSalary)
	FROM BLStaff
) AND st.StudentGender = 'Female'
GROUP BY st.StudentName, st.StudentEmail

/*9. Create a view named ‘ViewDonationDetail’ to display DonatorName, Donation
Transaction (obtained from the number of donation transaction), Average Quantity
(obtained from the average donation quantity) for each donation done by donator
whose address ended with ‘ Street’ or ‘ Avenue’ and Donation Transaction more than 1.*/

CREATE VIEW ViewDonationDetail AS
SELECT
	[Donator Name] = bd.DonatorName,
	[Donation Transaction] = COUNT(dt.DonationTransactionID),
	[Average Quantity] = AVG(DonationQuantity)
FROM BLDonator bd
JOIN BLDonationTransaction dt
ON bd.DonatorID = dt.DonatorID
JOIN BLDonationDetail dd
ON dt.DonationTransactionID = dd.DonationTransactionID
WHERE bd.DonatorAddress LIKE '%Street' OR bd.DonatorAddress LIKE '%Avenue'
GROUP BY bd.DonatorName
HAVING COUNT(dt.DonationTransactionID) > 1

DROP VIEW ViewDonationDetail

/*10. Create a view named ‘ViewStudentBorrowingData’ to display StudentName, Borrow
Transaction (obtained from the total number of transaction), and Average Duration
(obtained from the average different days between the borrow date and return date)
for each borrow transaction done by male student whose email contains ‘yahoo’.*/

CREATE VIEW ViewStudentBorrowingData AS
SELECT 
	[Student Name] = bs.StudentName,
	[Borrow Transaction] = COUNT(bt.BorrowTransactionID),
	[Average Duration] = DATEDIFF(DAY, bt.BorrowDate, bt.ReturnDate)
FROM BLStudent bs
JOIN BLBorrowTransaction bt
ON  bs.StudentID = bt.StudentID
JOIN BLBorrowDetail bd
ON bt.BorrowTransactionID = bd.BorrowTransactionID
WHERE bs.StudentGender LIKE 'Male' AND bs.StudentEmail LIKE '%yahoo%'
GROUP BY bs.StudentName, bt.BorrowDate, bt.ReturnDate

DROP VIEW ViewStudentBorrowingData