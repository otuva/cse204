import requests
import json
import csv

from src import fields

def generate_people(total_people):
    URL = f"https://randomuser.me/api/?results={total_people}&seed=cse204"

    content = requests.get(URL).content
    results = json.loads(content)["results"]

    return results


def insert_csv(people):
    with open("people.csv", "w", newline="") as csvfile:
        fieldnames = fields.fieldnames
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for person in people:
            person_data = fields.person_data(person)
            writer.writerow(person_data)


def create_unnormalized(total_people):
    people = generate_people(total_people)
    insert_csv(people)
