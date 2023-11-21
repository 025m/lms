from flask import Blueprint, jsonify, abort, request
from ..models import Author, db

bp = Blueprint('authors', __name__, url_prefix='/authors')

@bp.route('', methods=['GET'])
def get_categories():
    authors = Author.query.all()
    result = [author.serialize() for author in authors]
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id):
    a = Author.query.get_or_404(id, "Author not found")
    return jsonify(a.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json:
        return abort(400)
    
    new_category = Author(name=request.json['name'])
    db.session.add(new_category)
    db.session.commit()

    return jsonify(new_category.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    a = Author.query.get_or_404(id, "Author not found")
    try:
        db.session.delete(a)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)
    
@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update(id: int):
    a = Author.query.get_or_404(id)
    if 'name' in request.json:
        a.name = request.json['name']
    try:
        db.session.commit()
        return jsonify(a.serialize())
    except:
        return jsonify(False)