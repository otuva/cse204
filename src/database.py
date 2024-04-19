import sqlite3

from src import fields
from src import unnormalized

DATABASE = "hotel.db"


def create_tables():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

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


def insert_from_csv():
    people = unnormalized.get_from_csv()
    for person in people:
        # insert_guest(person)
        print(person)


# def insert_guest(person):
#     conn = sqlite3.connect(DATABASE)
#     cursor = conn.cursor()

#     cursor.execute(
#         """
#         INSERT INTO guests (gender, title, first_name, last_name, street_number, street_name,
#                            city, state, country, postcode, latitude, longitude, timezone_offset,
#                            timezone_description, email, uuid, username, password, salt, md5,
#                            sha1, sha256, date_of_birth, age, registration_date, phone, cell,
#                            id_name, id_value, picture_large, picture_medium, picture_thumbnail, nationality)
#         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
#     """,
#         (
#             person["gender"],
#             person["name"]["title"],
#             person["name"]["first"],
#             person["name"]["last"],
#             person["location"]["street"]["number"],
#             person["location"]["street"]["name"],
#             person["location"]["city"],
#             person["location"]["state"],
#             person["location"]["country"],
#             person["location"]["postcode"],
#             person["location"]["coordinates"]["latitude"],
#             person["location"]["coordinates"]["longitude"],
#             person["location"]["timezone"]["offset"],
#             person["location"]["timezone"]["description"],
#             person["email"],
#             person["login"]["uuid"],
#             person["login"]["username"],
#             person["login"]["password"],
#             person["login"]["salt"],
#             person["login"]["md5"],
#             person["login"]["sha1"],
#             person["login"]["sha256"],
#             person["dob"]["date"],
#             person["dob"]["age"],
#             person["registered"]["date"],
#             person["phone"],
#             person["cell"],
#             person["id"]["name"],
#             person["id"]["value"],
#             person["picture"]["large"],
#             person["picture"]["medium"],
#             person["picture"]["thumbnail"],
#             person["nat"],
#         ),
#     )

#     conn.commit()
#     conn.close()
