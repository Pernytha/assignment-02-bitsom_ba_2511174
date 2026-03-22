// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
{
    product_id: "ELEC1001",
    name: "Smartphone",
    category: "Electronics",
    brand: "Samsung",
    price: 30000,
    specifications: {
    ram: "8GB",
    storage: "128GB",
    battery: "5000mAh"
    },
    features: ["5G", "Dual SIM"]
},
{
    product_id: "CLOT2001",
    name: "Men's Hoodie",
    category: "Clothing",
    brand: "Nike",
    price: 2500,
    sizes_available: ["S", "M", "L"],
    material: "Cotton",
    colors: ["Black", "Blue"]
},
{
    product_id: "GROC3001",
    name: "Milk",
    category: "Groceries",
    brand: "Amul",
    price: 60,
    expiry_date: ISODate("2024-12-20"),
    nutritional_info: {
    protein: "8g",
    fat: "5g"
    },
    ingredients: ["Milk"]
}
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
    category: "Electronics",
    price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
    category: "Groceries",
    expiry_date: { $lt: ISODate("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
    { product_id: "ELEC1001" },
    { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
// This index improves query performance when filtering products by category,
// as MongoDB can quickly locate matching documents without scanning the entire collection.
db.products.createIndex({ category: 1 });

