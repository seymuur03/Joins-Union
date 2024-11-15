CREATE DATABASE JoinsUnion
USE JoinsUnion
--Yaddan cixib Aze dilinde qalib Tables ve Meals Id sinin ilk herfi Aze elifbasi ile getdi

CREATE TABLE Meals
(
İd int primary key identity,
[Name] nvarchar(30) Not Null,
Price decimal(14,2) Not Null
)

CREATE TABLE [Tables]
(
İd int primary key identity,
Number int Unique 
)

CREATE TABLE Orders
(
İd int primary key identity,
MealId int foreign key references Meals(İd),
TableId int foreign key references [Tables](İd),
OrderDate datetime Not Null 
)

INSERT INTO Meals VALUES 
('Yarpaq Dolmasi',6.30),
('3 Baci',5.45),
('Kabab',11.70),
('Bozbash',7.87)
SELECT * FROM Meals

INSERT INTO [Tables] VALUES
(10),
(11),
(12),
(13)
SELECT * FROM [Tables]

INSERT INTO Orders VALUES 
(1,1,'2024.11.15 15:54:12'),
(2,1,'2024.11.15 15:55:15'),
(4,1,'2024.11.15 15:56:42'),
(2,2,'2024.11.15 17:27:30'),
(3,2,'2024.11.15 17:29:30'),
(3,3,'2024.11.15 19:45:10'),
(4,4,'2024.11.15 21:15:30'),
(1,4,'2024.11.15 21:27:30')
SELECT * FROM Orders

INSERT INTO Orders VALUES 
(2,1,'2024.11.15 21:54:12')


--1.Query

SELECT t.*,COUNT (o.İd) AS 'CountOfOrdersToTable' FROM [Tables] t
LEFT JOIN
Orders o
ON 
o.TableId=t.İd
GROUP BY t.İd,t.Number


--2.Query

SELECT m.*, COUNT(o.MealId) AS 'OrdersCount' FROM Meals m
JOIN 
Orders o
ON 
o.MealId = m.İd
GROUP BY m.İd,m.Name,m.Price


--3.Query

SELECT o.*, m.[Name] AS 'MealName' FROM Orders o
JOIN 
Meals m
ON
m.İd = o.MealId


--4.Query

SELECT o.*,m.[Name] AS 'MealName', t.Number AS 'TableNumber' FROM Orders o
JOIN
Meals m
ON
m.İd = o.MealId
JOIN 
[Tables] t
ON 
o.TableId = t.İd


--5.Query

SELECT t.*,SUM(m.Price) AS 'TotalSum' FROM [Tables] t
JOIN 
Orders o
ON
o.TableId=t.İd
JOIN 
Meals m
ON 
m.İd = o.MealId
GROUP BY t.İd,t.Number

INSERT INTO [Tables] VALUES 
(20)

SELECT t.*,COALESCE(SUM(m.Price),0) AS 'TotalSum' FROM [Tables] t
LEFT JOIN 
Orders o
ON
o.TableId=t.İd
LEFT JOIN 
Meals m
ON 
m.İd = o.MealId
GROUP BY t.İd,t.Number

--COALESCE'siz yazanda left joinin istifadesi zamani 5 ci tableda sifaris olmadigindan NULL yazisi gelir,Coalesce sayesinde biz o null'i 0 ile evez edirik 


--6.Query
SELECT DATEDIFF(HOUR,MIN(OrderDate),MAX(OrderDate)) AS 'Difference' FROM [Tables] t
JOIN 
Orders o
ON 
t.İd=o.TableId
WHERE t.İd=1


--8.Query

SELECT * FROM [Tables] t
LEFT JOIN 
Orders o
ON 
t.İd=o.TableId
WHERE o.İd is null



