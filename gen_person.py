# import sys


# def generate_users(total_people):
#     URL = f"https://randomuser.me/api/?results={total_people}&seed=cse204"

#     content = requests.get(URL).content
#     results = json.loads(content)['results']


import requests
import argparse
import json
import csv

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
        fieldnames = [
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
            "uuid",
            "username",
            "password",
            "salt",
            "md5",
            "sha1",
            "sha256",
            "dob_date",
            "dob_age",
            "registered_date",
            "phone",
            "cell",
            "id_name",
            "id_value",
            "picture_large",
            "picture_medium",
            "picture_thumbnail",
            "nat",
        ]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for person in people:
            person_data = {
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
                "uuid": person["login"]["uuid"],
                "username": person["login"]["username"],
                "password": person["login"]["password"],
                "salt": person["login"]["salt"],
                "md5": person["login"]["md5"],
                "sha1": person["login"]["sha1"],
                "sha256": person["login"]["sha256"],
                "dob_date": person["dob"]["date"],
                "dob_age": person["dob"]["age"],
                "registered_date": person["registered"]["date"],
                "phone": person["phone"],
                "cell": person["cell"],
                "id_name": person["id"]["name"],
                "id_value": person["id"]["value"],
                "picture_large": person["picture"]["large"],
                "picture_medium": person["picture"]["medium"],
                "picture_thumbnail": person["picture"]["thumbnail"],
                "nat": person["nat"],
            }
            writer.writerow(person_data)


def create_unnormalized(total_people):
    people = generate_people(total_people)
    insert_csv(people)
    # print(people)


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
