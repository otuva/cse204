import requests
import json
import csv
import random

from src import fields
from src import filler

FILENAME = "unnormalized.csv"
random.seed("cse204 is the best lecture ever")

existing_rooms = []

def generate_people(total_people):
    URL = f"https://randomuser.me/api/?results={total_people}&seed=cse204"

    content = requests.get(URL).content
    return json.loads(content)["results"]


def generate_hotel():
    random_hotel = random.choice(filler.hotels)

    random_room_number = random.randint(100,500)
    while random_room_number in existing_rooms:
        random_room_number = random.randint(100,500)
    existing_rooms.append(random_room_number)

    random_room_type = random.choice(filler.room_types)
    random_payment_type = random.choice(filler.payment_types)
    random_review = random.choice(filler.reviews)

    return fields.hotel_data(
        random_hotel, random_room_number, random_room_type, random_payment_type, random_review
    )


def insert_into_csv(total_people):
    people = generate_people(total_people)

    with open(FILENAME, "a", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.fieldnames)
        for person in people:
            person_data = fields.person_data(person)
            person_data.update(generate_hotel())
            writer.writerow(person_data)


def create_csv_file():
    with open(FILENAME, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.fieldnames)
        writer.writeheader()


def get_from_csv():
    with open(FILENAME, newline="") as csvfile:
        reader = csv.DictReader(csvfile, fieldnames=fields.fieldnames)
        people = [row for row in reader]
    return people


# function to call from main.py
def create_unnormalized(total_people):
    create_csv_file()
    insert_into_csv(total_people)
