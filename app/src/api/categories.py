from flask import Blueprint, jsonify, abort, request
from ..models import Category, db

bp = Blueprint('categories', __name__, url_prefix='/categories')

@bp.route('', methods=['GET'])
def get_categories():
    categories = Category.query.all()
    result = [category.serialize() for category in categories]
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id):
    c = Category.query.get_or_404(id, "Category not found")
    return jsonify(c.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json:
        return abort(400)
    
    new_category = Category(name=request.json['name'])
    db.session.add(new_category)
    db.session.commit()

    return jsonify(new_category.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    c = Category.query.get_or_404(id, "Category not found")
    try:
        db.session.delete(c)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)
    
@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update(id: int):
    c = Category.query.get_or_404(id)
    if 'name' in request.json:
        c.name = request.json['name']
    try:
        db.session.commit()
        return jsonify(c.serialize())
    except:
        return jsonify(False)