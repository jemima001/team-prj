USE mydb15;

CREATE TABLE Orders(
orderId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
memberId VARCHAR(225),
address VARCHAR(225),
inserted DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (memberId) REFERENCES Member(nickName)

);
DESC Member;

-- Member, Product, Cart JOIN

DESC Address;
DESC Member;

-- NOT NULL을 줘야 하는 대상이 있나?


CREATE TABLE Cart (
cartId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
memberId VARCHAR(50),
productId int,
bookCount int, -- 구매수량

FOREIGN KEY (memberId) REFERENCES Member(id),
FOREIGN KEY (productId) REFERENCES Product(id)
);

ALTER Table Cart add unique (memberId, productId);

SELECT c.ProductId FROM Cart c JOIN Product p ON c.productId = p.id;


DESC Cart;
DROP Table Cart;
DESC Orders;
DROP Table Orders;
