from flask import Blueprint, jsonify, abort, request
from ..models import Reservation, db

bp = Blueprint('resrvations', __name__, url_prefix='/reservations')

@bp.route('', methods=['GET'])
def index():
    reservations = Reservation.query.all()
    result = []
    for r in reservations:
        result.append(r.serialize())
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id):
    reservation = Reservation.query.get_or_404(id)
    return jsonify(reservation.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'reservation_date' not in request.json or 'customer_id' not in request.json:
        return abort(400)

    reservation_date = request.json['reservation_date']
    customer_id = request.json['customer_id']

    new_reservation = Reservation(reservation_date=reservation_date, customer_id=customer_id)

    db.session.add(new_reservation)
    db.session.commit()

    return jsonify(new_reservation.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete_reservation(id):
    reservation = Reservation.query.get_or_404(id)
    try:
        db.session.delete(reservation)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update_reservation(id):
    reservation = Reservation.query.get_or_404(id)

    data = request.get_json()
    if 'reservation_date' in data:
        reservation.reservation_date = data['reservation_date']
    if 'customer_id' in data:
        reservation.customer_id = data['customer_id']

    db.session.commit()

    return jsonify(reservation.serialize())



