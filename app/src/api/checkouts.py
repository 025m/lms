from flask import Blueprint, jsonify, abort, request
from ..models import Checkout, db

bp = Blueprint('checkouts', __name__, url_prefix='/checkouts')

@bp.route('', methods=['GET'])
def index():
    checkouts = Checkout.query.all()
    result = []
    for c in checkouts:
        result.append(c.serialize())
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id):
    c = Checkout.query.get_or_404(id, "Checkout not found")
    return jsonify(c.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'checkout_date' not in request.json or 'return_date' not in request.json or 'customer_id' not in request.json:
        return abort(400)

    checkout_date = request.json['checkout_date']
    return_date = request.json['return_date']
    customer_id = request.json['customer_id']

    new_checkout = Checkout(checkout_date=checkout_date, return_date=return_date, customer_id=customer_id)

    db.session.add(new_checkout)
    db.session.commit()

    return jsonify(new_checkout.serialize())

from flask import request, jsonify

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id):
    checkout = Checkout.query.get_or_404(id)
    try:
        db.session.delete(checkout)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update_checkout(id):
    c = Checkout.query.get_or_404(id)

    data = request.get_json()
    if 'checkout_date' in data:
        c.checkout_date = data['checkout_date']
    if 'return_date' in data:
        c.return_date = data['return_date']
    if 'customer_id' in data:
        c.customer_id = data['customer_id']

    db.session.commit()

    return jsonify(c.serialize())