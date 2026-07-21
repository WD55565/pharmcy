-- Development/demo seed data. Tagged with source = 'demo' and a unique
-- external_id per row so it is clearly distinguishable from real imported
-- data (see the dataimport de-duplication key on (source, external_id))
-- and can be identified/removed later without guessing at row identity.

INSERT INTO pharmacies
    (name, phone, address, district, latitude, longitude, is_on_duty,
     opening_time, closing_time, source, external_id, created_at, updated_at)
VALUES
    ('Kadıköy Merkez Eczanesi', '0216 336 12 34', 'Söğütlüçeşme Cad. No:12', 'Kadıköy',
     40.9927, 29.0275, TRUE, '20:00:00', '08:00:00', 'demo', 'demo-001', NOW(), NOW()),

    ('Beşiktaş Sahil Eczanesi', '0212 259 45 67', 'Barbaros Bulvarı No:34', 'Beşiktaş',
     41.0422, 29.0083, TRUE, '20:00:00', '08:00:00', 'demo', 'demo-002', NOW(), NOW()),

    ('Şişli Nişantaşı Eczanesi', '0212 231 78 90', 'Vali Konağı Cad. No:56', 'Şişli',
     41.0602, 28.9877, TRUE, '20:00:00', '08:00:00', 'demo', 'demo-003', NOW(), NOW()),

    ('Fatih Tarihi Yarımada Eczanesi', '0212 521 23 45', 'Fevzi Paşa Cad. No:78', 'Fatih',
     41.0192, 28.9497, TRUE, '20:00:00', '08:00:00', 'demo', 'demo-004', NOW(), NOW()),

    ('Üsküdar Meydan Eczanesi', '0216 341 56 78', 'Hakimiyet-i Milliye Cad. No:9', 'Üsküdar',
     41.0226, 29.0159, TRUE, '20:00:00', '08:00:00', 'demo', 'demo-005', NOW(), NOW()),

    ('Bakırköy Özgürlük Eczanesi', '0212 543 89 01', 'Özgürlük Meydanı No:3', 'Bakırköy',
     40.9819, 28.8772, FALSE, '08:30:00', '19:00:00', 'demo', 'demo-006', NOW(), NOW()),

    ('Beyoğlu İstiklal Eczanesi', '0212 292 34 56', 'İstiklal Cad. No:121', 'Beyoğlu',
     41.0370, 28.9772, FALSE, '08:30:00', '19:00:00', 'demo', 'demo-007', NOW(), NOW()),

    ('Maltepe Sahil Eczanesi', '0216 442 67 89', 'Bağdat Cad. No:210', 'Maltepe',
     40.9354, 29.1553, FALSE, '08:30:00', '19:00:00', 'demo', 'demo-008', NOW(), NOW()),

    ('Ataşehir Bulvar Eczanesi', '0216 456 90 12', 'Atatürk Bulvarı No:45', 'Ataşehir',
     40.9923, 29.1244, FALSE, '08:30:00', '19:00:00', 'demo', 'demo-009', NOW(), NOW()),

    ('Kartal Merkez Eczanesi', '0216 389 01 23', 'Ankara Cad. No:67', 'Kartal',
     40.9052, 29.1878, FALSE, '08:30:00', '19:00:00', 'demo', 'demo-010', NOW(), NOW());
