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
    # "cell",
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
        # "cell": person["cell"],
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


# ---------------------------------------------
# ---------------database-tables---------------
# ---------------------------------------------

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

database_table_guests = """
        CREATE TABLE IF NOT EXISTS guests (
            guest_id INTEGER PRIMARY KEY AUTOINCREMENT,  
            gender TEXT,
            title TEXT,
            first_name TEXT,
            last_name TEXT,
            email TEXT,
            phone TEXT,
            address_id INTEGER,
            date_of_birth TEXT,
            id_name TEXT,
            id_value TEXT,
            nationality TEXT,
            FOREIGN KEY (address_id) REFERENCES addresses(address_id)
        );
    """

database_table_hotels = """
        CREATE TABLE IF NOT EXISTS hotels (
            hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotel_name TEXT NOT NULL,
            address_id INTEGER,
            email TEXT,
            phone TEXT,
            website TEXT,
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
            payment_amount DECIMAL(8,2),
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
            reservation_id INTEGER NOT NULL,
            rating INTEGER CHECK (rating >= 1 AND rating <= 5),
            review_title TEXT,
            review_text TEXT,
            review_date DATE NOT NULL,
            FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
            FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
        );
    """

# ------------------------------------
# ------------database-raw------------
# ------------------------------------

database_unnormalized_form = """
        CREATE TABLE IF NOT EXISTS unnormalized_form (
            gender TEXT,
            title TEXT,
            first TEXT,
            last TEXT,
            street_number INTEGER,
            street_name TEXT,
            city TEXT,
            state TEXT,
            country TEXT,
            postcode TEXT,
            latitude REAL,
            longitude REAL,
            timezone_offset TEXT,
            timezone_description TEXT,
            email TEXT,
            dob_date TEXT,
            dob_age INTEGER,
            phone TEXT,
            id_name TEXT,
            id_value TEXT,
            nationality TEXT,
            hotel_name TEXT,
            hotel_street_number INTEGER,
            hotel_street_name TEXT,
            hotel_city TEXT,
            hotel_state TEXT,
            hotel_country TEXT,
            hotel_postcode TEXT,
            hotel_email TEXT,
            hotel_phone TEXT,
            hotel_website TEXT,
            room_number TEXT,
            room_type TEXT,
            room_type_description TEXT,
            room_capacity INTEGER,
            room_nightly_rate REAL,
            reservation_start_date TEXT,
            reservation_end_date TEXT,
            reservation_total_cost REAL,
            payment_date TEXT,
            payment_type TEXT,
            payment_amount REAL,
            transaction_id TEXT,
            payment_notes TEXT,
            rating INTEGER,
            review_title TEXT,
            review_text TEXT,
            review_date TEXT
        );
    """

# ---------------------------------------------------------
# -------------------database-tables-3nf-------------------
# ---------------------------------------------------------

database_3nf_addresses = """
        INSERT INTO addresses (street_number, street_name, city, state, country, postcode, latitude, longitude, timezone_offset, timezone_description)
        SELECT DISTINCT street_number, street_name, city, state, country, postcode, latitude, longitude, timezone_offset, timezone_description
        FROM unnormalized_form
        WHERE street_number IS NOT NULL AND street_name IS NOT NULL;
    """

database_3nf_hotel_addresses = """
        INSERT INTO addresses (street_number, street_name, city, state, country, postcode)
        SELECT DISTINCT hotel_street_number, hotel_street_name, hotel_city, hotel_state, hotel_country, hotel_postcode
        FROM unnormalized_form
        WHERE hotel_street_number IS NOT NULL AND hotel_street_name IS NOT NULL;
    """

# gender, title
database_3nf_guests = """
        INSERT INTO guests (gender, title, first_name, last_name, email, phone, address_id, date_of_birth, id_name, id_value, nationality)
        SELECT DISTINCT gender, title, first, last, email, phone, 
            (SELECT address_id FROM addresses WHERE street_number = unnormalized_form.street_number AND street_name = unnormalized_form.street_name LIMIT 1),
            dob_date, id_name, id_value, nationality
        FROM unnormalized_form
        WHERE email IS NOT NULL;
    """

database_3nf_hotels = """
        INSERT INTO hotels (hotel_name, address_id, email, phone, website)
        SELECT DISTINCT hotel_name, 
            (SELECT address_id FROM addresses WHERE street_number = unnormalized_form.hotel_street_number AND street_name = unnormalized_form.hotel_street_name LIMIT 1),
            hotel_email, hotel_phone, hotel_website
        FROM unnormalized_form
        WHERE hotel_name IS NOT NULL;
    """

database_3nf_room_types = """
        INSERT INTO room_types (room_type_name, description, capacity, nightly_rate)
        SELECT DISTINCT room_type, room_type_description, room_capacity, room_nightly_rate
        FROM unnormalized_form
        WHERE room_type IS NOT NULL;
    """

database_3nf_rooms = """
        INSERT INTO rooms (hotel_id, room_number, room_type_id)
        SELECT DISTINCT 
            (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1), 
            room_number, 
            (SELECT room_type_id FROM room_types WHERE room_type_name = unnormalized_form.room_type LIMIT 1)
        FROM unnormalized_form
        WHERE room_number IS NOT NULL AND hotel_name IS NOT NULL AND room_type IS NOT NULL;
    """

database_3nf_reservations = """
        INSERT INTO reservations (guest_id, hotel_id, room_id, start_date, end_date)
        SELECT DISTINCT 
            (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1), 
            (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1),
            (SELECT room_id FROM rooms WHERE room_number = unnormalized_form.room_number AND hotel_id = (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1) LIMIT 1),
            reservation_start_date, reservation_end_date
        FROM unnormalized_form
        WHERE email IS NOT NULL AND hotel_name IS NOT NULL AND room_number IS NOT NULL;
    """

database_3nf_payment_types = """
        INSERT INTO payment_types (payment_type_name)
        SELECT DISTINCT payment_type
        FROM unnormalized_form
        WHERE payment_type IS NOT NULL;
    """

database_3nf_payments = """
        INSERT INTO payments (reservation_id, payment_date, payment_type_id, payment_amount, transaction_id, notes)
        SELECT DISTINCT 
            (SELECT reservation_id FROM reservations 
                WHERE guest_id = (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1) 
                AND room_id = (SELECT room_id FROM rooms WHERE room_number = unnormalized_form.room_number LIMIT 1) 
                AND start_date = unnormalized_form.reservation_start_date 
                LIMIT 1),
            payment_date, 
            (SELECT payment_type_id FROM payment_types WHERE payment_type_name = unnormalized_form.payment_type LIMIT 1),
            payment_amount,
            transaction_id,
            payment_notes
        FROM unnormalized_form
        WHERE payment_date IS NOT NULL AND payment_type IS NOT NULL AND payment_amount IS NOT NULL;
    """

database_3nf_guest_reviews = """
        INSERT INTO guest_reviews (guest_id, reservation_id, rating, review_title, review_text, review_date)
        SELECT DISTINCT 
            (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1),
            (SELECT reservation_id FROM reservations 
                    WHERE guest_id = (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1) 
                    AND hotel_id = (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1) 
                    AND start_date = unnormalized_form.reservation_start_date 
                    LIMIT 1),
            rating, 
            review_title,
            review_text,
            review_date
        FROM unnormalized_form
        WHERE email IS NOT NULL 
            AND hotel_name IS NOT NULL 
            AND rating IS NOT NULL 
            AND review_title IS NOT NULL 
            AND review_text IS NOT NULL
            AND review_date IS NOT NULL;
    """

# ------------------------------------------------------------------
# ----------------------database-original-view----------------------
# ------------------------------------------------------------------

database_unnormalized_form_view = """
        CREATE VIEW unnormalized_form_view AS
        SELECT
            g.gender AS gender,
            g.title AS title,
            g.first_name AS first,
            g.last_name AS last,
            a.street_number AS street_number,
            a.street_name AS street_name,
            a.city AS city,
            a.state AS state,
            a.country AS country,
            a.postcode AS postcode,
            a.latitude AS latitude,
            a.longitude AS longitude,
            a.timezone_offset AS timezone_offset,
            a.timezone_description AS timezone_description,
            g.email AS email,
            g.date_of_birth AS dob_date,
            (strftime('%Y', 'now') - strftime('%Y', g.date_of_birth)) - (strftime('%m-%d', 'now') < strftime('%m-%d', g.date_of_birth)) AS dob_age,
            g.phone AS phone,
            g.id_name AS id_name,
            g.id_value AS id_value,
            g.nationality AS nationality,
            h.hotel_name AS hotel_name,
            ha.street_number AS hotel_street_number,
            ha.street_name AS hotel_street_name,
            ha.city AS hotel_city,
            ha.state AS hotel_state,
            ha.country AS hotel_country,
            ha.postcode AS hotel_postcode,
            h.email AS hotel_email,
            h.phone AS hotel_phone,
            h.website AS hotel_website,
            r.room_number AS room_number,
            rt.room_type_name AS room_type,
            rt.description AS room_type_description,
            rt.capacity AS room_capacity,
            rt.nightly_rate AS room_nightly_rate,
            res.start_date AS reservation_start_date,
            res.end_date AS reservation_end_date,
            CAST((julianday(res.end_date) - julianday(res.start_date)) * rt.nightly_rate AS INT) AS reservation_total_cost,
            pmt.payment_date AS payment_date,
            ptype.payment_type_name AS payment_type,
            pmt.payment_amount AS payment_amount,
            pmt.transaction_id AS transaction_id,
            pmt.notes AS payment_notes,
            rv.rating AS rating,
            rv.review_title AS review_title,
            rv.review_text AS review_text,
            rv.review_date AS review_date
        FROM
            guests g
            JOIN addresses a ON g.address_id = a.address_id
            JOIN reservations res ON res.guest_id = g.guest_id
            JOIN rooms r ON res.room_id = r.room_id
            JOIN hotels h ON r.hotel_id = h.hotel_id
            JOIN addresses ha ON h.address_id = ha.address_id
            JOIN room_types rt ON r.room_type_id = rt.room_type_id
            JOIN payments pmt ON res.reservation_id = pmt.reservation_id
            JOIN payment_types ptype ON pmt.payment_type_id = ptype.payment_type_id
            JOIN guest_reviews rv ON rv.guest_id = g.guest_id AND rv.hotel_id = h.hotel_id;
    """
