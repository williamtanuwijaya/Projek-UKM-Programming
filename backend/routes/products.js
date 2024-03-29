let express = require('express');
let router = express.Router();
const Validator = require('fastest-validator');

const { Product } = require('../models');

const v = new Validator();
// maybe Op not needed
const { Op } = require("sequelize"); 

router.get('/', async (req, res) => {
  const products = await Product.findAll();
  res.json(products);
});

router.get('/:id', async (req, res) => {
  const id = req.params.id;
  const products = await Product.findByPk(id);
  res.json(products || {});
});

router.post('/', async (req, res) => {
  const schema = {
    name: 'string',
    brand: 'string',
    description: 'string|optional',
  };

  const validate = v.validate(req.body, schema);

  if (validate.length) {
    return res.status(400).json(validate);
  }
  const product = await Product.create(req.body);

  res.json(product);
});

router.put('/:id', async (req, res) => {
  const id = req.params.id;

  let product = await Product.findByPk(id);

  if (!product) {
    return res.json({ message: 'Product not found' });
  }

  const schema = {
    name: 'string|optional',
    brand: 'string|optional',
    description: 'string|optional',
  };

  const validate = v.validate(req.body, schema);

  if (validate.length) {
    return res.status(400).json(validate);
  }

  product = await product.update(req.body);
  res.json(product);
});

router.delete('/:id', async (req, res) => {
  const id = req.params.id;

  const product = await Product.findByPk(id);

  if (!product) {
    return res.json({ message: 'Product not found' });
  }

  await product.destroy();
  res.json({
    message: 'Product deleted',
  });
});

//search products based on name given
router.get('/search/:name?', async (req, res) => {
  let name = "-";
  if(req.params.name) {
    name = req.params.name;
  }
  
  const products = await Product.findAll({
    where: {
      [Op.or]: [
        { name: { [Op.substring]: name } },
        { brand: { [Op.substring]: name } }
      ]
    }
  });
  res.json(products || {});
});

module.exports = router;
 