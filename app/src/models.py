from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

books_authors = db.Table('books_authors',
    db.Column('book_id', db.Integer, db.ForeignKey('books.id'), primary_key=True),
    db.Column('author_id', db.Integer, db.ForeignKey('authors.id'), primary_key=True)
)

books_categories = db.Table('books_categories',
    db.Column('book_id', db.Integer, db.ForeignKey('books.id'), primary_key=True),
    db.Column('category_id', db.Integer, db.ForeignKey('categories.id'), primary_key=True)
)

books_publishers = db.Table('books_publishers',
    db.Column('book_id', db.Integer, db.ForeignKey('books.id'), primary_key=True),
    db.Column('publisher_id', db.Integer, db.ForeignKey('publishers.id'), primary_key=True)
)

class Author(db.Model):
    __tablename__ = 'authors'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    def __init__(self, name: str):
        self.name = name 
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
        }

class Book(db.Model):
    __tablename__ = 'books'
    id = db.Column(db.Integer, primary_key=True)
    isbn = db.Column(db.String(17), unique=True, nullable=False)
    title = db.Column(db.Text, unique=True, nullable=False)
    year_published = db.Column(db.SmallInteger)
    book_count = db.Column(db.Integer, nullable=False)
    authors = db.relationship('Author', secondary=books_authors, backref=db.backref('books', lazy='dynamic'))
    categories = db.relationship('Category', secondary=books_categories, backref=db.backref('books', lazy='dynamic'))
    publishers = db.relationship('Publisher', secondary=books_publishers, backref=db.backref('books', lazy='dynamic'))
    def __init__(self, isbn: str, title: str, year_published: int, book_count: int):
        self.isbn = isbn
        self.title = title
        self.year_published = year_published
        self.book_count = book_count
    
    def serialize(self):
        return {
            'id': self.id,
            'isbn': self.isbn,
            'title': self.title,
            'year_published': self.year_published,
            'book_count': self.book_count,
            'authors': [author.serialize() for author in self.authors],
            'categories': [category.serialize() for category in self.categories],
            'publishers': [publisher.serialize() for publisher in self.publishers]
        }
    
    def serialize_little(self):
        return {
            'id': self.id,
            'title': self.title,
            'authors': [author.serialize()['name'] for author in self.authors]
        }

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False, index=True)
    def __init__(self, name: str):
        self.name = name
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
        }

class Checkout(db.Model):
    __tablename__ = 'checkouts'
    id = db.Column(db.Integer, primary_key=True)
    checkout_date = db.Column(db.Date, nullable=False)
    return_date = db.Column(db.Date, nullable=False)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    def __init__(self, checkout_date, return_date, customer_id: id):
        self.checkout_date = checkout_date
        self.return_date = return_date
        self.customer_id = customer_id

    def serialize(self):
        return {
            'id': self.id,
            'checkout_date': self.checkout_date,
            'return_date': self.return_date,
            'customer_id': self.customer_id
        }

class Customer(db.Model):
    __tablename__ = 'customers'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    def __init__(self, name: str):
        self.name = name
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
        }

class Publisher(db.Model):
    __tablename__ = 'publishers'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), unique=True, nullable=False)
    def __init__(self, name: str):
        self.name = name

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
        }

class Reservation(db.Model):
    __tablename__ = 'reservations'
    id = db.Column(db.Integer, primary_key=True)
    reservation_date = db.Column(db.Date, nullable=False)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    def __init__(self,  reservation_date, customer_id: int):
        self.reservation_date = reservation_date
        self.customer_id = customer_id

    def serialize(self):
        return {
            'id': self.id,
            'reservation_date': self.reservation_date,
            'customer_id': self.customer_id
        }
