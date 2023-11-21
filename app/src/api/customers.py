from flask import Blueprint, jsonify, abort, request
from ..models import Customer, Checkout, Reservation, db

bp = Blueprint('customers', __name__, url_prefix='/customers')

@bp.route('', methods=['GET'])
def index():
    customers = Customer.query.all()
    result = []
    for c in customers:
        result.append(c.serialize())
    return jsonify(result)

@bp.route('<int:id>', methods=['GET'])
def show(id: int):
    c = Customer.query.get_or_404(id, "Customer not found")
    return jsonify(c.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json:
        return abort(400)
    
    new_customer = Customer(name=request.json['name'])
    db.session.add(new_customer)
    db.session.commit()

    return jsonify(new_customer.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    c = Customer.query.get_or_404(id, "Customer not found")
    try:
        db.session.delete(c)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update(id: int):
    c = Customer.query.get_or_404(id)
    if 'name' in request.json:
        c.name = request.json['name']
    try:
        db.session.commit()
        return jsonify(c.serialize())
    except:
        return jsonify(False)

@bp.route('/<int:id>/checkouts', methods=['GET'])
def get_customer_checkouts(id):
    customer = Customer.query.get_or_404(id)

    checkouts = Checkout.query.filter_by(customer_id=customer.id).all()
    checkouts_list = [checkout.serialize() for checkout in checkouts]
    return jsonify({'checkouts': checkouts_list})

@bp.route('/<int:id>/reservations', methods=['GET'])
def get_customer_reservations(id):
    customer = Customer.query.get_or_404(id)

    reservations = Reservation.query.filter_by(customer_id=customer.id).all()
    reservations_list = [reservation.serialize() for reservation in reservations]
    return jsonify({'reservations': reservations_list})