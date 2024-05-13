CREATE VIEW unnormalized_form_view AS
SELECT
    g.gender AS gender,
    g.title AS title,
    g.first_name AS first,
    g.last_name AS last,
    a.street_number AS street_number,
    a.street_name AS street_name,
    a.city AS city,
    a.state AS state,
    a.country AS country,
    a.postcode AS postcode,
    a.latitude AS latitude,
    a.longitude AS longitude,
    a.timezone_offset AS timezone_offset,
    a.timezone_description AS timezone_description,
    g.email AS email,
    g.date_of_birth AS dob_date,
    (strftime('%Y', 'now') - strftime('%Y', g.date_of_birth)) - (strftime('%m-%d', 'now') < strftime('%m-%d', g.date_of_birth)) AS dob_age,
    g.phone AS phone,
    g.id_name AS id_name,
    g.id_value AS id_value,
    g.nationality AS nationality,
    h.hotel_name AS hotel_name,
    ha.street_number AS hotel_street_number,
    ha.street_name AS hotel_street_name,
    ha.city AS hotel_city,
    ha.state AS hotel_state,
    ha.country AS hotel_country,
    ha.postcode AS hotel_postcode,
    h.email AS hotel_email,
    h.phone AS hotel_phone,
    h.website AS hotel_website,
    r.room_number AS room_number,
    rt.room_type_name AS room_type,
    rt.description AS room_type_description,
    rt.capacity AS room_capacity,
    rt.nightly_rate AS room_nightly_rate,
    res.start_date AS reservation_start_date,
    res.end_date AS reservation_end_date,
    CAST((julianday(res.end_date) - julianday(res.start_date)) * rt.nightly_rate AS INT) AS reservation_total_cost,
    pmt.payment_date AS payment_date,
    ptype.payment_type_name AS payment_type,
    pmt.payment_amount AS payment_amount,
    pmt.transaction_id AS transaction_id,
    pmt.notes AS payment_notes,
    rv.rating AS rating,
    rv.review_title AS review_title,
    rv.review_text AS review_text,
    rv.review_date AS review_date
FROM
    guests g
    JOIN addresses a ON g.address_id = a.address_id
    JOIN reservations res ON res.guest_id = g.guest_id
    JOIN rooms r ON res.room_id = r.room_id
    JOIN hotels h ON r.hotel_id = h.hotel_id
    JOIN addresses ha ON h.address_id = ha.address_id
    JOIN room_types rt ON r.room_type_id = rt.room_type_id
    JOIN payments pmt ON res.reservation_id = pmt.reservation_id
    JOIN payment_types ptype ON pmt.payment_type_id = ptype.payment_type_id
    JOIN guest_reviews rv ON rv.guest_id = g.guest_id AND rv.hotel_id = h.hotel_id;