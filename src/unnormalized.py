import requests
import json
import csv

from src import fields

FILENAME = "unnormalized.csv"


def insert_people_into_csv(total_people):
    URL = f"https://randomuser.me/api/?results={total_people}&seed=cse204"

    content = requests.get(URL).content
    people = json.loads(content)["results"]

    with open(FILENAME, "a", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.person_fieldnames)
        for person in people:
            person_data = fields.person_data(person)
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
    insert_people_into_csv(total_people)
