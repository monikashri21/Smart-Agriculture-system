import mysql.connector
from models.db import DB_CONFIG

def populate_real_time_data():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    
    # Create table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS state_wise_recommendations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            state_name VARCHAR(100) UNIQUE,
            soil_type VARCHAR(200),
            suitable_crops VARCHAR(255),
            net_profit VARCHAR(100)
        )
    """)
    
    data = [
        ("Andhra Pradesh", "Red & Black", "Rice, Tobacco, Cotton, Chillies", "₹40,000 – ₹70,000"),
        ("Arunachal Pradesh", "Mountain / Forest", "Ginger, Mustard, Rice, Maize", "₹30,000 – ₹50,000"),
        ("Assam", "Alluvial", "Tea, Jute, Rice, Mustard", "₹50,000 – ₹90,000"),
        ("Bihar", "Alluvial", "Wheat, Sugarcane, Maize, Litchi", "₹40,000 – ₹65,000"),
        ("Chhattisgarh", "Red & Yellow", "Rice, Pulses, Linseed", "₹25,000 – ₹45,000"),
        ("Goa", "Laterite", "Cashew, Coconut, Areca nut", "₹60,000 – ₹1,00,000"),
        ("Gujarat", "Black & Alluvial", "Cotton, Groundnut, Cumin", "₹45,000 – ₹80,000"),
        ("Haryana", "Alluvial", "Wheat, Mustard, Sugarcane", "₹35,000 – ₹60,000"),
        ("Himachal Pradesh", "Mountain / Brown", "Apple, Potato, Off-season Veg", "₹1,50,000 – ₹3,50,000"),
        ("Jammu & Kashmir", "Mountain / Alluvial", "Saffron, Apple, Walnut", "₹2,00,000 – ₹5,00,000"),
        ("Jharkhand", "Red & Laterite", "Pulses, Potato, Tomato, Rice", "₹35,000 – ₹70,000"),
        ("Karnataka", "Red, Black, Laterite", "Coffee, Ragi, Sunflower", "₹55,000 – ₹95,000"),
        ("Kerala", "Laterite", "Rubber, Pepper, Coconut, Tea", "₹60,000 – ₹1,20,000"),
        ("Madhya Pradesh", "Black & Red-Yellow", "Soybean, Wheat, Gram (Pulses)", "₹30,000 – ₹55,000"),
        ("Maharashtra", "Black (Regur)", "Cotton, Sugarcane, Grapes", "₹50,000 – ₹1,50,000"),
        ("Manipur", "Red / Mountain", "Pineapple, Ginger, Turmeric", "₹80,000 – ₹1,50,000"),
        ("Meghalaya", "Laterite / Red", "Potato, Ginger, Turmeric", "₹90,000 – ₹1,80,000"),
        ("Mizoram", "Red / Loamy", "Ginger, Turmeric, Rice", "₹85,000 – ₹1,60,000"),
        ("Nagaland", "Mountain / Red", "Soybeans, Pineapple, Rice", "₹40,000 – ₹75,000"),
        ("Odisha", "Red & Alluvial", "Rice, Pulses, Jute, Coconut", "₹30,000 – ₹55,000"),
        ("Punjab", "Alluvial", "Wheat, Rice, Cotton, Sunflower", "₹40,000 – ₹65,000"),
        ("Rajasthan", "Arid / Desert", "Bajra, Mustard, Cumin, Guar", "₹15,000 – ₹40,000"),
        ("Sikkim", "Mountain", "Cardamom, Ginger, Oranges", "₹1,20,000 – ₹2,50,000"),
        ("Tamil Nadu", "Red & Alluvial", "Rice, Groundnut, Banana, Coconut", "₹45,000 – ₹90,000"),
        ("Telangana", "Red & Black", "Cotton, Turmeric, Maize", "₹40,000 – ₹85,000"),
        ("Tripura", "Red & Laterite", "Rubber, Pineapple, Jackfruit", "₹70,000 – ₹1,30,000"),
        ("Uttar Pradesh", "Alluvial", "Wheat, Sugarcane, Potato, Mango", "₹45,000 – ₹1,00,000"),
        ("Uttarakhand", "Mountain", "Basmati Rice, Apple, Soybean", "₹50,000 – ₹2,00,000"),
        ("West Bengal", "Alluvial & Laterite", "Rice, Jute, Tea, Potato", "₹40,000 – ₹80,000"),
    ]
    
    cursor.executemany("""
        INSERT INTO state_wise_recommendations (state_name, soil_type, suitable_crops, net_profit)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            soil_type = VALUES(soil_type),
            suitable_crops = VALUES(suitable_crops),
            net_profit = VALUES(net_profit)
    """, data)
    
    conn.commit()
    print("Populated state-wise recommendations successfully.")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    populate_real_time_data()
