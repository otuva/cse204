person_fieldnames = [
    "gender",
    "title",
    "first",
    "last",
    "street_number",
    "street_name",
    "city",
    "state",
    "country",
    "postcode",
    "latitude",
    "longitude",
    "timezone_offset",
    "timezone_description",
    "email",
    # "uuid",
    # "username",
    # "password",
    # "salt",
    # "md5",
    # "sha1",
    # "sha256",
    "dob_date",
    "dob_age",
    # "registered_date",
    "phone",
    "cell",
    "id_name",
    "id_value",
    # "picture_large",
    # "picture_medium",
    # "picture_thumbnail",
    "nationality",
]

hotel_fieldnames = [
    "hotel_name",
    "hotel_street_number",
    "hotel_street_name",
    "hotel_city",
    "hotel_state",
    "hotel_country",
    "hotel_postcode ",
    "hotel_email",
    "hotel_phone",
    "hotel_website",
    "room_number",
    "room_type",
    "room_type_description",
    "room_capacity",
    "room_nightly_rate",
    "reservation_start_date",
    "reservation_end_date",
    "reservation_total_cost",
    "payment_date",
    "payment_type",
    "payment_amount",
    "transaction_id",
    "payment_notes",
    "rating",
    "review_title",
    "review_text",
    "review_date",
]


fieldnames = person_fieldnames + hotel_fieldnames


def person_data(person):
    return {
        "gender": person["gender"],
        "title": person["name"]["title"],
        "first": person["name"]["first"],
        "last": person["name"]["last"],
        "street_number": person["location"]["street"]["number"],
        "street_name": person["location"]["street"]["name"],
        "city": person["location"]["city"],
        "state": person["location"]["state"],
        "country": person["location"]["country"],
        "postcode": person["location"]["postcode"],
        "latitude": person["location"]["coordinates"]["latitude"],
        "longitude": person["location"]["coordinates"]["longitude"],
        "timezone_offset": person["location"]["timezone"]["offset"],
        "timezone_description": person["location"]["timezone"]["description"],
        "email": person["email"],
        # "uuid": person["login"]["uuid"],
        # "username": person["login"]["username"],
        # "password": person["login"]["password"],
        # "salt": person["login"]["salt"],
        # "md5": person["login"]["md5"],
        # "sha1": person["login"]["sha1"],
        # "sha256": person["login"]["sha256"],
        "dob_date": person["dob"]["date"],
        "dob_age": person["dob"]["age"],
        # "registered_date": person["registered"]["date"],
        "phone": person["phone"],
        "cell": person["cell"],
        "id_name": person["id"]["name"],
        "id_value": person["id"]["value"],
        # "picture_large": person["picture"]["large"],
        # "picture_medium": person["picture"]["medium"],
        # "picture_thumbnail": person["picture"]["thumbnail"],
        "nationality": person["nat"],
    }


def hotel_data(
    hotel,
    room_number,
    room_type,
    payment_type,
    review,
    transaction_id,
    start_date,
    end_date,
    review_date,
    reservation_total_cost,
    payment_amount,
):
    return {
        "hotel_name": hotel["name"],
        "hotel_street_number": hotel["address"]["street_number"],
        "hotel_street_name": hotel["address"]["street_name"],
        "hotel_city": hotel["address"]["city"],
        "hotel_state": hotel["address"]["state"],
        "hotel_country": hotel["address"]["country"],
        "hotel_postcode ": hotel["address"]["postcode"],
        "hotel_email": hotel["email"],
        "hotel_phone": hotel["phone"],
        "hotel_website": hotel["website"],
        "room_number": room_number,
        "room_type": room_type["room_type_name"],
        "room_type_description": room_type["description"],
        "room_capacity": room_type["capacity"],
        "room_nightly_rate": room_type["nightly_rate"],
        "reservation_start_date": start_date,
        "reservation_end_date": end_date,
        "reservation_total_cost": reservation_total_cost,
        "payment_date": start_date,
        "payment_type": payment_type,
        "payment_amount": payment_amount,
        "transaction_id": transaction_id,
        "payment_notes": "",
        "rating": review["rating"],
        "review_title": review["review_title"],
        "review_text": review["review_text"],
        "review_date": review_date,
    }


database_table_addresses = """
        CREATE TABLE IF NOT EXISTS addresses (
            address_id INTEGER PRIMARY KEY AUTOINCREMENT,
            street_number INTEGER,
            street_name TEXT,
            city TEXT,
            state TEXT,
            country TEXT,
            postcode TEXT, 
            latitude TEXT,
            longitude TEXT,
            timezone_offset TEXT,
            timezone_description TEXT
    );
    """

database_table_contacts = """
        CREATE TABLE IF NOT EXISTS contacts (
            contact_id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            phone TEXT,
            cell TEXT,
            website TEXT
        );
    """

database_table_guests = """
        CREATE TABLE IF NOT EXISTS guests (
            guest_id INTEGER PRIMARY KEY AUTOINCREMENT,  
            gender TEXT,
            title TEXT,
            first_name TEXT,
            last_name TEXT,
            date_of_birth TEXT,
            id_name TEXT,
            id_value TEXT,
            nationality TEXT
            address_id INTEGER,
            FOREIGN KEY (address_id) REFERENCES addresses(address_id)
        );
    """

database_table_hotels = """
        CREATE TABLE IF NOT EXISTS hotels (
            hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotel_name TEXT NOT NULL,

            address_id INTEGER,
            FOREIGN KEY (address_id) REFERENCES addresses(address_id)
        );
    """

database_table_room_types = """
        CREATE TABLE IF NOT EXISTS room_types (
            room_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
            room_type_name TEXT NOT NULL,  -- e.g., Standard, Deluxe, Suite
            description TEXT,
            capacity INTEGER,             -- Maximum occupancy
            nightly_rate DECIMAL(8,2)    -- Price per night 
        );
    """

database_table_rooms = """
        CREATE TABLE IF NOT EXISTS rooms (
            room_id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotel_id INTEGER NOT NULL,
            room_number INTEGER NOT NULL,
            room_type_id INTEGER NOT NULL,
            FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
            FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
        );
    """

database_table_reservations = """
        CREATE TABLE IF NOT EXISTS reservations (
            reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
            guest_id INTEGER NOT NULL,
            hotel_id INTEGER NOT NULL,
            room_id INTEGER NOT NULL,
            start_date DATE NOT NULL,
            end_date DATE NOT NULL,
            FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
            FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
            FOREIGN KEY (room_id) REFERENCES rooms(room_id)
        );
    """

database_table_payment_types = """
        CREATE TABLE IF NOT EXISTS payment_types (
            payment_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
            payment_type_name TEXT NOT NULL UNIQUE  -- e.g., Credit Card, Cash, Bank Transfer 
        );
    """

database_table_payments = """
        CREATE TABLE IF NOT EXISTS payments (
            payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            reservation_id INTEGER NOT NULL,
            payment_date DATE NOT NULL,
            payment_type_id INTEGER NOT NULL,
            amount DECIMAL(8,2),
            transaction_id INTEGER,  
            notes TEXT,          
            FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
            FOREIGN KEY (payment_type_id) REFERENCES payment_types(payment_type_id) 
        ); 
    """

database_table_guest_reviews = """
        CREATE TABLE IF NOT EXISTS guest_reviews (
            review_id INTEGER PRIMARY KEY AUTOINCREMENT,
            guest_id INTEGER NOT NULL,
            hotel_id INTEGER NOT NULL,
            rating INTEGER CHECK (rating >= 1 AND rating <= 5),
            review_title TEXT,
            review_text TEXT,
            review_date DATE NOT NULL,
            FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
            FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
        );
    """
