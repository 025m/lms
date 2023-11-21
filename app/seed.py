import datetime
from src.models import Author, Book, Category, Checkout, Customer, Publisher, Reservation, books_authors, books_categories, books_publishers, db
from src import create_app
from faker import Faker
from random import randint
from sqlalchemy import func
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def restart_sequence():
    conn = psycopg2.connect(os.getenv('PSYCOPG2_CONNECT'))
    conn.set_session(autocommit=True)
    cur = conn.cursor()
    # fetch table id sequences
    cur.execute(
        """
        SELECT c.relname FROM pg_class c WHERE c.relkind = 'S';
        """
    )
    records = cur.fetchall()
    for r in records:
        cur.execute(
            f"""
            ALTER SEQUENCE {r[0]} RESTART WITH 1
            """
        )


def truncate_tables():
    """Delete all rows from database tables"""
    db.session.execute(books_authors.delete())
    db.session.execute(books_categories.delete())
    db.session.execute(books_publishers.delete())
    Checkout.query.delete()
    Reservation.query.delete()
    Publisher.query.delete()
    Author.query.delete()
    Book.query.delete()
    Category.query.delete()
    Customer.query.delete()
    
    db.session.commit()

def main():
    app = create_app()
    app.app_context().push()
    restart_sequence()
    truncate_tables()
    
    fake = Faker()
    # Seed Author
    for _ in range(10):
        author = Author(name=fake.name())
        db.session.add(author)
        db.session.commit()

    # Seed Category
    categories = ['Mystery', 'Romance', 'Science Fiction', 'Fantasy', 'Biography']
    for c in categories:
        category = Category(name=c)
        db.session.add(category)
        db.session.commit()

    # Seed Customer
    for _ in range(15):
        customer = Customer(name=fake.name())
        db.session.add(customer)
        db.session.commit()

    # Seed Publisher
    for _ in range(5):
        publisher = Publisher(name=fake.company())
        db.session.add(publisher)
        db.session.commit()

    # Seed Book
    books = []
    for _ in range(20):
        book = Book(
            isbn=fake.isbn13(),
            title=fake.text(max_nb_chars=50),
            year_published=randint(1900, 2023),
            book_count=randint(1, 100)
        )
        books.append(book)
        db.session.add(book)

    db.session.commit()

    for book in books:
        num_authors = 1 if randint(1, 10) <= 8 else randint(2, 3)
        for _ in range(num_authors):
            author = Author.query.order_by(func.random()).limit(1).first()
            if author not in book.authors:
                book.authors.append(author)

        for _ in range(randint(1, 2)):
            category = Category.query.order_by(func.random()).limit(1).first()
            if category not in book.categories:
                book.categories.append(category)
        for _ in range(randint(1, 2)):
            publisher = Publisher.query.order_by(func.random()).limit(1).first()
            if publisher not in book.publishers:
                book.publishers.append(publisher)

    db.session.commit()

        # Seed Checkout
    for _ in range(30):
        checkout = Checkout(
            checkout_date=datetime.datetime.now() - datetime.timedelta(days=randint(0, 30)),
            return_date=datetime.datetime.now() + datetime.timedelta(days=randint(0, 30)),
            customer_id=randint(1, 15)
        )
        db.session.add(checkout)
        db.session.commit()

    # Seed Reservation
    for _ in range(20):
        reservation = Reservation(
            reservation_date=datetime.datetime.now() + datetime.timedelta(days=randint(0, 30)),
            customer_id=randint(1, 15)
        )
        db.session.add(reservation)
        db.session.commit()

# run script
main()
