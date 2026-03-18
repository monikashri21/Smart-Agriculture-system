USE agriculture_db;

CREATE TABLE IF NOT EXISTS states (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS districts (
    district_id INT AUTO_INCREMENT PRIMARY KEY,
    state_id INT,
    district_name VARCHAR(100),
    FOREIGN KEY (state_id) REFERENCES states(state_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS soil_types (
    soil_id INT AUTO_INCREMENT PRIMARY KEY,
    soil_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS climates (
    climate_id INT AUTO_INCREMENT PRIMARY KEY,
    climate_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS seasons (
    season_id INT AUTO_INCREMENT PRIMARY KEY,
    season_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS crops (
    crop_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(100),
    growth_time_months INT,
    cost_per_acre DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS crop_requirements (
    req_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_id INT,
    soil_id INT,
    season_id INT,
    climate_id INT,
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE,
    FOREIGN KEY (soil_id) REFERENCES soil_types(soil_id) ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES seasons(season_id) ON DELETE CASCADE,
    FOREIGN KEY (climate_id) REFERENCES climates(climate_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS state_crops (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state_id INT,
    crop_id INT,
    FOREIGN KEY (state_id) REFERENCES states(state_id) ON DELETE CASCADE,
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS crop_yield (
    yield_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(100),
    yield_per_acre DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS fertilizers (
    fertilizer_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_id INT,
    nitrogen_req INT,
    phosphorus_req INT,
    potassium_req INT,
    recommended_fertilizer VARCHAR(200),
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS market_prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_id INT,
    market_name VARCHAR(100),
    current_price_per_quintal DECIMAL(10, 2),
    last_updated DATE,
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS farmer_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_name VARCHAR(100),
    age INT,
    state_id INT,
    district_id INT,
    soil_id INT,
    climate_id INT,
    season_id INT,
    land_area DECIMAL(10, 2),
    investment_budget DECIMAL(10, 2),
    preferred_crop VARCHAR(100),
    preferred_language VARCHAR(20),
    phone_number VARCHAR(15),
    FOREIGN KEY (state_id) REFERENCES states(state_id) ON DELETE SET NULL,
    FOREIGN KEY (district_id) REFERENCES districts(district_id) ON DELETE SET NULL,
    FOREIGN KEY (soil_id) REFERENCES soil_types(soil_id) ON DELETE SET NULL,
    FOREIGN KEY (climate_id) REFERENCES climates(climate_id) ON DELETE SET NULL,
    FOREIGN KEY (season_id) REFERENCES seasons(season_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS schemes (
    scheme_id INT AUTO_INCREMENT PRIMARY KEY,
    scheme_name VARCHAR(200),
    description TEXT,
    eligibility TEXT,
    link VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS recycling_companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(150),
    contact_number VARCHAR(20),
    address TEXT,
    accepted_waste_types VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS crop_recycling (
    recycling_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_id INT,
    tip_text TEXT,
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE
);

-- Dummy Data Insertions
INSERT IGNORE INTO states (state_id, state_name) VALUES 
(1, 'Andhra Pradesh'), (2, 'Maharashtra'), (3, 'Punjab'), (4, 'Tamil Nadu'), (5, 'Karnataka'), (6, 'Gujarat'), (7, 'Uttar Pradesh'), (8, 'Rajasthan');

INSERT IGNORE INTO districts (district_id, state_id, district_name) VALUES 
(1, 1, 'Guntur'), (2, 2, 'Pune'), (3, 3, 'Ludhiana'),
(4, 4, 'Coimbatore'), (5, 4, 'Madurai'), (6, 5, 'Belagavi'), (7, 6, 'Ahmedabad'), (8, 7, 'Lucknow'), (9, 8, 'Jaipur');

INSERT IGNORE INTO soil_types (soil_id, soil_name) VALUES 
(1, 'Alluvial'), (2, 'Black'), (3, 'Red'), (4, 'Lateirte'), (5, 'Desert');

INSERT IGNORE INTO climates (climate_id, climate_name) VALUES 
(1, 'Tropical'), (2, 'Dry'), (3, 'Temperate'), (4, 'Arid'), (5, 'Humid');

INSERT IGNORE INTO seasons (season_id, season_name) VALUES 
(1, 'Kharif'), (2, 'Rabi'), (3, 'Summer');

INSERT IGNORE INTO crops (crop_id, crop_name, growth_time_months, cost_per_acre) VALUES 
(1, 'Rice', 4, 15000), 
(2, 'Wheat', 5, 12000), 
(3, 'Cotton', 6, 20000),
(4, 'Tobacco', 5, 30000),
(5, 'Chillies', 6, 18000),
(6, 'Ginger', 8, 25000),
(7, 'Mustard', 4, 10000),
(8, 'Maize', 4, 12000),
(9, 'Tea', 36, 50000),
(10, 'Jute', 4, 8000),
(11, 'Sugarcane', 12, 35000),
(12, 'Litchi', 36, 40000),
(13, 'Pulses', 3, 8000),
(14, 'Linseed', 4, 9000),
(15, 'Cashew', 36, 30000),
(16, 'Coconut', 60, 25000),
(17, 'Areca nut', 48, 28000),
(18, 'Groundnut', 4, 14000),
(19, 'Cumin', 4, 12000),
(20, 'Apple', 48, 60000),
(21, 'Potato', 3, 15000),
(22, 'Saffron', 6, 150000),
(23, 'Walnut', 60, 35000),
(24, 'Tomato', 4, 18000),
(25, 'Coffee', 36, 45000),
(26, 'Ragi', 4, 8000),
(27, 'Sunflower', 4, 10000),
(28, 'Rubber', 72, 40000),
(29, 'Pepper', 36, 35000),
(30, 'Soybean', 4, 12000),
(31, 'Gram', 4, 9000),
(32, 'Grapes', 12, 80000),
(33, 'Pineapple', 18, 20000),
(34, 'Turmeric', 9, 22000),
(35, 'Bajra', 3, 6000),
(36, 'Guar', 3, 7000),
(37, 'Cardamom', 36, 50000),
(38, 'Oranges', 36, 30000),
(39, 'Banana', 12, 25000),
(40, 'Mango', 48, 35000),
(41, 'Jackfruit', 48, 15000),
(42, 'Basmati Rice', 5, 20000),
(43, 'Off-season Veg', 3, 22000);

-- Link crops to states
INSERT IGNORE INTO state_crops (state_id, crop_id) VALUES (1, 1), (3, 2), (2, 3);

-- Link crops to requirements
INSERT IGNORE INTO crop_requirements (crop_id, soil_id, season_id, climate_id) VALUES 
(1, 1, 1, 1), (2, 1, 2, 3), (3, 2, 1, 2);

INSERT IGNORE INTO crop_yield (crop_name, yield_per_acre) VALUES ('Rice', 20.0), ('Wheat', 15.0), ('Cotton', 10.0);

INSERT IGNORE INTO fertilizers (crop_id, nitrogen_req, phosphorus_req, potassium_req, recommended_fertilizer) VALUES 
(1, 120, 60, 40, 'Urea, DAP, MOP'),
(2, 100, 50, 40, 'Urea, SSP'),
(3, 150, 75, 50, 'NPK 19:19:19');

-- Fertilizer Recommendations (Organic + Chemical with Cost)
CREATE TABLE IF NOT EXISTS fertilizer_recommendations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    crop_id INT,
    fertilizer_name VARCHAR(150),
    type ENUM('organic', 'chemical') NOT NULL,
    npk_ratio VARCHAR(50),
    dosage_per_acre VARCHAR(100),
    cost_per_acre DECIMAL(10, 2),
    effectiveness_score INT CHECK (effectiveness_score BETWEEN 1 AND 10),
    notes TEXT,
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id) ON DELETE CASCADE
);

-- ============ FERTILIZER DATA FOR ALL CROPS ============

-- 1. Rice
INSERT IGNORE INTO fertilizer_recommendations (id, crop_id, fertilizer_name, type, npk_ratio, dosage_per_acre, cost_per_acre, effectiveness_score, notes) VALUES
(1,  1, 'Green Manure (Dhaincha)', 'organic', '3-0.5-2', 'Grow & plough in', 800.00, 8, 'Sow 45 days before transplanting and plough in. Cheapest organic option.'),
(2,  1, 'Vermicompost',        'organic',  '2-1-1',    '2 tonnes',   3500.00, 7, 'Apply as basal dose. Improves soil structure and water retention.'),
(3,  1, 'Urea (46-0-0)',       'chemical', '46-0-0',   '50 kg',      1400.00, 9, 'Apply in 3 splits: basal, tillering, and panicle initiation.'),
(4,  1, 'DAP (18-46-0)',       'chemical', '18-46-0',  '25 kg',      1750.00, 8, 'Basal dose for quick phosphorus and root development.'),

-- 2. Wheat
(5,  2, 'Compost (Decomposed)', 'organic', '1-0.5-1',  '3 tonnes',  1500.00, 8, 'Budget-friendly. Apply as basal. Enhances soil microbes.'),
(6,  2, 'Farmyard Manure',     'organic',  '0.5-0.3-0.5','5 tonnes', 4000.00, 7, 'Apply 2-3 weeks before sowing for soil fertility.'),
(7,  2, 'Urea (46-0-0)',       'chemical', '46-0-0',   '65 kg',     1820.00, 9, 'Apply in 2 splits: half at sowing, half at first irrigation.'),
(8,  2, 'SSP (0-16-0)',        'chemical', '0-16-0',   '50 kg',      600.00, 7, 'Cheapest phosphorus source. Apply full dose as basal.'),

-- 3. Cotton
(9,  3, 'Bio-NPK Consortium',  'organic',  'Variable', '5 kg',      1200.00, 8, 'Seed treatment + soil application. Contains Azotobacter, PSB, KSB.'),
(10, 3, 'Castor Cake',         'organic',  '5-2-1',    '300 kg',    5400.00, 7, 'Slow-release nitrogen ideal for long-duration cotton.'),
(11, 3, 'NPK 19:19:19',        'chemical', '19-19-19', '50 kg',     2500.00, 9, 'Balanced nutrition at square formation and flowering.'),
(12, 3, 'DAP (18-46-0)',       'chemical', '18-46-0',  '50 kg',     3500.00, 8, 'Basal dose for strong root establishment.'),

-- 4. Tobacco
(13, 4, 'Neem Cake',           'organic',  '5-1-2',    '250 kg',    3500.00, 7, 'Controls nematodes and provides slow-release nitrogen.'),
(14, 4, 'Vermicompost',        'organic',  '2-1-1',    '2 tonnes',  3500.00, 7, 'Improves leaf quality and soil health.'),
(15, 4, 'Calcium Ammonium Nitrate', 'chemical', '26-0-0', '60 kg',  1800.00, 8, 'Preferred over Urea for tobacco. Better leaf burn quality.'),
(16, 4, 'SSP (0-16-0)',        'chemical', '0-16-0',   '50 kg',      600.00, 7, 'Supplies phosphorus without excess nitrogen.'),

-- 5. Chillies
(17, 5, 'Farmyard Manure',     'organic',  '0.5-0.3-0.5','4 tonnes', 3200.00, 7, 'Apply 3 weeks before transplanting for rich organic matter.'),
(18, 5, 'Neem Cake',           'organic',  '5-1-2',    '200 kg',    2800.00, 8, 'Natural pest repellent. Controls soil-borne pests.'),
(19, 5, 'NPK 19:19:19',        'chemical', '19-19-19', '40 kg',     2000.00, 9, 'Apply at flowering for best fruit development.'),
(20, 5, 'Calcium Nitrate',     'chemical', '15-0-0+Ca','25 kg',     1200.00, 7, 'Prevents blossom end rot. Apply at fruiting stage.'),

-- 6. Ginger
(21, 6, 'Vermicompost',        'organic',  '2-1-1',    '3 tonnes',  5250.00, 8, 'Essential for ginger. Improves rhizome size and quality.'),
(22, 6, 'Neem Cake',           'organic',  '5-1-2',    '300 kg',    4200.00, 7, 'Controls rhizome rot. Apply at planting.'),
(23, 6, 'Urea (46-0-0)',       'chemical', '46-0-0',   '45 kg',     1260.00, 8, 'Apply in splits at 45, 90, and 120 days after planting.'),
(24, 6, 'MOP (0-0-60)',        'chemical', '0-0-60',   '40 kg',     1700.00, 8, 'Essential potassium for rhizome bulking.'),

-- 7. Mustard
(25, 7, 'Compost (Decomposed)', 'organic', '1-0.5-1',  '2 tonnes',  1000.00, 7, 'Apply before sowing. Budget-friendly organic option.'),
(26, 7, 'Farmyard Manure',     'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Improves soil structure for better root penetration.'),
(27, 7, 'DAP (18-46-0)',       'chemical', '18-46-0',  '25 kg',     1750.00, 8, 'Apply at sowing for phosphorus boost.'),
(28, 7, 'Sulphur (90%)',       'chemical', '0-0-0+S',  '10 kg',      500.00, 9, 'Critical for mustard oil content. Most cost-effective chemical.'),

-- 8. Maize
(29, 8, 'Green Manure (Dhaincha)', 'organic','3-0.5-2', 'Grow & plough in', 800.00, 8, 'Cheapest option. Plough in 30 days before sowing.'),
(30, 8, 'Vermicompost',        'organic',  '2-1-1',    '2 tonnes',  3500.00, 7, 'Good nitrogen source for heavy feeder like maize.'),
(31, 8, 'Urea (46-0-0)',       'chemical', '46-0-0',   '55 kg',     1540.00, 9, 'Apply in 3 splits for maximum grain fill.'),
(32, 8, 'DAP (18-46-0)',       'chemical', '18-46-0',  '30 kg',     2100.00, 8, 'Basal application for early root establishment.'),

-- 9. Tea
(33, 9, 'Neem Cake',           'organic',  '5-1-2',    '400 kg',    5600.00, 8, 'Slow-release N. Controls tea mosquito bug naturally.'),
(34, 9, 'Compost (Tea Waste)', 'organic',  '1.5-0.5-1','3 tonnes',  1800.00, 7, 'Recycled tea waste compost. Very budget-friendly.'),
(35, 9, 'Ammonium Sulphate',   'chemical', '21-0-0+S', '80 kg',     2400.00, 9, 'Best chemical for tea. Acidifies soil as tea prefers.'),
(36, 9, 'MOP (0-0-60)',        'chemical', '0-0-60',   '30 kg',     1275.00, 7, 'Improves drought resistance and leaf quality.'),

-- 10. Jute
(37, 10, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','4 tonnes', 3200.00, 7, 'Apply before sowing. Improves fibre quality.'),
(38, 10, 'Green Manure (Sunnhemp)','organic','3-0.5-2', 'Grow & plough in', 700.00, 8, 'Cheapest option. Fixes nitrogen naturally.'),
(39, 10, 'Urea (46-0-0)',      'chemical', '46-0-0',   '40 kg',     1120.00, 8, 'Apply at 30 and 60 days after sowing.'),
(40, 10, 'SSP (0-16-0)',       'chemical', '0-16-0',   '30 kg',      360.00, 7, 'Low-cost phosphorus for fibre crops.'),

-- 11. Sugarcane
(41, 11, 'Press Mud Compost',  'organic',  '1.5-2-0.5','5 tonnes',  2000.00, 9, 'By-product of sugar mills. Best organic for sugarcane.'),
(42, 11, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','10 tonnes', 8000.00, 7, 'Heavy dose needed. Apply in furrows before planting.'),
(43, 11, 'Urea (46-0-0)',      'chemical', '46-0-0',   '130 kg',    3640.00, 9, 'Apply in 3 splits for extended growth period.'),
(44, 11, 'MOP (0-0-60)',       'chemical', '0-0-60',   '50 kg',     2125.00, 8, 'Essential for sugar content. Apply at earthing up.'),

-- 12. Litchi
(45, 12, 'Vermicompost',       'organic',  '2-1-1',    '5 kg/tree', 1500.00, 8, 'Apply in basin around tree. Improves fruit sweetness.'),
(46, 12, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','20 kg/tree',2000.00, 7, 'Annual application. Mix with soil around drip line.'),
(47, 12, 'NPK 10:26:26',       'chemical', '10-26-26', '500 g/tree', 800.00, 8, 'Apply after harvest for next season flower initiation.'),
(48, 12, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '50 g/tree',  200.00, 7, 'Foliar spray prevents fruit cracking.'),

-- 13. Pulses (General)
(49, 13, 'Rhizobium Culture',  'organic',  'N-fixing', '200 g/10kg seed', 50.00, 9, 'Seed inoculant. Fixes atmospheric nitrogen. Cheapest option.'),
(50, 13, 'Compost (Decomposed)','organic', '1-0.5-1',  '2 tonnes',  1000.00, 7, 'Apply before sowing. Pulses need less nitrogen.'),
(51, 13, 'SSP (0-16-0)',       'chemical', '0-16-0',   '40 kg',      480.00, 8, 'Phosphorus critical for nodulation and nitrogen fixation.'),
(52, 13, 'DAP (18-46-0)',      'chemical', '18-46-0',  '20 kg',     1400.00, 7, 'Starter dose only. Pulses fix their own nitrogen.'),

-- 14. Linseed
(53, 14, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Apply 2 weeks before sowing for soil conditioning.'),
(54, 14, 'Vermicompost',       'organic',  '2-1-1',    '1.5 tonnes', 2625.00, 7, 'Improves seed oil content.'),
(55, 14, 'DAP (18-46-0)',      'chemical', '18-46-0',  '25 kg',     1750.00, 8, 'Apply at sowing. Phosphorus boosts oil formation.'),
(56, 14, 'Urea (46-0-0)',      'chemical', '46-0-0',   '20 kg',      560.00, 7, 'Light nitrogen dose at vegetative stage.'),

-- 15. Cashew
(57, 15, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 8, 'Annual basin application. Improves nut quality.'),
(58, 15, 'Neem Cake',          'organic',  '5-1-2',    '5 kg/tree',  2100.00, 7, 'Protects against root grubs and stem borers.'),
(59, 15, 'NPK 10:26:26',       'chemical', '10-26-26', '750 g/tree', 1200.00, 8, 'Apply before flowering for better fruit set.'),
(60, 15, 'Borax',              'chemical', '0-0-0+B',  '50 g/tree',   150.00, 7, 'Prevents flower drop. Very cost-effective.'),

-- 16. Coconut
(61, 16, 'Coir Pith Compost',  'organic',  '0.5-0.2-1','25 kg/tree', 1500.00, 8, 'From coconut husk. Retains moisture around basin.'),
(62, 16, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 7, 'Annual application in basin with mulching.'),
(63, 16, 'MOP (0-0-60)',       'chemical', '0-0-60',   '1 kg/tree',   850.00, 9, 'Coconut is potassium-hungry. Most effective chemical.'),
(64, 16, 'Urea (46-0-0)',      'chemical', '46-0-0',   '500 g/tree',  400.00, 7, 'Apply in splits during pre-monsoon and post-monsoon.'),

-- 17. Areca nut
(65, 17, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 8, 'Basin application. Improves nut size.'),
(66, 17, 'Green Leaf Manure',  'organic',  'Variable', '15 kg/tree',  500.00, 7, 'Gliricidia leaves buried in basin. Cheapest option.'),
(67, 17, 'NPK 19:19:19',       'chemical', '19-19-19', '500 g/tree',  500.00, 8, 'Balanced feed applied quarterly.'),
(68, 17, 'Borax',              'chemical', '0-0-0+B',  '25 g/tree',    75.00, 7, 'Prevents crown choke disease.'),

-- 18. Groundnut
(69, 18, 'Gypsum',             'organic',  '0-0-0+Ca+S','200 kg',   1600.00, 9, 'Critical for pod filling. Apply at pegging stage.'),
(70, 18, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Apply before sowing for soil conditioning.'),
(71, 18, 'SSP (0-16-0)',       'chemical', '0-16-0',   '50 kg',      600.00, 8, 'Supplies both phosphorus and sulphur for groundnut.'),
(72, 18, 'DAP (18-46-0)',      'chemical', '18-46-0',  '25 kg',     1750.00, 7, 'Basal application for root development.'),

-- 19. Cumin
(73, 19, 'Compost (Decomposed)','organic', '1-0.5-1',  '2 tonnes',  1000.00, 7, 'Apply before sowing. Light organic is sufficient.'),
(74, 19, 'Vermicompost',       'organic',  '2-1-1',    '1 tonne',   1750.00, 8, 'Improves essential oil content in seeds.'),
(75, 19, 'DAP (18-46-0)',      'chemical', '18-46-0',  '20 kg',     1400.00, 8, 'Phosphorus critical for seed formation.'),
(76, 19, 'Sulphur (90%)',      'chemical', '0-0-0+S',  '8 kg',       400.00, 9, 'Enhances aroma. Most cost-effective chemical.'),

-- 20. Apple
(77, 20, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','30 kg/tree', 3000.00, 8, 'Annual winter application in basin.'),
(78, 20, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 7, 'Spring application for flower and fruit development.'),
(79, 20, 'Calcium Ammonium Nitrate','chemical','26-0-0','500 g/tree', 600.00, 8, 'Apply in spring. Better than Urea for fruit trees.'),
(80, 20, 'MOP (0-0-60)',       'chemical', '0-0-60',   '500 g/tree',  425.00, 8, 'Improves fruit colour, size, and storage quality.'),

-- 21. Potato
(81, 21, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','5 tonnes', 4000.00, 7, 'Apply 3 weeks before planting. Improves tuber count.'),
(82, 21, 'Vermicompost',       'organic',  '2-1-1',    '2 tonnes',  3500.00, 8, 'Enhances tuber size and soil biology.'),
(83, 21, 'NPK 12:32:16',       'chemical', '12-32-16', '50 kg',     2200.00, 9, 'Best balanced fertilizer for potato. Apply at planting.'),
(84, 21, 'MOP (0-0-60)',       'chemical', '0-0-60',   '40 kg',     1700.00, 8, 'Potassium is critical for starch content in tubers.'),

-- 22. Saffron
(85, 22, 'Vermicompost',       'organic',  '2-1-1',    '3 tonnes',  5250.00, 8, 'Apply before corm planting. Improves flower count.'),
(86, 22, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','8 tonnes', 6400.00, 7, 'Heavy dose needed for 3-year corm cycle.'),
(87, 22, 'DAP (18-46-0)',      'chemical', '18-46-0',  '15 kg',     1050.00, 8, 'Apply at planting for corm establishment.'),
(88, 22, 'Potassium Sulphate', 'chemical', '0-0-50+S', '20 kg',     1600.00, 9, 'Better than MOP for saffron. Avoids chloride damage.'),

-- 23. Walnut
(89, 23, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','40 kg/tree', 4000.00, 7, 'Annual winter application. Essential for deep-rooted trees.'),
(90, 23, 'Vermicompost',       'organic',  '2-1-1',    '15 kg/tree', 4500.00, 8, 'Apply in spring for nut development.'),
(91, 23, 'Calcium Ammonium Nitrate','chemical','26-0-0','750 g/tree', 900.00, 8, 'Spring application for canopy growth.'),
(92, 23, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '100 g/tree',  300.00, 7, 'Foliar spray. Prevents rosetting of leaves.'),

-- 24. Tomato
(93, 24, 'Vermicompost',       'organic',  '2-1-1',    '3 tonnes',  5250.00, 8, 'Apply before transplanting. Improves fruit quality.'),
(94, 24, 'Neem Cake',          'organic',  '5-1-2',    '200 kg',    2800.00, 7, 'Controls nematodes and provides nitrogen.'),
(95, 24, 'NPK 19:19:19',       'chemical', '19-19-19', '50 kg',     2500.00, 9, 'Apply at flowering and fruiting. Best results.'),
(96, 24, 'Calcium Nitrate',    'chemical', '15-0-0+Ca','30 kg',     1800.00, 8, 'Prevents blossom end rot in tomato fruits.'),

-- 25. Coffee
(97, 25, 'Compost (Coffee Pulp)','organic','1.5-0.5-2','5 tonnes',  2500.00, 8, 'Recycled coffee pulp. Best organic for coffee.'),
(98, 25, 'Neem Cake',          'organic',  '5-1-2',    '500 kg',    7000.00, 7, 'Controls white stem borer naturally.'),
(99, 25, 'Urea (46-0-0)',      'chemical', '46-0-0',   '60 kg/acre', 1680.00, 8, 'Apply during monsoon for shoot growth.'),
(100,25, 'MOP (0-0-60)',       'chemical', '0-0-60',   '50 kg',     2125.00, 8, 'Improves bean quality and disease resistance.'),

-- 26. Ragi (Finger Millet)
(101,26, 'Compost (Decomposed)','organic', '1-0.5-1',  '2 tonnes',  1000.00, 8, 'Light organic is sufficient. Ragi is drought-tolerant.'),
(102,26, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Apply before sowing. Improves calcium in grain.'),
(103,26, 'DAP (18-46-0)',      'chemical', '18-46-0',  '20 kg',     1400.00, 8, 'Apply at sowing for strong tillering.'),
(104,26, 'Urea (46-0-0)',      'chemical', '46-0-0',   '25 kg',      700.00, 7, 'Top dress at 30 days. Low dose sufficient.'),

-- 27. Sunflower
(105,27, 'Vermicompost',       'organic',  '2-1-1',    '2 tonnes',  3500.00, 7, 'Improves seed oil content.'),
(106,27, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Apply before sowing for organic matter.'),
(107,27, 'Borax',              'chemical', '0-0-0+B',  '5 kg',       250.00, 9, 'Critical for seed set. Most cost-effective chemical input.'),
(108,27, 'DAP (18-46-0)',      'chemical', '18-46-0',  '30 kg',     2100.00, 8, 'Apply at sowing for early vigour.'),

-- 28. Rubber
(109,28, 'Rock Phosphate',     'organic',  '0-20-0',   '500 g/tree',  400.00, 8, 'Slow-release phosphorus for perennial crop.'),
(110,28, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 7, 'Annual basin application for latex yield.'),
(111,28, 'NPK 10:10:10',       'chemical', '10-10-10', '750 g/tree',  600.00, 8, 'Balanced feed for mature trees.'),
(112,28, 'Magnesium Sulphate', 'chemical', '0-0-0+Mg', '250 g/tree',  200.00, 7, 'Prevents yellowing of rubber leaves.'),

-- 29. Pepper (Black Pepper)
(113,29, 'Neem Cake',          'organic',  '5-1-2',    '5 kg/vine',  2100.00, 8, 'Controls foot rot disease naturally.'),
(114,29, 'Vermicompost',       'organic',  '2-1-1',    '5 kg/vine',  1500.00, 7, 'Annual application at vine base.'),
(115,29, 'NPK 19:19:19',       'chemical', '19-19-19', '200 g/vine',  500.00, 8, 'Apply at onset of monsoon for spike development.'),
(116,29, 'MOP (0-0-60)',       'chemical', '0-0-60',   '150 g/vine',  300.00, 8, 'Potassium essential for piperine content.'),

-- 30. Soybean
(117,30, 'Rhizobium Culture',  'organic',  'N-fixing', '200 g/10kg seed', 50.00, 9, 'Seed inoculant. Fixes nitrogen. Best value for soybean.'),
(118,30, 'Vermicompost',       'organic',  '2-1-1',    '2 tonnes',  3500.00, 7, 'Supplementary organic matter for soil health.'),
(119,30, 'SSP (0-16-0)',       'chemical', '0-16-0',   '50 kg',      600.00, 8, 'Phosphorus critical for nodulation.'),
(120,30, 'Sulphur (90%)',      'chemical', '0-0-0+S',  '10 kg',      500.00, 8, 'Improves protein and oil content in seeds.'),

-- 31. Gram (Chickpea)
(121,31, 'Rhizobium Culture',  'organic',  'N-fixing', '200 g/10kg seed', 50.00, 9, 'Essential for legume nitrogen fixation. Cheapest input.'),
(122,31, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','2 tonnes', 1600.00, 7, 'Light dose before sowing for soil conditioning.'),
(123,31, 'DAP (18-46-0)',      'chemical', '18-46-0',  '20 kg',     1400.00, 8, 'Starter dose for root and nodule development.'),
(124,31, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '10 kg',      450.00, 7, 'Micronutrient for better pod filling.'),

-- 32. Grapes
(125,32, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','10 kg/vine', 4000.00, 7, 'Annual post-harvest application.'),
(126,32, 'Vermicompost',       'organic',  '2-1-1',    '5 kg/vine',  1500.00, 8, 'Improves sugar content (Brix) in berries.'),
(127,32, 'Potassium Sulphate', 'chemical', '0-0-50+S', '500 g/vine', 2000.00, 9, 'Superior to MOP for grapes. Improves colour & taste.'),
(128,32, 'NPK 13:0:45',        'chemical', '13-0-45',  '300 g/vine', 1200.00, 8, 'Apply at veraison for berry ripening.'),

-- 33. Pineapple
(129,33, 'Compost (Decomposed)','organic', '1-0.5-1',  '3 tonnes',  1500.00, 7, 'Apply in planting pits. Pineapple is acid-loving.'),
(130,33, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','5 tonnes', 4000.00, 7, 'Improves soil organic matter for long crop duration.'),
(131,33, 'Urea (46-0-0)',      'chemical', '46-0-0',   '50 kg',     1400.00, 8, 'Apply in 4 splits over 12 months cropping.'),
(132,33, 'MOP (0-0-60)',       'chemical', '0-0-60',   '60 kg',     2550.00, 9, 'Higher potassium critical for fruit sweetness.'),

-- 34. Turmeric
(133,34, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','5 tonnes', 4000.00, 7, 'Apply in ridges before planting.'),
(134,34, 'Neem Cake',          'organic',  '5-1-2',    '300 kg',    4200.00, 8, 'Controls rhizome rot. Improves curcumin content.'),
(135,34, 'Urea (46-0-0)',      'chemical', '46-0-0',   '50 kg',     1400.00, 8, 'Apply in 3 splits at 30, 60, and 90 days.'),
(136,34, 'MOP (0-0-60)',       'chemical', '0-0-60',   '30 kg',     1275.00, 8, 'Potassium essential for rhizome yield.'),

-- 35. Bajra (Pearl Millet)
(137,35, 'Compost (Decomposed)','organic', '1-0.5-1',  '2 tonnes',  1000.00, 8, 'Sufficient for rain-fed bajra. Budget-friendly.'),
(138,35, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','3 tonnes', 2400.00, 7, 'Apply before sowing in arid soils.'),
(139,35, 'DAP (18-46-0)',      'chemical', '18-46-0',  '20 kg',     1400.00, 8, 'Apply at sowing for drought-tolerant growth.'),
(140,35, 'Urea (46-0-0)',      'chemical', '46-0-0',   '20 kg',      560.00, 7, 'Light top-dress at 25 days.'),

-- 36. Guar
(141,36, 'Rhizobium Culture',  'organic',  'N-fixing', '200 g/10kg seed', 50.00, 9, 'Legume crop. Fixes its own nitrogen.'),
(142,36, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','2 tonnes', 1600.00, 7, 'Light organic. Guar needs minimal inputs.'),
(143,36, 'SSP (0-16-0)',       'chemical', '0-16-0',   '30 kg',      360.00, 8, 'Phosphorus for better gum content.'),
(144,36, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '5 kg',       225.00, 7, 'Micronutrient for desert soils.'),

-- 37. Cardamom
(145,37, 'Vermicompost',       'organic',  '2-1-1',    '5 kg/clump', 2500.00, 8, 'Apply in basins during pre-monsoon.'),
(146,37, 'Neem Cake',          'organic',  '5-1-2',    '2 kg/clump', 1400.00, 7, 'Natural pest control for cardamom thrips.'),
(147,37, 'NPK 19:19:19',       'chemical', '19-19-19', '300 g/clump', 750.00, 9, 'Apply after first harvest for next season.'),
(148,37, 'MOP (0-0-60)',       'chemical', '0-0-60',   '200 g/clump', 400.00, 8, 'Potassium improves capsule size and aroma.'),

-- 38. Oranges (Citrus)
(149,38, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','25 kg/tree', 2500.00, 7, 'Annual post-harvest application in tree basin.'),
(150,38, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 8, 'Improves juice content and fruit sweetness.'),
(151,38, 'NPK 12:32:16',       'chemical', '12-32-16', '500 g/tree', 1000.00, 8, 'Apply before flowering for fruit set.'),
(152,38, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '100 g/tree',  300.00, 8, 'Foliar spray. Prevents citrus dieback.'),

-- 39. Banana
(153,39, 'Vermicompost',       'organic',  '2-1-1',    '5 kg/plant', 2500.00, 8, 'Apply in planting pit. Improves bunch weight.'),
(154,39, 'Neem Cake',          'organic',  '5-1-2',    '2 kg/plant', 1400.00, 7, 'Controls nematodes in banana plantation.'),
(155,39, 'Urea (46-0-0)',      'chemical', '46-0-0',   '200 g/plant', 600.00, 8, 'Apply in 5 splits from 2nd to 6th month.'),
(156,39, 'MOP (0-0-60)',       'chemical', '0-0-60',   '300 g/plant', 900.00, 9, 'Critical for fruit size. Banana is potassium-hungry.'),

-- 40. Mango
(157,40, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','30 kg/tree', 3000.00, 7, 'Annual application in June-July.'),
(158,40, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 8, 'Improves fruit quality and shelf life.'),
(159,40, 'NPK 10:26:26',       'chemical', '10-26-26', '1 kg/tree',  1600.00, 8, 'Apply in September for flower initiation.'),
(160,40, 'Borax',              'chemical', '0-0-0+B',  '100 g/tree',  300.00, 8, 'Prevents internal necrosis (spongy tissue).'),

-- 41. Jackfruit
(161,41, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','25 kg/tree', 2500.00, 7, 'Annual monsoon application. Jackfruit is hardy.'),
(162,41, 'Vermicompost',       'organic',  '2-1-1',    '10 kg/tree', 3000.00, 8, 'Improves fruit count and size.'),
(163,41, 'NPK 19:19:19',       'chemical', '19-19-19', '500 g/tree',  500.00, 8, 'Apply before flowering season.'),
(164,41, 'Urea (46-0-0)',      'chemical', '46-0-0',   '300 g/tree',  250.00, 7, 'Spring application for canopy growth.'),

-- 42. Basmati Rice
(165,42, 'Green Manure (Dhaincha)', 'organic','3-0.5-2','Grow & plough in', 800.00, 8, 'Same as rice. Plough in 45 days before transplanting.'),
(166,42, 'Vermicompost',       'organic',  '2-1-1',    '2 tonnes',  3500.00, 8, 'Improves grain aroma — critical for basmati.'),
(167,42, 'Urea (46-0-0)',      'chemical', '46-0-0',   '40 kg',     1120.00, 8, 'Lower dose than regular rice to preserve grain length.'),
(168,42, 'Zinc Sulphate',      'chemical', '0-0-0+Zn', '10 kg',      450.00, 9, 'Critical for basmati. Improves grain elongation ratio.'),

-- 43. Off-season Veg
(169,43, 'Vermicompost',       'organic',  '2-1-1',    '3 tonnes',  5250.00, 9, 'Critical for success in off-season vegetables. Improves temperature buffering.'),
(170,43, 'Farmyard Manure',    'organic',  '0.5-0.3-0.5','5 tonnes', 4000.00, 8, 'Apply well in advance. Increases soil organic matter.'),
(171,43, 'NPK 19:19:19',       'chemical', '19-19-19', '50 kg',     2500.00, 9, 'Balanced nutrition for quick growth in off-season.'),
(172,43, 'Micronutrient Mix',  'chemical', 'Multi',    '5 kg',       800.00, 8, 'Ensures no deficiency during rapid growth phases.');

INSERT IGNORE INTO market_prices (crop_id, market_name, current_price_per_quintal, last_updated) VALUES 
(1, 'Guntur Market', 2500.00, CURDATE()),
(2, 'Ludhiana Market', 2200.00, CURDATE()),
(3, 'Pune Market', 6000.00, CURDATE());

INSERT IGNORE INTO schemes (scheme_id, scheme_name, description, eligibility, link) VALUES 
(1, 'PM-KISAN', 'Financial benefit of ₹6000 per year', 'All landholding farmers', 'https://pmkisan.gov.in/'),
(2, 'Kisan Credit Card', 'Short term credit limits', 'All farmers', 'https://www.india.gov.in/'),
(3, 'PMFBY (Fasal Bima)', 'Crop insurance against natural calamities', 'All farmers including sharecroppers', 'https://pmfby.gov.in/'),
(4, 'PMKSY (Krishi Sinchayee)', 'Per Drop More Crop - irrigation subsidies', 'Farmers with own land', 'https://pmksy.gov.in/'),
(5, 'PKVY (Paramparagat Krishi)', 'Financial assistance for organic farming', 'Groups of 20+ farmers', 'https://pgsindia-ncof.dacnet.nic.in/'),
(6, 'Soil Health Card', 'Soil nutrient report once in 2 years', 'All farmers', 'https://www.soilhealth.dac.gov.in/'),
(7, 'e-NAM', 'Online trading portal for agriculture products', 'Registered farmers/traders', 'https://enam.gov.in/');

INSERT IGNORE INTO recycling_companies (company_id, company_name, contact_number, address, accepted_waste_types) VALUES 
(1, 'AgriWaste Solutions', '9876543210', 'Pune, Maharashtra', 'Cotton Stalks, Wheat Straw'),
(2, 'EcoFarms Tech', '9123456780', 'Guntur, AP', 'Rice Straw');

INSERT IGNORE INTO crop_recycling (crop_id, tip_text) VALUES 
(1, 'Rice straw can be used for mushroom cultivation.'),
(2, 'Wheat straw can be converted to biofuel.');
