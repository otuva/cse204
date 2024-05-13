import requests
import json
import csv
import random
import datetime

from src import fields
from src import filler

FILENAME = "unnormalized.csv"
random.seed(
    """
            cse204 is the best lecture ever. :)
            
            “Think lightly of yourself and deeply of the world.”
                - Miyamoto Musashi
    """
)

# existing_rooms = []


def generate_people(total_people):
    URL = f"https://randomuser.me/api/?results={total_people}&exc=login,picture&seed=cse204"

    content = requests.get(URL).content
    return json.loads(content)["results"]


def generate_hotel():
    random_hotel = random.choice(filler.hotels)

    # random_room_number = random.randint(100, 500)
    

    # while random_room_number in existing_rooms:
    #     random_room_number = random.randint(100, 500)
    # existing_rooms.append(random_room_number)

    random_days = random.randint(1, 14)
    start_date = datetime.datetime.fromtimestamp(random.randint(1650326470, 1713484906))
    time_delta = datetime.timedelta(days=random_days)
    end_date = start_date + time_delta
    review_date = datetime.datetime.fromtimestamp(
        random.randint(
            int(start_date.timestamp()), int((end_date + time_delta).timestamp())
        )
    )

    transaction_id = random.randint(10000000, 99999999)

    random_room_type = random.choice(filler.room_types)

    myrandom = random.Random(random_room_type["room_type_name"] + random_hotel["name"])
    random_room_number = myrandom.randint(100, 500)

    reservation_total_cost = float(random_room_type["nightly_rate"]) * random_days

    random_payment_type = random.choice(filler.payment_types)
    random_review = random.choice(filler.reviews)

    payment_amount = reservation_total_cost * random.choice([0, 0.25, 0.50, 0.75, 1])

    return fields.hotel_data(
        random_hotel,
        random_room_number,
        random_room_type,
        random_payment_type,
        random_review,
        transaction_id,
        start_date.strftime("%Y-%m-%d"),
        end_date.strftime("%Y-%m-%d"),
        review_date.strftime("%Y-%m-%d"),
        reservation_total_cost,
        payment_amount,
    )


def insert_into_csv(total_people):
    people = generate_people(total_people)

    with open(FILENAME, "a", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.fieldnames)
        for person in people:
            current_hotel = generate_hotel()
            person_data = fields.person_data(person)
            person_data.update(current_hotel)
            writer.writerow(person_data)


def create_csv_file():
    with open(FILENAME, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.fieldnames)
        writer.writeheader()


def get_from_csv():
    with open(FILENAME, newline="") as csvfile:
        reader = csv.DictReader(csvfile, fieldnames=fields.fieldnames)
        next(reader) # skip header
        people = [row for row in reader]
    return people


# function to call from main.py
def create_unnormalized(total_people):
    create_csv_file()
    insert_into_csv(total_people)
