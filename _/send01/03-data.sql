
CREATE TABLE IF NOT EXISTS addresses (
    address_id INTEGER PRIMARY KEY AUTOINCREMENT,
    street_number INTEGER,
    street_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postcode TEXT, 
    latitude TEXT,
    longitude TEXT,
    timezone_offset TEXT,
    timezone_description TEXT
);

CREATE TABLE IF NOT EXISTS guests (
    guest_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    gender TEXT,
    title TEXT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    address_id INTEGER,
    date_of_birth TEXT,
    id_name TEXT,
    id_value TEXT,
    nationality TEXT,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE IF NOT EXISTS hotels (
    hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
    hotel_name TEXT NOT NULL,
    address_id INTEGER,
    email TEXT,
    phone TEXT,
    website TEXT,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE IF NOT EXISTS room_types (
    room_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    room_type_name TEXT NOT NULL,  -- e.g., Standard, Deluxe, Suite
    description TEXT,
    capacity INTEGER,             -- Maximum occupancy
    nightly_rate DECIMAL(8,2)    -- Price per night 
);

CREATE TABLE IF NOT EXISTS rooms (
    room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    hotel_id INTEGER NOT NULL,
    room_number INTEGER NOT NULL,
    room_type_id INTEGER NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
);

CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    guest_id INTEGER NOT NULL,
    hotel_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE IF NOT EXISTS payment_types (
    payment_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    payment_type_name TEXT NOT NULL UNIQUE  -- e.g., Credit Card, Cash, Bank Transfer 
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    reservation_id INTEGER NOT NULL,
    payment_date DATE NOT NULL,
    payment_type_id INTEGER NOT NULL,
    payment_amount DECIMAL(8,2),
    transaction_id INTEGER,  
    notes TEXT,          
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (payment_type_id) REFERENCES payment_types(payment_type_id) 
);

CREATE TABLE IF NOT EXISTS guest_reviews (
    review_id INTEGER PRIMARY KEY AUTOINCREMENT,
    guest_id INTEGER NOT NULL,
    hotel_id INTEGER NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_title TEXT,
    review_text TEXT,
    review_date DATE NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE IF NOT EXISTS unnormalized_form (
    gender TEXT,
    title TEXT,
    first TEXT,
    last TEXT,
    street_number INTEGER,
    street_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postcode TEXT,
    latitude REAL,
    longitude REAL,
    timezone_offset TEXT,
    timezone_description TEXT,
    email TEXT,
    dob_date TEXT,
    dob_age INTEGER,
    phone TEXT,
    id_name TEXT,
    id_value TEXT,
    nationality TEXT,
    hotel_name TEXT,
    hotel_street_number INTEGER,
    hotel_street_name TEXT,
    hotel_city TEXT,
    hotel_state TEXT,
    hotel_country TEXT,
    hotel_postcode TEXT,
    hotel_email TEXT,
    hotel_phone TEXT,
    hotel_website TEXT,
    room_number TEXT,
    room_type TEXT,
    room_type_description TEXT,
    room_capacity INTEGER,
    room_nightly_rate REAL,
    reservation_start_date TEXT,
    reservation_end_date TEXT,
    reservation_total_cost REAL,
    payment_date TEXT,
    payment_type TEXT,
    payment_amount REAL,
    transaction_id TEXT,
    payment_notes TEXT,
    rating INTEGER,
    review_title TEXT,
    review_text TEXT,
    review_date TEXT
);



INSERT INTO unnormalized_form (gender, title, first, last, street_number, street_name, city, state, country, postcode, latitude, longitude, timezone_offset, timezone_description, email, dob_date, dob_age, phone, id_name, id_value, nationality, hotel_name, hotel_street_number, hotel_street_name, hotel_city, hotel_state, hotel_country, hotel_postcode , hotel_email, hotel_phone, hotel_website, room_number, room_type, room_type_description, room_capacity, room_nightly_rate, reservation_start_date, reservation_end_date, reservation_total_cost, payment_date, payment_type, payment_amount, transaction_id, payment_notes, rating, review_title, review_text, review_date)
VALUES ('female', 'Mrs', 'Delia', 'Hannemann', '5321', 'Mittelstraße', 'Neumarkt-Sankt Veit', 'Rheinland-Pfalz', 'Germany', '36418', '-54.9333', '116.6469', '+11:00', 'Magadan, Solomon Islands, New Caledonia', 'delia.hannemann@example.com', '1999-10-03T17:04:43.505Z', '24', '0512-6967893', 'SVNR', '25 031099 H 784', 'DE', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '477', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2024-01-22', '2024-01-27', '600.0', '2024-01-22', 'Cash', '300.0', '75988290', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2024-01-26'),
 ('male', 'Mr', 'Heinz Dieter', 'Dunker', '2901', 'Gartenweg', 'Templin', 'Thüringen', 'Germany', '92109', '65.6429', '151.4410', '+4:00', 'Abu Dhabi, Muscat, Baku, Tbilisi', 'heinzdieter.dunker@example.com', '1946-02-17T17:40:05.313Z', '78', '0668-7812421', 'SVNR', '54 170246 D 413', 'DE', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '134', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2023-03-02', '2023-03-09', '1092.0', '2023-03-02', 'Cash', '819.0', '21351439', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2023-03-12'),
 ('male', 'Mr', 'Armando', 'Caldwell', '3771', 'Brown Terrace', 'Wichita', 'Vermont', 'United States', '38969', '-68.6467', '-64.0230', '-10:00', 'Hawaii', 'armando.caldwell@example.com', '1971-02-22T12:49:49.167Z', '53', '(498) 518-2749', 'SSN', '506-70-7624', 'US', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '371', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2023-09-03', '2023-09-06', '2274.0', '2023-09-03', 'Bank Transfer', '1137.0', '86202663', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2023-09-07'),
 ('male', 'Mr', 'Håvard', 'Anda', '7412', 'Arne Garborgs plass', 'Rød', 'Nordland', 'Norway', '6789', '-79.4588', '171.7499', '+2:00', 'Kaliningrad, South Africa', 'havard.anda@example.com', '1948-06-27T00:06:48.157Z', '75', '22740795', 'FN', '27064848505', 'NO', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '386', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-06-19', '2023-06-20', '243.0', '2023-06-19', 'Cash', '182.25', '81835362', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2023-06-20'),
 ('male', 'Mr', 'Reynaldo', 'Prieto', '7706', 'Periférico Hidalgo', 'San Luis Tehuiloyocan', 'Tabasco', 'Mexico', '88002', '5.3338', '-176.7938', '+9:00', 'Tokyo, Seoul, Osaka, Sapporo, Yakutsk', 'reynaldo.prieto@example.com', '1999-05-23T19:55:17.456Z', '24', '(627) 664 0296', 'NSS', '92 64 64 6903 3', 'MX', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '317', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2024-01-21', '2024-01-26', '425.0', '2024-01-21', 'Bank Transfer', '0.0', '99182299', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2024-01-29'),
 ('female', 'Ms', 'Elli', 'Freudenberg', '569', 'Uhlandstraße', 'Spremberg', 'Baden-Württemberg', 'Germany', '38374', '55.9044', '118.3366', '+4:30', 'Kabul', 'elli.freudenberg@example.com', '1998-05-31T12:51:35.721Z', '25', '0233-0457128', 'SVNR', '49 310598 F 978', 'DE', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '453', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-02-19', '2023-03-05', '3402.0', '2023-02-19', 'Cash', '850.5', '74243611', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2023-02-20'),
 ('female', 'Miss', 'Latife', 'Demirbaş', '2363', 'Atatürk Sk', 'Kastamonu', 'Tekirdağ', 'Turkey', '99526', '48.7217', '101.7217', '-3:00', 'Brazil, Buenos Aires, Georgetown', 'latife.demirbas@example.com', '1973-03-11T23:54:52.606Z', '51', '(972)-335-7099', '', '', 'TR', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '394', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2024-02-16', '2024-02-25', '6822.0', '2024-02-16', 'Cash', '1705.5', '32469849', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2024-02-27'),
 ('female', 'Miss', 'Sandra', 'Fields', '1977', 'Lovers Ln', 'Jacksonville', 'Indiana', 'United States', '91011', '-15.5421', '-150.1251', '-10:00', 'Hawaii', 'sandra.fields@example.com', '1989-12-19T09:14:44.019Z', '34', '(642) 309-3279', 'SSN', '888-19-1901', 'US', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '309', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-08-24', '2023-09-05', '2916.0', '2023-08-24', 'Credit Card', '2187.0', '17590853', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2023-08-30'),
 ('male', 'Mr', 'Vilho', 'Ollila', '9426', 'Suvantokatu', 'Joutsa', 'South Karelia', 'Finland', '52695', '-87.5227', '15.0425', '+8:00', 'Beijing, Perth, Singapore, Hong Kong', 'vilho.ollila@example.com', '1982-02-06T02:11:41.205Z', '42', '06-998-394', 'HETU', 'NaNNA881undefined', 'FI', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '178', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-11-01', '2023-11-11', '850.0', '2023-11-01', 'Credit Card', '850.0', '42331753', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2023-11-18'),
 ('female', 'Mrs', 'Suchita', 'Kumar', '1680', 'Gali Paranthe Wali', 'Satna', 'Chhattisgarh', 'India', '43902', '-40.4555', '-153.9290', '-5:00', 'Eastern Time (US & Canada), Bogota, Lima', 'suchita.kumar@example.com', '1998-01-27T11:08:06.647Z', '26', '9893248403', 'UIDAI', '622495396746', 'IN', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '190', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2022-10-09', '2022-10-14', '1215.0', '2022-10-09', 'Cash', '607.5', '67704072', '', '4', 'Luxurious and relaxing', 'The spa treatments were divine, the room was spacious and well-appointed, and the overall ambiance was perfect for unwinding. Highly recommended.', '2022-10-10'),
 ('female', 'Mrs', 'Lorena', 'Solís', '1445', 'Boulevard Lesotho', 'El Sauzal', 'Jalisco', 'Mexico', '36586', '-7.7987', '65.1679', '+3:30', 'Tehran', 'lorena.solis@example.com', '1989-12-15T17:10:39.395Z', '34', '(603) 817 1175', 'NSS', '52 78 22 9794 3', 'MX', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '141', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2022-11-23', '2022-12-03', '1200.0', '2022-11-23', 'Credit Card', '1200.0', '82175341', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2022-12-06'),
 ('male', 'Mr', 'Timoteo', 'Leyva', '9482', 'Pasaje Tello', 'Bavispe', 'Nayarit', 'Mexico', '24440', '53.7178', '76.0103', '+5:45', 'Kathmandu', 'timoteo.leyva@example.com', '1999-04-14T09:13:43.495Z', '25', '(671) 413 0709', 'NSS', '87 01 02 7040 2', 'MX', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '179', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2024-04-06', '2024-04-13', '840.0', '2024-04-06', 'Credit Card', '840.0', '89656352', '', '5', 'Gem in the heart of the city', 'This hotel was surprisingly affordable, perfectly located near all the main attractions, and the staff offered exceptional service. We''ll definitely stay here again. ', '2024-04-12'),
 ('female', 'Mrs', 'Nieves', 'Román', '781', 'Calle Mota', 'Oviedo', 'Cantabria', 'Spain', '80339', '-80.9375', '160.1970', '+3:30', 'Tehran', 'nieves.roman@example.com', '1957-07-15T13:46:37.155Z', '66', '930-832-404', 'DNI', '37875110-E', 'ES', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '435', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-11-14', '2022-11-20', '4548.0', '2022-11-14', 'Cash', '2274.0', '76734479', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2022-11-17'),
 ('male', 'Mr', 'Simon', 'Taylor', '7684', 'Stanley Way', 'St. Antoine', 'Northwest Territories', 'Canada', 'K7O 0S9', '44.0453', '-131.8331', '+6:00', 'Almaty, Dhaka, Colombo', 'simon.taylor@example.com', '2000-08-05T12:40:24.836Z', '23', 'F15 H49-5731', 'SIN', '112943667', 'CA', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '448', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2022-06-28', '2022-07-06', '1248.0', '2022-06-28', 'Credit Card', '1248.0', '81812165', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2022-06-30'),
 ('female', 'Ms', 'Rony', 'Valckx', '7353', 'Godfriedstraat', 'Losdorp', 'Overijssel', 'Netherlands', '1356 JO', '-67.0787', '156.4832', '-3:30', 'Newfoundland', 'rony.valckx@example.com', '1995-01-25T12:38:50.051Z', '29', '(0884) 681513', 'BSN', '43436475', 'NL', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '143', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-10-02', '2023-10-16', '1190.0', '2023-10-02', 'Bank Transfer', '1190.0', '46907741', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2023-10-24'),
 ('male', 'Monsieur', 'Aurelio', 'Lecomte', '703', 'Rue Gasparin', 'Büren an der Aare', 'Schwyz', 'Switzerland', '7891', '30.2620', '43.6919', '+5:45', 'Kathmandu', 'aurelio.lecomte@example.com', '1982-06-20T04:20:29.482Z', '41', '079 854 32 02', 'AVS', '756.0014.4983.00', 'CH', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '213', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-09-05', '2023-09-08', '255.0', '2023-09-05', 'Bank Transfer', '63.75', '22956991', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2023-09-08'),
 ('female', 'Miss', 'Dragica', 'Srejović', '7727', 'Siniše Nikolajevića', 'Sremski Karlovci', 'Bor', 'Serbia', '61328', '-57.6850', '95.9145', '-4:00', 'Atlantic Time (Canada), Caracas, La Paz', 'dragica.srejovic@example.com', '1955-01-26T06:38:30.214Z', '69', '018-2124-140', 'SID', '191233130', 'RS', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '188', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-09-04', '2022-09-13', '6822.0', '2022-09-04', 'Credit Card', '6822.0', '39095184', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2022-09-10'),
 ('female', 'Ms', 'Bedete', 'Nascimento', '7714', 'Rua São José ', 'Igarassu', 'Maranhão', 'Brazil', '90383', '87.7475', '167.7625', '-5:00', 'Eastern Time (US & Canada), Bogota, Lima', 'bedete.nascimento@example.com', '1995-02-03T15:09:15.701Z', '29', '(31) 5386-7746', 'CPF', '694.753.107-66', 'BR', 'Courtyard By Marriott', '30', 'By Marriott', 'Courtyard', 'MA', 'US', '02138', 'info@courtyardbymarriott.example', '(617) 222-2222', 'http://www.courtyardbymarriott.example', '385', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2022-06-05', '2022-06-10', '780.0', '2022-06-05', 'Bank Transfer', '780.0', '49667091', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2022-06-14'),
 ('female', 'Miss', 'Vlatka', 'Spasić', '7057', 'Trinaestog Septembra', 'Preševo', 'Nišava', 'Serbia', '93652', '63.8746', '76.7416', '-11:00', 'Midway Island, Samoa', 'vlatka.spasic@example.com', '1960-11-20T19:25:13.400Z', '63', '034-1037-038', 'SID', '368438128', 'RS', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '399', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-02-16', '2023-02-23', '1701.0', '2023-02-16', 'Credit Card', '1701.0', '79291409', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2023-02-27'),
 ('male', 'Mr', 'Oğuzhan', 'Çamdalı', '8813', 'Fatih Sultan Mehmet Cd', 'Mersin', 'Sivas', 'Turkey', '42992', '-67.8543', '-98.2613', '+10:00', 'Eastern Australia, Guam, Vladivostok', 'oguzhan.camdali@example.com', '1955-06-12T02:52:09.341Z', '68', '(696)-537-1401', '', '', 'TR', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '484', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2023-09-04', '2023-09-18', '2184.0', '2023-09-04', 'Bank Transfer', '1638.0', '93092547', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2023-09-08'),
 ('male', 'Mr', 'Noah', 'Haukland', '1883', 'Jomfruhagen', 'Leira', 'Bergen', 'Norway', '4072', '48.7787', '96.6175', '-7:00', 'Mountain Time (US & Canada)', 'noah.haukland@example.com', '2000-04-01T19:17:08.040Z', '24', '28169891', 'FN', '01040094772', 'NO', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '307', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2022-08-14', '2022-08-24', '1560.0', '2022-08-14', 'Bank Transfer', '1170.0', '77394922', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2022-08-20'),
 ('female', 'Ms', 'Emilie', 'Lavoie', '3679', 'Stanley Way', 'Trout Lake', 'Manitoba', 'Canada', 'B6J 7C4', '6.2583', '-82.9442', '+8:00', 'Beijing, Perth, Singapore, Hong Kong', 'emilie.lavoie@example.com', '1954-05-14T08:31:00.735Z', '69', 'K25 Y31-1352', 'SIN', '757948237', 'CA', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '269', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2023-02-23', '2023-02-26', '2274.0', '2023-02-23', 'Credit Card', '1137.0', '65074912', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2023-03-01'),
 ('male', 'Mr', 'Janko', 'Stojanović', '7112', 'Brehtova', 'Petrovac na Mlavi', 'Kosovska Mitrovica', 'Serbia', '98905', '89.1353', '162.5864', '+3:00', 'Baghdad, Riyadh, Moscow, St. Petersburg', 'janko.stojanovic@example.com', '2001-02-14T15:51:40.112Z', '23', '010-5884-960', 'SID', '041547116', 'RS', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '369', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2023-05-28', '2023-06-03', '720.0', '2023-05-28', 'Credit Card', '360.0', '41018698', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2023-05-29'),
 ('male', 'Monsieur', 'Aurelio', 'Colin', '1570', 'Avenue de L''Abbé-Roussel', 'Marchissy', 'Zürich', 'Switzerland', '6115', '-48.4085', '83.8431', '+3:30', 'Tehran', 'aurelio.colin@example.com', '1979-12-19T04:05:18.798Z', '44', '079 811 42 97', 'AVS', '756.9839.2341.67', 'CH', 'Courtyard By Marriott', '30', 'By Marriott', 'Courtyard', 'MA', 'US', '02138', 'info@courtyardbymarriott.example', '(617) 222-2222', 'http://www.courtyardbymarriott.example', '347', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2023-06-08', '2023-06-14', '936.0', '2023-06-08', 'Cash', '468.0', '16632461', '', '5', 'Family-friendly paradise', 'Our kids absolutely loved this hotel! The activities were top-notch, the staff went out of their way, and the beach was beautiful.  Best family vacation ever.', '2023-06-18'),
 ('female', 'Mrs', 'Anzhela', 'Tyutyunnik', '5441', 'Lva Tolstogo', 'Kagarlik', 'Sumska', 'Ukraine', '29683', '-86.1369', '8.6954', '+8:00', 'Beijing, Perth, Singapore, Hong Kong', 'anzhela.tyutyunnik@example.com', '1963-11-02T18:23:12.376Z', '60', '(097) C28-3106', '', '', 'UA', 'Courtyard By Marriott', '30', 'By Marriott', 'Courtyard', 'MA', 'US', '02138', 'info@courtyardbymarriott.example', '(617) 222-2222', 'http://www.courtyardbymarriott.example', '200', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-06-10', '2022-06-17', '5306.0', '2022-06-10', 'Cash', '0.0', '63271965', '', '2', 'Majorly disappointed', 'The pictures online were completely misleading. The pool was tiny, the amenities were outdated, and the breakfast was inedible. ', '2022-06-15'),
 ('female', 'Mrs', 'Ella', 'Madsen', '1579', 'Solvej', 'Århus C.', 'Nordjylland', 'Denmark', '77898', '8.1775', '-15.0846', '-12:00', 'Eniwetok, Kwajalein', 'ella.madsen@example.com', '1953-09-06T23:39:18.235Z', '70', '01795732', 'CPR', '060953-8304', 'DK', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '441', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2023-08-08', '2023-08-15', '1092.0', '2023-08-08', 'Cash', '1092.0', '98186944', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2023-08-15'),
 ('male', 'Mr', 'Gabriel', 'Novak', '5660', 'Pierre Ave', 'Havelock', 'Manitoba', 'Canada', 'W1T 3T1', '64.2543', '-134.0260', '+5:30', 'Bombay, Calcutta, Madras, New Delhi', 'gabriel.novak@example.com', '1970-10-01T12:20:41.796Z', '53', 'P32 Y39-1109', 'SIN', '784519472', 'CA', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '119', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2023-05-06', '2023-05-20', '1680.0', '2023-05-06', 'Cash', '420.0', '85478469', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2023-05-18'),
 ('female', 'Mrs', 'Nelya', 'Bablyak', '2805', 'Vovchinecka', 'Berezivka', 'Donecka', 'Ukraine', '36829', '-30.5773', '16.9399', '+10:00', 'Eastern Australia, Guam, Vladivostok', 'nelya.bablyak@example.com', '1999-08-24T21:40:22.117Z', '24', '(098) Y05-6870', '', '', 'UA', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '279', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2022-12-04', '2022-12-16', '1020.0', '2022-12-04', 'Bank Transfer', '510.0', '32905971', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2022-12-23'),
 ('male', 'Mr', 'Ryan', 'Walker', '7039', 'Bay Ave', 'Chatham', 'Yukon', 'Canada', 'F3S 3H0', '30.4189', '145.9484', '+9:00', 'Tokyo, Seoul, Osaka, Sapporo, Yakutsk', 'ryan.walker@example.com', '1973-03-31T17:15:32.289Z', '51', 'E87 I60-1380', 'SIN', '593748072', 'CA', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '111', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-09-08', '2022-09-21', '9854.0', '2022-09-08', 'Cash', '2463.5', '78768625', '', '4', 'Luxurious and relaxing', 'The spa treatments were divine, the room was spacious and well-appointed, and the overall ambiance was perfect for unwinding. Highly recommended.', '2022-09-27'),
 ('female', 'Mrs', 'June', 'Sutton', '2200', 'Shady Ln Dr', 'Jersey City', 'Tennessee', 'United States', '82545', '-33.4550', '79.0551', '-10:00', 'Hawaii', 'june.sutton@example.com', '1965-03-26T10:55:24.919Z', '59', '(325) 414-4251', 'SSN', '286-23-2985', 'US', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '490', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2022-07-27', '2022-08-06', '2430.0', '2022-07-27', 'Cash', '0.0', '33637464', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2022-08-12'),
 ('female', 'Ms', 'Nalan', 'Bademci', '9665', 'Abanoz Sk', 'İzmir', 'Edirne', 'Turkey', '51427', '-17.4845', '-37.3336', '+9:30', 'Adelaide, Darwin', 'nalan.bademci@example.com', '1944-12-19T19:03:57.576Z', '79', '(726)-132-0593', '', '', 'TR', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '216', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-07-01', '2023-07-10', '2187.0', '2023-07-01', 'Cash', '2187.0', '43419551', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2023-07-14'),
 ('male', 'Mr', 'Josep', 'Peña', '5218', 'Calle de Ferraz', 'Santa Cruz de Tenerife', 'Asturias', 'Spain', '60129', '-87.6748', '-173.6816', '-4:00', 'Atlantic Time (Canada), Caracas, La Paz', 'josep.pena@example.com', '2001-05-16T13:51:03.042Z', '22', '965-068-721', 'DNI', '48175551-C', 'ES', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '160', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2022-10-06', '2022-10-10', '972.0', '2022-10-06', 'Bank Transfer', '486.0', '17194808', '', '4', 'Luxurious and relaxing', 'The spa treatments were divine, the room was spacious and well-appointed, and the overall ambiance was perfect for unwinding. Highly recommended.', '2022-10-10'),
 ('female', 'Mrs', 'Iara', 'Pinto', '8851', 'Rua Rui Barbosa ', 'Ilhéus', 'Alagoas', 'Brazil', '11143', '-56.9566', '-4.8679', '-12:00', 'Eniwetok, Kwajalein', 'iara.pinto@example.com', '1983-11-11T16:35:32.694Z', '40', '(60) 9164-0305', 'CPF', '537.459.398-17', 'BR', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '264', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2023-01-20', '2023-01-27', '5306.0', '2023-01-20', 'Bank Transfer', '2653.0', '51554172', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2023-02-01'),
 ('female', 'Mademoiselle', 'Danièle', 'Lecomte', '2279', 'Rue Barrier', 'Lichtensteig', 'Valais', 'Switzerland', '1323', '67.0514', '-91.7689', '-6:00', 'Central Time (US & Canada), Mexico City', 'daniele.lecomte@example.com', '1945-10-02T03:41:17.922Z', '78', '078 262 59 97', 'AVS', '756.9057.0746.84', 'CH', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '121', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2022-05-08', '2022-05-12', '340.0', '2022-05-08', 'Cash', '340.0', '94896074', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2022-05-12'),
 ('male', 'Mr', 'Anthony', 'Singh', '2537', 'Bay Ave', 'Cornwall', 'Nova Scotia', 'Canada', 'L7Y 9L0', '76.5455', '124.2741', '+5:00', 'Ekaterinburg, Islamabad, Karachi, Tashkent', 'anthony.singh@example.com', '1992-12-05T11:05:51.385Z', '31', 'J02 W42-2775', 'SIN', '210627881', 'CA', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '165', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2022-06-14', '2022-06-22', '960.0', '2022-06-14', 'Bank Transfer', '240.0', '36946873', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2022-06-19'),
 ('female', 'Mrs', 'Halima', 'Hovland', '9893', 'Framveien', 'Grinde', 'Hedmark', 'Norway', '1471', '37.0967', '174.6921', '+11:00', 'Magadan, Solomon Islands, New Caledonia', 'halima.hovland@example.com', '1949-03-19T21:00:20.622Z', '75', '59565528', 'FN', '19034908845', 'NO', 'Courtyard By Marriott', '30', 'By Marriott', 'Courtyard', 'MA', 'US', '02138', 'info@courtyardbymarriott.example', '(617) 222-2222', 'http://www.courtyardbymarriott.example', '241', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-10-01', '2022-10-12', '8338.0', '2022-10-01', 'Bank Transfer', '0.0', '41712517', '', '1', 'Completely unacceptable', 'Our room hadn''t been cleaned from the previous guests, there was no hot water, and the front desk staff were completely unhelpful. Ruined our weekend getaway.', '2022-10-03'),
 ('male', 'Mr', 'Dragomir', 'Simeonović', '7297', 'Vašarska', 'Senta', 'Raška', 'Serbia', '57495', '-6.1225', '-66.7503', '-12:00', 'Eniwetok, Kwajalein', 'dragomir.simeonovic@example.com', '1953-12-05T02:45:54.460Z', '70', '026-3544-361', 'SID', '293642644', 'RS', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '116', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2023-06-16', '2023-06-26', '7580.0', '2023-06-16', 'Cash', '0.0', '29149937', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2023-07-06'),
 ('male', 'Mr', 'Jovi', 'Roerdink', '7863', 'Dassenstraat', 'Brakel', 'Zeeland', 'Netherlands', '0719 GX', '23.9674', '13.2428', '+4:00', 'Abu Dhabi, Muscat, Baku, Tbilisi', 'jovi.roerdink@example.com', '1958-08-17T13:55:09.348Z', '65', '(077) 8390755', 'BSN', '02897489', 'NL', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '247', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2022-05-25', '2022-06-08', '2184.0', '2022-05-25', 'Credit Card', '1638.0', '29074999', '', '5', 'Gem in the heart of the city', 'This hotel was surprisingly affordable, perfectly located near all the main attractions, and the staff offered exceptional service. We''ll definitely stay here again. ', '2022-05-29'),
 ('female', 'Ms', 'Kübra', 'Kunt', '6785', 'Maçka Cd', 'Trabzon', 'Şırnak', 'Turkey', '72775', '-40.4520', '20.5911', '-4:00', 'Atlantic Time (Canada), Caracas, La Paz', 'kubra.kunt@example.com', '1984-01-01T09:57:21.930Z', '40', '(796)-658-7211', '', '', 'TR', 'Westin New York Times Square', '422', 'New York Times Square', 'Westin', 'NY', 'US', '10001', 'info@westinnytimes.example', '(212) 555-5555', 'http://www.westinnytimes.example', '131', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2022-08-03', '2022-08-06', '2274.0', '2022-08-03', 'Credit Card', '568.5', '45575664', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2022-08-08'),
 ('female', 'Ms', 'ثنا', 'نكو نظر', '3797', 'شهید محمد منتظری', 'نجف‌آباد', 'کردستان', 'Iran', '94741', '65.3823', '-47.5524', '-9:00', 'Alaska', 'thn.nkwnzr@example.com', '1968-08-26T10:14:21.429Z', '55', '046-31313098', '', '', 'IR', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '294', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2022-09-06', '2022-09-11', '425.0', '2022-09-06', 'Cash', '318.75', '36454190', '', '3', 'Mixed feelings', 'The location was great and the bed was comfortable, but the constant construction noise, lackluster breakfast, and unresponsive staff left a lot to be desired.', '2022-09-08'),
 ('female', 'Miss', 'Arpitha', 'Saniel', '89', 'Tilak Marg', 'Mumbai', 'Andhra Pradesh', 'India', '33673', '-13.4588', '-176.5497', '+7:00', 'Bangkok, Hanoi, Jakarta', 'arpitha.saniel@example.com', '1948-03-09T12:48:29.423Z', '76', '8143770602', 'UIDAI', '194600143220', 'IN', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '123', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2022-08-05', '2022-08-07', '240.0', '2022-08-05', 'Credit Card', '120.0', '70397538', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2022-08-08'),
 ('male', 'Mr', 'Oliver', 'Barnaby', '7345', 'Richmond Ave', 'Souris', 'Québec', 'Canada', 'Y5B 7H1', '-18.3649', '95.9228', '-6:00', 'Central Time (US & Canada), Mexico City', 'oliver.barnaby@example.com', '1992-09-23T21:01:49.464Z', '31', 'M59 P34-0265', 'SIN', '532452935', 'CA', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '367', 'Presidential Suite', 'The ultimate in luxury, with multiple bedrooms, living areas, and premium amenities', '6', '758.0', '2023-06-03', '2023-06-04', '758.0', '2023-06-03', 'Bank Transfer', '758.0', '40135586', '', '4', 'Charming and comfortable getaway', 'This hotel had a lovely, intimate atmosphere. The staff were friendly, the pool area was relaxing, and it was the perfect location for exploring the city.', '2023-06-03'),
 ('female', 'Miss', 'Amber', 'Hopkins', '7504', 'Mill Road', 'Youghal', 'Monaghan', 'Ireland', '87043', '-36.9105', '-149.4567', '+5:00', 'Ekaterinburg, Islamabad, Karachi, Tashkent', 'amber.hopkins@example.com', '1952-02-02T18:59:29.694Z', '72', '031-851-6561', 'PPS', '9326066T', 'IE', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '426', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-09-03', '2023-09-17', '1190.0', '2023-09-03', 'Cash', '1190.0', '43736046', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2023-09-14'),
 ('female', 'Miss', 'Monika', 'Høivik', '6322', 'Frierveien', 'Lena', 'Oslo', 'Norway', '7391', '5.7595', '177.9590', '-6:00', 'Central Time (US & Canada), Mexico City', 'monika.hoivik@example.com', '1974-08-13T12:55:54.405Z', '49', '72901358', 'FN', '13087448821', 'NO', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '321', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2023-11-21', '2023-11-26', '600.0', '2023-11-21', 'Bank Transfer', '150.0', '72776361', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2023-11-25'),
 ('female', 'Mrs', 'Rosario', 'Ramírez', '3256', 'Avenida de Castilla', 'Castellón de la Plana', 'Aragón', 'Spain', '27624', '47.3009', '-9.0863', '+7:00', 'Bangkok, Hanoi, Jakarta', 'rosario.ramirez@example.com', '1989-07-06T05:15:29.046Z', '34', '947-578-651', 'DNI', '19641625-R', 'ES', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '451', 'Suite', 'Luxurious suite with separate living area', '4', '243.0', '2023-11-28', '2023-12-05', '1701.0', '2023-11-28', 'Bank Transfer', '1275.75', '11000033', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2023-11-29'),
 ('male', 'Mr', 'Charlie', 'Peterson', '8821', 'Killarney Road', 'Kells', 'Cork City', 'Ireland', '75721', '-51.0753', '67.5997', '+6:00', 'Almaty, Dhaka, Colombo', 'charlie.peterson@example.com', '1977-02-28T05:29:07.754Z', '47', '011-128-3548', 'PPS', '5139290T', 'IE', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '113', 'Family Room', 'Spacious accommodations for the whole family, may include bunk beds or connecting rooms', '5', '156.0', '2023-12-11', '2023-12-19', '1248.0', '2023-12-11', 'Cash', '1248.0', '57440912', '', '4', 'Luxurious and relaxing', 'The spa treatments were divine, the room was spacious and well-appointed, and the overall ambiance was perfect for unwinding. Highly recommended.', '2023-12-17'),
 ('male', 'Mr', 'Barış', 'Topaloğlu', '590', 'Doktorlar Cd', 'İzmir', 'Batman', 'Turkey', '88427', '61.9289', '-0.5166', '+9:30', 'Adelaide, Darwin', 'baris.topaloglu@example.com', '1970-03-08T18:15:10.032Z', '54', '(751)-368-0806', '', '', 'TR', 'Latham Hotel', '78', 'Latham', 'Latham', 'Saxony', 'DE', '20052', 'info@latham.example', '(617) 222-2222', 'http://www.latham.example', '251', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2023-04-06', '2023-04-12', '720.0', '2023-04-06', 'Cash', '180.0', '84552099', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2023-04-15'),
 ('female', 'Miss', 'Edeltrud', 'Rempel', '5550', 'Rosenstraße', 'Solms', 'Sachsen-Anhalt', 'Germany', '88383', '-12.1276', '-133.2549', '-9:00', 'Alaska', 'edeltrud.rempel@example.com', '1946-07-26T10:23:37.748Z', '77', '0154-1261912', 'SVNR', '38 260746 R 565', 'DE', 'Courtyard By Marriott', '30', 'By Marriott', 'Courtyard', 'MA', 'US', '02138', 'info@courtyardbymarriott.example', '(617) 222-2222', 'http://www.courtyardbymarriott.example', '122', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-09-30', '2023-10-10', '850.0', '2023-09-30', 'Cash', '637.5', '91082403', '', '1', 'Dreadful experience, never again', 'The room was filthy, the staff were rude, and the noise level was unbearable.  Worst hotel stay I''ve ever had.', '2023-10-09'),
 ('male', 'Mr', 'Malte', 'Lind', '2273', 'Kapellenweg', 'Ulrichstein', 'Rheinland-Pfalz', 'Germany', '70751', '-68.5975', '-177.8027', '+11:00', 'Magadan, Solomon Islands, New Caledonia', 'malte.lind@example.com', '1957-09-27T03:00:37.281Z', '66', '0393-3302748', 'SVNR', '44 260957 L 096', 'DE', 'Pickwick Arms Hotel', '8', 'Pickwick Arms', 'Pickwick', 'Hamburg', 'DE', '20149', 'info@pickwickarms.example', '(0151) 555-5555', 'http://www.pickwickarms.example', '466', 'Deluxe', 'Spacious room with upgraded furnishings', '3', '120.0', '2022-06-16', '2022-06-18', '240.0', '2022-06-16', 'Credit Card', '60.0', '10997455', '', '2', 'Not worth the price', 'For the amount we paid, I expected far better service and quality. The room was cramped, the view was terrible, and everything felt run-down.', '2022-06-17'),
 ('female', 'Ms', 'Layla', 'White', '1410', 'Mornington Road', 'Rotorua', 'Canterbury', 'New Zealand', '98344', '30.3879', '40.4747', '-4:00', 'Atlantic Time (Canada), Caracas, La Paz', 'layla.white@example.com', '1981-07-20T07:21:14.156Z', '42', '(148)-150-1292', '', '', 'NZ', 'Hampton Inn Madison Square Garden Area Hotel', '151', 'Madison Square Garden Area', 'Hampton', 'MA', 'US', '02138', 'info@hamptoninn.example', '(617) 222-2222', 'http://www.hamptoninn.example', '250', 'Standard', 'Cozy room with essential amenities', '2', '85.0', '2023-12-28', '2024-01-03', '510.0', '2023-12-28', 'Bank Transfer', '382.5', '66911219', '', '5', 'Exceeded all expectations!', 'From the moment we arrived, we were treated with such warmth and hospitality.  The rooms were immaculate, the views breathtaking, and the food was incredible.  We''ll absolutely be back!', '2024-01-06');





INSERT INTO addresses (street_number, street_name, city, state, country, postcode, latitude, longitude, timezone_offset, timezone_description)
SELECT DISTINCT street_number, street_name, city, state, country, postcode, latitude, longitude, timezone_offset, timezone_description
FROM unnormalized_form
WHERE street_number IS NOT NULL AND street_name IS NOT NULL;

INSERT INTO addresses (street_number, street_name, city, state, country, postcode)
SELECT DISTINCT hotel_street_number, hotel_street_name, hotel_city, hotel_state, hotel_country, hotel_postcode
FROM unnormalized_form
WHERE hotel_street_number IS NOT NULL AND hotel_street_name IS NOT NULL;

INSERT INTO guests (gender, title, first_name, last_name, email, phone, address_id, date_of_birth, id_name, id_value, nationality)
SELECT DISTINCT gender, title, first, last, email, phone, 
    (SELECT address_id FROM addresses WHERE street_number = unnormalized_form.street_number AND street_name = unnormalized_form.street_name LIMIT 1),
    dob_date, id_name, id_value, nationality
FROM unnormalized_form
WHERE email IS NOT NULL;

INSERT INTO hotels (hotel_name, address_id, email, phone, website)
SELECT DISTINCT hotel_name, 
    (SELECT address_id FROM addresses WHERE street_number = unnormalized_form.hotel_street_number AND street_name = unnormalized_form.hotel_street_name LIMIT 1),
    hotel_email, hotel_phone, hotel_website
FROM unnormalized_form
WHERE hotel_name IS NOT NULL;

INSERT INTO room_types (room_type_name, description, capacity, nightly_rate)
SELECT DISTINCT room_type, room_type_description, room_capacity, room_nightly_rate
FROM unnormalized_form
WHERE room_type IS NOT NULL;

INSERT INTO rooms (hotel_id, room_number, room_type_id)
SELECT DISTINCT 
    (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1), 
    room_number, 
    (SELECT room_type_id FROM room_types WHERE room_type_name = unnormalized_form.room_type LIMIT 1)
FROM unnormalized_form
WHERE room_number IS NOT NULL AND hotel_name IS NOT NULL AND room_type IS NOT NULL;

INSERT INTO reservations (guest_id, hotel_id, room_id, start_date, end_date)
SELECT DISTINCT 
    (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1), 
    (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1),
    (SELECT room_id FROM rooms WHERE room_number = unnormalized_form.room_number AND hotel_id = (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1) LIMIT 1),
    reservation_start_date, reservation_end_date
FROM unnormalized_form
WHERE email IS NOT NULL AND hotel_name IS NOT NULL AND room_number IS NOT NULL;

INSERT INTO payment_types (payment_type_name)
SELECT DISTINCT payment_type
FROM unnormalized_form
WHERE payment_type IS NOT NULL;

INSERT INTO payments (reservation_id, payment_date, payment_type_id, payment_amount, transaction_id, notes)
SELECT DISTINCT 
    (SELECT reservation_id FROM reservations 
        WHERE guest_id = (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1) 
        AND room_id = (SELECT room_id FROM rooms WHERE room_number = unnormalized_form.room_number LIMIT 1) 
        AND start_date = unnormalized_form.reservation_start_date 
        LIMIT 1),
    payment_date, 
    (SELECT payment_type_id FROM payment_types WHERE payment_type_name = unnormalized_form.payment_type LIMIT 1),
    payment_amount,
    transaction_id,
    payment_notes
FROM unnormalized_form
WHERE payment_date IS NOT NULL AND payment_type IS NOT NULL AND payment_amount IS NOT NULL;

INSERT INTO guest_reviews (guest_id, hotel_id, rating, review_title, review_text, review_date)
SELECT DISTINCT 
    (SELECT guest_id FROM guests WHERE email = unnormalized_form.email LIMIT 1),
    (SELECT hotel_id FROM hotels WHERE hotel_name = unnormalized_form.hotel_name LIMIT 1),
    rating, 
    review_title,
    review_text,
    review_date
FROM unnormalized_form
WHERE email IS NOT NULL 
    AND hotel_name IS NOT NULL 
    AND rating IS NOT NULL 
    AND review_title IS NOT NULL 
    AND review_text IS NOT NULL
    AND review_date IS NOT NULL;

