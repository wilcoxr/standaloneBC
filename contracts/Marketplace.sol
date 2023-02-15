// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;
contract Marketplace {
  // Variables
    string public name;
    uint public productCount = 0;
    // address private Owner = "";

  // Mappings
    mapping(uint => Product) public products;

  // Modifiers
//   modifier onlyOwner() {
//         require(msg.sender == Owner, 'Not owner');
//         _;
//     }

  // Structs
    struct Product {
        uint id;
        string cid;
        uint price;
        address payable owner;
        bool purchased;
    }
  
  // Events
    event ProductCreated(
    uint id,
    string cid,
    uint price,
    address payable owner,
    bool purchased
    );

    event ProductPurchased(
    uint id,
    string cid,
    uint price,
    address payable owner,
    bool purchased
    );

  // Constructors
    constructor() {
        name = "Healthcare Marketplace";
    }

  // Functions
    function createProduct(string memory _cid, uint _price) public {
    // Require a valid name
    require(bytes(_cid).length > 0);
    // Require a valid price
    require(_price > 0);
    // Increment product count
    productCount ++;
    // Create the product
    products[productCount] = Product(productCount, _cid, _price, payable(msg.sender), false);
    // Trigger an event
    emit ProductCreated(productCount, _cid, _price, payable(msg.sender), false);
    }

    function purchaseProduct(uint _id) public payable {
        // Collect Variables
    // Fetch the product from mapping
    Product memory _product = products[_id];
    // Fetch the owner
    address payable _seller = _product.owner;

        // Set Requirements
    // Make sure the product has a valid id
    require(_product.id > 0 && _product.id <= productCount);
    // Require that there is enough Ether in the transaction
    require(msg.value >= _product.price);
    // Require that the product has not been purchased already
    require(!_product.purchased);
    // Require that the buyer is not the seller
    require(_seller != msg.sender);

        // Process Transaction
    // Transfer ownership to the buyer
    _product.owner = payable(msg.sender);
    // Mark as purchased
    _product.purchased = true;
    // Update the product
    products[_id] = _product;
    // Pay the seller by sending them Ether
    payable(address(_seller)).transfer(msg.value);
    // Trigger an event
    emit ProductPurchased(productCount, _product.cid, _product.price, payable(msg.sender), true);
}

    }