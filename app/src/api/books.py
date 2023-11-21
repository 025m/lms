from flask import Blueprint, jsonify, abort, request
from ..models import Book, Author, Publisher, Category, books_authors, books_categories, books_publishers, db

bp = Blueprint('books', __name__, url_prefix='/books')

@bp.route('', methods=['GET']) 
def index():
    books = Book.query.all()
    result = []
    for b in books:
        result.append(b.serialize())
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    b = Book.query.get_or_404(id, "Book not found")
    return jsonify(b.serialize())

def add_new_author(author_name):
    new_author = Author(name=author_name)
    db.session.add(new_author)
    db.session.commit()
    return new_author

def add_new_publisher(publisher_name):
    new_publisher = Publisher(name=publisher_name)
    db.session.add(new_publisher)
    db.session.commit()
    return new_publisher

def add_new_category(category_name):
    new_category = Category(name=category_name)
    db.session.add(new_category)
    db.session.commit()
    return new_category

@bp.route('', methods=['POST'])
def create():
    if 'isbn' not in request.json or 'title' not in request.json or 'year_published' not in request.json or 'book_count' not in request.json:
        return abort(400)

    new_book = Book(
        isbn=request.json['isbn'],
        title=request.json['title'],
        year_published=request.json['year_published'],
        book_count=request.json['book_count']
    )

    if 'authors' in request.json:
        for author in request.json['authors']:
            a = Author.query.filter(Author.name == author).first()
            if not a:
                a = add_new_author(author)
            new_book.authors.append(a)
                
    if 'publishers' in request.json:
        for publisher in request.json['publishers']:
            p = Publisher.query.filter(Publisher.name == publisher).first()
            if not p:
                p = add_new_publisher(publisher)
            new_book.publishers.append(p)

    if 'categories' in request.json:
        for category in request.json['categories']:
            c = Category.query.filter(Category.name == category).first()
            if not c:
                c = add_new_category(category)
            new_book.categories.append(c)

    db.session.add(new_book)
    db.session.commit()

    return jsonify(new_book.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    b = Book.query.get_or_404(id, "Book not found")
    try:
        db.session.delete(b)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)
    
@bp.route('/<int:id>', methods=['PATCH','PUT'])
def update(id: int):
    b = Book.query.get_or_404(id)
    if 'isbn' in request.json:
        b.isbn = request.json['isbn']
    if 'title' in request.json:
        b.title = request.json['title']
    if 'year_published' in request.json:
        b.year_published = request.json['year_published']
    if 'book_count' in request.json:
        b.book_count = request.json['book_count']

    if 'authors' in request.json:
        b.authors = []
        for author in request.json['authors']:
            a = Author.query.filter(Author.name == author).first()
            if not a:
                a = add_new_author(author)
            b.authors.append(a)

    if 'publishers' in request.json:
        b.publishers = []
        for publisher in request.json['publishers']:
            p = Publisher.query.filter(Publisher.name == publisher).first()
            if not p:
                p = add_new_publisher(publisher)
            b.publishers.append(p)

    if 'categories' in request.json:
        b.categories = []
        for category in request.json['categories']:
            c = Category.query.filter(Category.name == category).first()
            if not c:
                c = add_new_category(category)
            b.categories.append(c)

    try:
        db.session.commit()
        return jsonify(b.serialize())
    except:
        return jsonify(False)

@bp.route('/<string:category_name>', methods=['GET'])
def get_books_in_category(category_name: str):
    books_in_category = Book.query.join(Book.categories).filter(Category.name == category_name).all()
    return jsonify([book.serialize_little() for book in books_in_category])