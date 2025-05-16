
-- SETUP FILE: Integrated Financial Portfolio Management System (FMPS)
-- Extended with S&P 500-style Instrument Coverage
-- Date: 2025-05-03

CREATE DATABASE IF NOT EXISTS FMPS;
USE FMPS;

CREATE TABLE IF NOT EXISTS USER (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    DateRegistered DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS FINANCIAL_INSTRUMENT (
    InstrumentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50),
    TickerSymbol VARCHAR(10) NOT NULL,
    Sector VARCHAR(50),
    CurrentMarketPrice DECIMAL(19, 4)
);

CREATE TABLE IF NOT EXISTS MARKET_DATA (
    DataID INT AUTO_INCREMENT PRIMARY KEY,
    InstrumentID INT NOT NULL,
    Date DATE NOT NULL,
    OpenPrice DECIMAL(19, 4) NOT NULL,
    ClosePrice DECIMAL(19, 4) NOT NULL,
    High DECIMAL(19, 4) NOT NULL,
    Low DECIMAL(19, 4) NOT NULL,
    Volume BIGINT NOT NULL,
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

CREATE TABLE IF NOT EXISTS USER_INVESTMENT (
    InvestmentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    InstrumentID INT NOT NULL,
    Quantity DECIMAL(19, 4) NOT NULL,
    PurchaseDate DATE NOT NULL,
    PurchasePrice DECIMAL(19, 4) NOT NULL,
    InvestmentType VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (UserID) REFERENCES USER(UserID),
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

CREATE TABLE IF NOT EXISTS REPORT (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    DateGenerated DATE NOT NULL,
    ReportType VARCHAR(255),
    Content TEXT,
    FOREIGN KEY (UserID) REFERENCES USER(UserID)
);

CREATE TABLE IF NOT EXISTS WATCHLIST (
    WatchlistID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    InstrumentID INT NOT NULL,
    DateAdded DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES USER(UserID),
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

CREATE TABLE IF NOT EXISTS ALERTS (
    AlertID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    InstrumentID INT NOT NULL,
    AlertType VARCHAR(50),
    ThresholdValue DECIMAL(19, 4),
    Triggered BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UserID) REFERENCES USER(UserID),
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

-- Insert Users
INSERT INTO USER (Username, Password, Email, DateRegistered) VALUES
('trader_john', 'pass123', 'trader_john@hedgefund.com', CURDATE()),
('analyst_sam', 'pass456', 'analyst_sam@hedgefund.com', CURDATE()),
('trader_emily', 'pass789', 'trader_emily@hedgefund.com', CURDATE()),
('investor_ray', 'raysecure', 'ray@investsmart.com', CURDATE()),
('admin_kate', 'kateadmin', 'kate@systemadmin.com', CURDATE());

-- Insert 100+ Instruments (S&P 500-style)
INSERT INTO FINANCIAL_INSTRUMENT (Name, Type, TickerSymbol, Sector, CurrentMarketPrice) VALUES
('Company_1', 'Stock', 'C001', 'Consumer Discretionary', 0.0)
('Company_2', 'Stock', 'C002', 'Consumer Discretionary', 0.0)
('Company_3', 'Stock', 'C003', 'Communication Services', 0.0)
('Company_4', 'Stock', 'C004', 'Healthcare', 0.0)
('Company_5', 'Stock', 'C005', 'Energy', 0.0)
('Company_6', 'Stock', 'C006', 'Consumer Staples', 0.0)
('Company_7', 'Stock', 'C007', 'Consumer Discretionary', 0.0)
('Company_8', 'Stock', 'C008', 'Technology', 0.0)
('Company_9', 'Stock', 'C009', 'Real Estate', 0.0)
('Company_10', 'Stock', 'C010', 'Consumer Discretionary', 0.0)
('Company_11', 'Stock', 'C011', 'Consumer Staples', 0.0)
('Company_12', 'Stock', 'C012', 'Materials', 0.0)
('Company_13', 'Stock', 'C013', 'Industrials', 0.0)
('Company_14', 'Stock', 'C014', 'Technology', 0.0)
('Company_15', 'Stock', 'C015', 'Real Estate', 0.0)
('Company_16', 'Stock', 'C016', 'Consumer Discretionary', 0.0)
('Company_17', 'Stock', 'C017', 'Communication Services', 0.0)
('Company_18', 'Stock', 'C018', 'Utilities', 0.0)
('Company_19', 'Stock', 'C019', 'Industrials', 0.0)
('Company_20', 'Stock', 'C020', 'Utilities', 0.0)
('Company_21', 'Stock', 'C021', 'Energy', 0.0)
('Company_22', 'Stock', 'C022', 'Healthcare', 0.0)
('Company_23', 'Stock', 'C023', 'Technology', 0.0)
('Company_24', 'Stock', 'C024', 'Healthcare', 0.0)
('Company_25', 'Stock', 'C025', 'Industrials', 0.0)
('Company_26', 'Stock', 'C026', 'Real Estate', 0.0)
('Company_27', 'Stock', 'C027', 'Consumer Staples', 0.0)
('Company_28', 'Stock', 'C028', 'Communication Services', 0.0)
('Company_29', 'Stock', 'C029', 'Industrials', 0.0)
('Company_30', 'Stock', 'C030', 'Consumer Staples', 0.0)
('Company_31', 'Stock', 'C031', 'Healthcare', 0.0)
('Company_32', 'Stock', 'C032', 'Real Estate', 0.0)
('Company_33', 'Stock', 'C033', 'Materials', 0.0)
('Company_34', 'Stock', 'C034', 'Materials', 0.0)
('Company_35', 'Stock', 'C035', 'Energy', 0.0)
('Company_36', 'Stock', 'C036', 'Industrials', 0.0)
('Company_37', 'Stock', 'C037', 'Financials', 0.0)
('Company_38', 'Stock', 'C038', 'Communication Services', 0.0)
('Company_39', 'Stock', 'C039', 'Healthcare', 0.0)
('Company_40', 'Stock', 'C040', 'Communication Services', 0.0)
('Company_41', 'Stock', 'C041', 'Technology', 0.0)
('Company_42', 'Stock', 'C042', 'Materials', 0.0)
('Company_43', 'Stock', 'C043', 'Financials', 0.0)
('Company_44', 'Stock', 'C044', 'Consumer Discretionary', 0.0)
('Company_45', 'Stock', 'C045', 'Energy', 0.0)
('Company_46', 'Stock', 'C046', 'Materials', 0.0)
('Company_47', 'Stock', 'C047', 'Real Estate', 0.0)
('Company_48', 'Stock', 'C048', 'Materials', 0.0)
('Company_49', 'Stock', 'C049', 'Financials', 0.0)
('Company_50', 'Stock', 'C050', 'Real Estate', 0.0)
('Company_51', 'Stock', 'C051', 'Consumer Discretionary', 0.0)
('Company_52', 'Stock', 'C052', 'Financials', 0.0)
('Company_53', 'Stock', 'C053', 'Energy', 0.0)
('Company_54', 'Stock', 'C054', 'Healthcare', 0.0)
('Company_55', 'Stock', 'C055', 'Consumer Staples', 0.0)
('Company_56', 'Stock', 'C056', 'Healthcare', 0.0)
('Company_57', 'Stock', 'C057', 'Financials', 0.0)
('Company_58', 'Stock', 'C058', 'Materials', 0.0)
('Company_59', 'Stock', 'C059', 'Consumer Discretionary', 0.0)
('Company_60', 'Stock', 'C060', 'Technology', 0.0)
('Company_61', 'Stock', 'C061', 'Technology', 0.0)
('Company_62', 'Stock', 'C062', 'Energy', 0.0)
('Company_63', 'Stock', 'C063', 'Financials', 0.0)
('Company_64', 'Stock', 'C064', 'Healthcare', 0.0)
('Company_65', 'Stock', 'C065', 'Energy', 0.0)
('Company_66', 'Stock', 'C066', 'Healthcare', 0.0)
('Company_67', 'Stock', 'C067', 'Real Estate', 0.0)
('Company_68', 'Stock', 'C068', 'Consumer Staples', 0.0)
('Company_69', 'Stock', 'C069', 'Real Estate', 0.0)
('Company_70', 'Stock', 'C070', 'Financials', 0.0)
('Company_71', 'Stock', 'C071', 'Consumer Discretionary', 0.0)
('Company_72', 'Stock', 'C072', 'Energy', 0.0)
('Company_73', 'Stock', 'C073', 'Industrials', 0.0)
('Company_74', 'Stock', 'C074', 'Consumer Discretionary', 0.0)
('Company_75', 'Stock', 'C075', 'Consumer Staples', 0.0)
('Company_76', 'Stock', 'C076', 'Consumer Staples', 0.0)
('Company_77', 'Stock', 'C077', 'Materials', 0.0)
('Company_78', 'Stock', 'C078', 'Communication Services', 0.0)
('Company_79', 'Stock', 'C079', 'Communication Services', 0.0)
('Company_80', 'Stock', 'C080', 'Materials', 0.0)
('Company_81', 'Stock', 'C081', 'Industrials', 0.0)
('Company_82', 'Stock', 'C082', 'Real Estate', 0.0)
('Company_83', 'Stock', 'C083', 'Consumer Discretionary', 0.0)
('Company_84', 'Stock', 'C084', 'Healthcare', 0.0)
('Company_85', 'Stock', 'C085', 'Technology', 0.0)
('Company_86', 'Stock', 'C086', 'Energy', 0.0)
('Company_87', 'Stock', 'C087', 'Real Estate', 0.0)
('Company_88', 'Stock', 'C088', 'Healthcare', 0.0)
('Company_89', 'Stock', 'C089', 'Utilities', 0.0)
('Company_90', 'Stock', 'C090', 'Financials', 0.0)
('Company_91', 'Stock', 'C091', 'Industrials', 0.0)
('Company_92', 'Stock', 'C092', 'Technology', 0.0)
('Company_93', 'Stock', 'C093', 'Materials', 0.0)
('Company_94', 'Stock', 'C094', 'Consumer Staples', 0.0)
('Company_95', 'Stock', 'C095', 'Financials', 0.0)
('Company_96', 'Stock', 'C096', 'Energy', 0.0)
('Company_97', 'Stock', 'C097', 'Technology', 0.0)
('Company_98', 'Stock', 'C098', 'Financials', 0.0)
('Company_99', 'Stock', 'C099', 'Industrials', 0.0)
('Company_100', 'Stock', 'C100', 'Industrials', 0.0);


-- Insert Sample Investments
INSERT INTO USER_INVESTMENT (UserID, InstrumentID, Quantity, PurchaseDate, PurchasePrice, InvestmentType, Notes) VALUES
(1, 1, 100.00, '2024-01-01', 150.00, 'Equity', 'Tech exposure'),
(2, 2, 50.00, '2024-01-10', 200.00, 'Equity', 'Long-term growth'),
(3, 3, 75.00, '2024-01-20', 175.00, 'Equity', 'Retail bet'),
(4, 4, 120.00, '2024-01-25', 180.00, 'Equity', 'Momentum strategy');


-- Insert Sample Watchlist Items
INSERT INTO WATCHLIST (UserID, InstrumentID, DateAdded) VALUES
(1, 1, CURDATE()),
(2, 2, CURDATE()),
(3, 3, CURDATE()),
(4, 4, CURDATE()),
(5, 5, CURDATE());


-- Insert Sample Alerts
INSERT INTO ALERTS (UserID, InstrumentID, AlertType, ThresholdValue, Triggered) VALUES
(1, 1, 'Price Above', 200.00, FALSE),
(2, 2, 'Price Below', 150.00, FALSE),
(3, 3, 'Price Above', 300.00, FALSE);


-- Insert Sample Reports
INSERT INTO REPORT (UserID, DateGenerated, ReportType, Content) VALUES
(1, CURDATE(), 'Monthly Summary', 'Your portfolio increased by 5% this month.'),
(2, CURDATE(), 'Volatility Report', 'NVIDIA showed the highest volatility.'),
(3, CURDATE(), 'Watchlist Alert Summary', '2 alerts triggered this week.');
