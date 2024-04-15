import requests
import json
import csv

from src import fields


def generate_people(total_people):
    URL = f"https://randomuser.me/api/?results={total_people}&seed=cse204"

    content = requests.get(URL).content
    results = json.loads(content)["results"]

    return results


def insert_into_csv(people):
    with open("people.csv", "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields.fieldnames)
        writer.writeheader()
        for person in people:
            person_data = fields.person_data(person)
            writer.writerow(person_data)


def get_from_csv():
    with open("people.csv", newline="") as csvfile:
        reader = csv.DictReader(csvfile, fieldnames=fields.fieldnames)
        people = [row for row in reader]
    return people


def create_unnormalized(total_people):
    people = generate_people(total_people)
    insert_into_csv(people)
