import sqlite3

from src import fields
from src import unnormalized

DATABASE = "hotel.db"


def create_tables():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

    cursor.execute(fields.database_table_addresses)
    cursor.execute(fields.database_table_guests)
    cursor.execute(fields.database_table_hotels)
    cursor.execute(fields.database_table_room_types)
    cursor.execute(fields.database_table_rooms)
    cursor.execute(fields.database_table_reservations)
    cursor.execute(fields.database_table_payment_types)
    cursor.execute(fields.database_table_payments)
    cursor.execute(fields.database_table_guest_reviews)
    cursor.execute(fields.database_unnormalized_form)

    conn.commit()
    conn.close()


def insert_unnormalized_form(row):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

    columns = ", ".join(fields.fieldnames)
    placeholders = ", ".join("?" * len(fields.fieldnames))

    # print(
    cursor.execute(
        f"""
        INSERT INTO unnormalized_form ({columns})
        VALUES ({placeholders})
        """,
        tuple(row.values()),
    )

    conn.commit()
    conn.close()


def normalize():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

    cursor.execute(fields.database_3nf_addresses)
    cursor.execute(fields.database_3nf_hotel_addresses)
    cursor.execute(fields.database_3nf_guests)
    cursor.execute(fields.database_3nf_hotels)
    cursor.execute(fields.database_3nf_room_types)
    cursor.execute(fields.database_3nf_rooms)
    cursor.execute(fields.database_3nf_reservations)
    cursor.execute(fields.database_3nf_payment_types)
    cursor.execute(fields.database_3nf_payments)
    cursor.execute(fields.database_3nf_guest_reviews)

    conn.commit()
    conn.close()

def create_view():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

    cursor.execute(fields.database_unnormalized_form_view)

    conn.commit()
    conn.close()

def insert_from_csv():
    people = unnormalized.get_from_csv()
    for person in people:
        insert_unnormalized_form(person)
