import argparse

from src import unnormalized
from src import database

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


def main():
    args = parser.parse_args()

    if args.create_unnormalized:
        unnormalized.create_unnormalized(args.create_unnormalized)
    elif args.create_database:
        database.create_tables()
    elif args.insert_database:
        unnormalized.get_from_csv()
    elif args.create_view:
        print("create_view")
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
