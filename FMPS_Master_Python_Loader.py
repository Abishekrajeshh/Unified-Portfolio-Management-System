
import pandas as pd
import mysql.connector
from mysql.connector import Error
import datetime

# MySQL connection settings
host_name = '127.0.0.1'
db_name = 'FMPS'
user_name = 'root'
user_password = 'your_password_here'  # 🔒 Replace with your actual password
csv_file_path = 'simulated_market_data.csv'

def get_instrument_id(cursor, ticker_symbol):
    cursor.execute("SELECT InstrumentID FROM FINANCIAL_INSTRUMENT WHERE TickerSymbol = %s", (ticker_symbol,))
    result = cursor.fetchone()
    return result[0] if result else None

def setup_database():
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            password=user_password
        )
        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute("CREATE DATABASE IF NOT EXISTS FMPS")
            connection.commit()
            print("Database FMPS created or already exists.")
    except Error as e:
        print(f"DB Creation Error: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def insert_sample_data(connection):
    cursor = connection.cursor()

    user_insert = '''
    INSERT IGNORE INTO USER (Username, Password, Email, DateRegistered) VALUES
    ('trader_john', 'pass123', 'trader_john@hedgefund.com', CURDATE()),
    ('analyst_sam', 'pass456', 'analyst_sam@hedgefund.com', CURDATE()),
    ('trader_emily', 'pass789', 'trader_emily@hedgefund.com', CURDATE());
    '''
    cursor.execute(user_insert)

    instrument_insert = '''
    INSERT IGNORE INTO FINANCIAL_INSTRUMENT (Name, Type, TickerSymbol, Sector, CurrentMarketPrice) VALUES
    ('Apple', 'Stock', 'AAPL', 'Technology', 0.00),
    ('Microsoft', 'Stock', 'MSFT', 'Technology', 0.00),
    ('Amazon', 'Stock', 'AMZN', 'Consumer Discretionary', 0.00),
    ('Nvidia', 'Stock', 'NVDA', 'Technology', 0.00);
    '''
    cursor.execute(instrument_insert)

    watchlist = '''
    INSERT IGNORE INTO WATCHLIST (UserID, InstrumentID, DateAdded) VALUES
    (1, 1, CURDATE()), (2, 2, CURDATE()), (3, 3, CURDATE());
    '''
    cursor.execute(watchlist)

    alerts = '''
    INSERT IGNORE INTO ALERTS (UserID, InstrumentID, AlertType, ThresholdValue, Triggered) VALUES
    (1, 1, 'Price Above', 150.00, FALSE),
    (2, 2, 'Price Below', 250.00, FALSE);
    '''
    cursor.execute(alerts)

    reports = '''
    INSERT IGNORE INTO REPORT (UserID, DateGenerated, ReportType, Content) VALUES
    (1, CURDATE(), 'Monthly Summary', 'Your portfolio grew by 4.5%'),
    (2, CURDATE(), 'Alert Summary', 'One alert was triggered today');
    '''
    cursor.execute(reports)

    connection.commit()
    print("Sample data inserted.")

def insert_market_data_from_csv(connection, df):
    cursor = connection.cursor()
    grouped = df.groupby('ticker_symbol')
    for ticker, group in grouped:
        instrument_id = get_instrument_id(cursor, ticker)
        if not instrument_id:
            continue
        for _, row in group.iterrows():
            insert_query = '''
                INSERT INTO MARKET_DATA (InstrumentID, Date, OpenPrice, ClosePrice, High, Low, Volume)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            '''
            cursor.execute(insert_query, (
                instrument_id,
                row['date'],
                float(row['open_price']),
                float(row['close_price']),
                float(row['high']),
                float(row['low']),
                int(row['volume'])
            ))
        latest_close = group.iloc[-1]['close_price']
        cursor.execute("UPDATE FINANCIAL_INSTRUMENT SET CurrentMarketPrice = %s WHERE InstrumentID = %s",
                       (float(latest_close), instrument_id))
    connection.commit()
    print("Market data inserted and updated.")

def main():
    setup_database()

    try:
        connection = mysql.connector.connect(
            host=host_name,
            database=db_name,
            user=user_name,
            password=user_password
        )
        if connection.is_connected():
            print("Connected to FMPS database.")
            insert_sample_data(connection)
            df = pd.read_csv(csv_file_path)
            insert_market_data_from_csv(connection, df)

    except Error as e:
        print(f"Error: {e}")
    finally:
        if connection.is_connected():
            connection.close()
            print("MySQL connection closed.")

if __name__ == '__main__':
    main()
