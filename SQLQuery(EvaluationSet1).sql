CREATE Database Evaluation

USE Evaluation

CREATE TABLE Items(
	ItemID INT PRIMARY KEY,
	Item VARCHAR(25)
)

CREATE TABLE Shops(
	ShopID INT PRIMARY KEY,
	Shop VARCHAR(25)
)


CREATE TABLE Units(
	UnitID INT PRIMARY KEY,
	Unit VARCHAR(25)
)

ALTER TABLE Units ADD UnitCnt INT
UPDATE Units SET UnitCnt=1 WHERE UnitID=1
UPDATE Units SET UnitCnt=28 WHERE UnitID=2

CREATE TABLE Sales(
	SalesID INT PRIMARY KEY IDENTITY,
	ItemID INT,
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
	ShopID INT,
	FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
	Quantity INT,
	UnitID INT,
	FOREIGN KEY (UnitID) REFERENCES Units(UnitID),
	UnitPrice DECIMAL (7,2),
	SaleDate Date
)


INSERT INTO Items VALUES (1,'Bar_One')
INSERT INTO Items VALUES (2,'Kitkat')
INSERT INTO Items VALUES (3,'MilkyBar')
INSERT INTO Items VALUES (4,'Munch')

INSERT INTO Shops VALUES (1,'Amal Stores')
INSERT INTO Shops VALUES (2,'Jyothi Stores')
INSERT INTO Shops VALUES (3,'Indira Stores')

INSERT INTO Units VALUES (1,'Piece')
INSERT INTO Units VALUES (2,'Box Pack')

INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (1,1,100,1,10,'05-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (2,1,200,1,15,'05-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (3,1,50,1,5,'05-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (4,1,150,1,10,'05-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (1,2,10,2,280,'10-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (2,2,30,2,420,'10-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (3,2,40,2,140,'10-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (4,2,20,2,280,'10-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (1,3,50,2,280,'15-SEP-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (2,3,70,2,420,'15-SEP-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (3,3,30,2,140,'10-OCT-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (1,1,150,1,10,'15-SEP-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (2,1,250,1,15,'15-SEP-2018')
INSERT INTO Sales(ItemID,ShopID,Quantity,UnitID,UnitPrice,SaleDate) VALUES (4,1,200,1,10,'10-OCT-2018')

SELECT * FROM Items
SELECT * FROM Shops
SELECT * FROM Units
SELECT * FROM Sales


--1.2

ALTER TABLE Sales ADD TotalCost INT
UPDATE Sales SET TotalCost=UnitPrice*Quantity WHERE UnitID=1
UPDATE Sales SET TotalCost=UnitPrice*Quantity*28 WHERE UnitID=2

SELECT
	TOP 1
    I.Item,
    SUM(S.TotalCost) AS Revenue
FROM
    Sales S
    JOIN Items I ON S.ItemID = I.ItemID
WHERE
    MONTH(S.SaleDate) = 10
GROUP BY
    I.Item 
ORDER BY
    Revenue DESC

--1.3

SELECT
	TOP 1
    I.Item,
    SUM(S.Quantity*U.UnitCnt) AS TotalQuantity
FROM
    Sales S
	JOIN Units U ON U.UnitID = S.UnitID
    JOIN Items I ON S.ItemID = I.ItemID
    JOIN Shops SH ON S.ShopID = SH.ShopID
WHERE
    MONTH(S.SaleDate) = 10
    AND SH.Shop = 'Amal Stores'
GROUP BY
    I.Item
ORDER BY
    TotalQuantity DESC

--1.4

SELECT
    I.Item,
    SUM(S.TotalCost) AS Revenue
FROM
    Sales S
    JOIN Items I ON S.ItemID = I.ItemID
WHERE
    MONTH(S.SaleDate) = 10
GROUP BY
    I.Item
HAVING
    SUM(S.TotalCost) > 10000
ORDER BY
    Revenue DESC


--1.5

SELECT
	TOP 1
    SH.Shop,
    SUM(S.TotalCost) AS Revenue
FROM
    Sales S
    JOIN Shops SH ON S.ShopID = SH.ShopID
WHERE
    MONTH(S.SaleDate) = 10
GROUP BY
    SH.Shop
ORDER BY
    Revenue DESC