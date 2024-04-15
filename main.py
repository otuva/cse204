import requests
import argparse
import json
import csv

from src import fields

parser = argparse.ArgumentParser(
    description="Process random user data with database options."
)
parser.add_argument(
    "--create-unnormalized",
    type=int,
    choices=[5, 30, 50],
    help="Create an unnormalized table to store the raw JSON data into csv files",
)
parser.add_argument(
    "--create-database",
    action="store_true",
    help="Create normalized database tables to store the data",
)
parser.add_argument(
    "--insert-database",
    action="store_true",
    help="Fetch data and insert into the database",
)
parser.add_argument(
    "--create-view",
    action="store_true",
    help="Create a database view (define the view logic separately)",
)


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


def main():
    args = parser.parse_args()

    if args.create_unnormalized:
        create_unnormalized(args.create_unnormalized)
    elif args.create_database:
        print("create_database")
    elif args.insert_database:
        print("insert_database")
    elif args.create_view:
        print("create_view")
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
