from flask import Blueprint, jsonify, abort, request
from ..models import Publisher, db

bp = Blueprint('publishers', __name__, url_prefix='/publishers')

@bp.route('', methods=['GET'])
def get_categories():
    publishers = Publisher.query.all()
    result = [author.serialize() for author in publishers]
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id):
    p = Publisher.query.get_or_404(id, "Publisher not found")
    return jsonify(p.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json:
        return abort(400)
    
    new_category = Publisher(name=request.json['name'])
    db.session.add(new_category)
    db.session.commit()

    return jsonify(new_category.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    p = Publisher.query.get_or_404(id, "Publisher not found")
    try:
        db.session.delete(p)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)
    
@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update(id: int):
    p = Publisher.query.get_or_404(id)
    if 'name' in request.json:
        p.name = request.json['name']
    try:
        db.session.commit()
        return jsonify(p.serialize())
    except:
        return jsonify(False)