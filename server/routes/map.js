const express = require('express');
const mapRouter = express.Router();



// SEARCH LOCATION
mapRouter.get('/api/searchLocation-autocomplete?search_text=$text', async (req, res) => {
    try {
        const products = await Product.find({
            name: {$regex: req.params.name, $options: "i"}
        });
        res.json(products);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
  });


productRouter.get('/api/products/search/:name', auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: {$regex: req.params.name, $options: "i"}
        });
        res.json(products);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
  });
module.exports = mapRouter;