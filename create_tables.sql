CREATE TABLE realestateagency (
	agencyID 		VARCHAR(20),
	name 			VARCHAR(20),
	PRIMARY KEY (agencyID));

CREATE TABLE agent_employed (
	agentID 		VARCHAR(20),
	name 			VARCHAR(20),
	licenseNo 		VARCHAR(20), 
	phoneNo 		VARCHAR(10),
	rating			REAL,
	agencyID 		VARCHAR(20) NOT NULL,
	since 			DATE,
	PRIMARY KEY (agentID),
	FOREIGN KEY(agencyID) REFERENCES realestateagency
		ON DELETE NO ACTION);

/*  Merge Agent and employs since =1 relationship*/
	
CREATE TABLE seller (
	sellerID 		VARCHAR(20),
	sAge			INTEGER,
	sGender			VARCHAR(6),
	sHHsize			INTEGER,
	PRIMARY KEY (sellerID, sAge));

/* include sAge since seller’s age and household can change over time */

CREATE TABLE buyer (
	buyerID			VARCHAR(20),
	bGender			VARCHAR(6),
	bAge			INTEGER,
	grossIncome		INTEGER,
	bHHsize			INTEGER,
	PRIMARY KEY (buyerID, bAge));

/* include bAge since buyer’s age, household, and income can change over time */

CREATE TABLE property (
	propertyID		VARCHAR(20),
	address			VARCHAR(50),
	yearBuilt		INTEGER,
	type 			VARCHAR(9),
	size 			INTEGER,
	baNo			INTEGER,
	brNo			INTEGER,	
	PRIMARY KEY (propertyID));

CREATE TABLE buy (
	buyerID			VARCHAR(20),
	bAge			INTEGER,
	propertyID		VARCHAR(20),
	dealDate 		DATE,
	dealPrice		INTEGER,
	PRIMARY KEY (buyerID, bAge, dealDate, propertyID),
	FOREIGN KEY (buyerID, bAge) REFERENCES buyer,
	FOREIGN KEY (propertyID) REFERENCES property);
	
/* include bAge since buyer’s age can change over time */

CREATE TABLE sell (
	sellerID		VARCHAR(20),
	sAge			INTEGER,
	propertyID		VARCHAR(20),
	listDate		DATE,
	askPrice		INTEGER,
	PRIMARY KEY (sellerID, sAge, listDate, propertyID),
	FOREIGN KEY (sellerID, sAge) REFERENCES seller,
	FOREIGN KEY (propertyID) REFERENCES property);


CREATE TABLE sell_hire (
	sellerID 		VARCHAR(20),
	sAge			INTEGER,
	listDate 		DATE,
	propertyID 		VARCHAR(20),

	agentID 		VARCHAR(20) NOT NULL,

	sCommision		REAL,
	sStartDate 		DATE,
	sEndDate 		DATE,

	PRIMARY KEY (sellerID, sAge, listDate, propertyID),
	FOREIGN KEY (sellerID, sAge, listDate, propertyID) REFERENCES sell,
	FOREIGN KEY (agentID) REFERENCES agent_employed);


CREATE TABLE buy_hire (
	buyerID 		VARCHAR(20),
	bAge 			INTEGER,
	dealDate 		DATE,
	propertyID 		VARCHAR(20),

	agentID 		VARCHAR(20) NOT NULL,
	
	bCommision 		REAL,
	bStartDate 		DATE,
	bEndDate 		DATE,
	
	PRIMARY KEY (buyerID, bAge, dealDate, propertyID),
	FOREIGN KEY (buyerID, bAge, dealDate, propertyID) REFERENCES buy,
	FOREIGN KEY (agentID) REFERENCES agent_employed);

CREATE TABLE lender (
	lenderID 		VARCHAR(20),
	lenderName 		VARCHAR(50),
	PRIMARY KEY (lenderID));

CREATE TABLE borrows (
	buyerID 		VARCHAR(20),
	bAge 			INTEGER,
	dealDate 		DATE,
	propertyID 		VARCHAR(20),

	lenderID		VARCHAR(20) NOT NULL,

	mortgageID 		VARCHAR(20),
	term 			INTEGER,
	amount 			REAL,
	interestRate 	REAL,

	PRIMARY KEY (buyerID, bAge, dealDate, propertyID),
	FOREIGN KEY (buyerID, bAge, dealDate, propertyID) REFERENCES buy,
	FOREIGN KEY (lenderID) REFERENCES ender);