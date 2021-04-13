pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract bipazar {
    constructor() public {
        UserAuth[msg.sender] = "ADMIN";
    }

    struct Product {
        string productID;
        uint256 productPrice;
        uint256 productExpireDate;
        uint256 productName;
        uint256 productAmount;
        string productAmountType;
    }
    

    // Added Product
    Product[] ProductList;

    // Deleted Product
    Product[] DeletedProductList;
    
    //Sold Product
    Product[] SoldProductList;

    // Product Mapping
    mapping(string => Product) ProductMap;

    // User Auth
    mapping(address => string) UserAuth;

    modifier checkAuth(string memory _role) {
        require(
            keccak256(abi.encode(UserAuth[msg.sender])) ==
                keccak256(abi.encode(_role))
        );
        _;
    }

    // Set User Role to a User Address
    function setUser(address _userAddress, string memory _role)
        public
        checkAuth("ADMIN")
    {
        UserAuth[_userAddress] = _role;
    }

    // Get User's Role
    function getUserAuth(address _userAddress)
        public
        view
        checkAuth("ADMIN")
        returns (string memory)
    {
        return UserAuth[_userAddress];
    }
    
    
    // Add a new Product
    function addProduct(
        string memory _productID,
        uint256 _productPrice,
        uint256 _productExpireDate,
        uint256 _productName,
        uint256 _productAmount,
        string memory _productAmountType
    ) public checkAuth("PRODUCER") {
        Product memory newProduct = Product({
            productID: _productID,
            productPrice: _productPrice,
            productExpireDate: _productExpireDate,
            productName: _productName,
            productAmount: _productAmount,
            productAmountType: _productAmountType
        });

        if (ProductList.length == 0) {
            ProductList.push(newProduct);
        } else {
            uint256 num = 1000000000;
            for (uint256 i = 0; i < ProductList.length; i++) {
                if (
                    keccak256(
                        abi.encodePacked(ProductList[i].productID)
                    ) == keccak256(abi.encodePacked(""))
                ) {
                    num = i;
                    break;
                }
            }
            if (num != 1000000000) {
                ProductList[num] = newProduct;
            } else {
                ProductList.push(newProduct);
            }
        }

        ProductMap[_productID] = newProduct;
    }
<<<<<<< HEAD:contract/bipazar.sol

    
    function showProduct(string memory _productID)
        public
        view
        returns (Product memory)
    {
        return ProductMap[_productID];
    }
    
    
    //delete a product
     function deletedProduct(string memory _productID)
        public
        checkAuth("PRODUCER")
    {
        DeletedProductList.push(ProductMap[_productID]);

            for (uint128 i = 0; i < ProductList.length; i++) {
                if (
                    keccak256(abi.encode(ProductList[i].productID)) ==
                    keccak256(abi.encode(ProductMap[_productID].productID))
                ) {
                    delete ProductList[i];
                    break;
                }
            }
        
        delete ProductMap[_productID];
    
    }
  } 
  
=======
}
>>>>>>> 9084d0d0e170da15c2007234c911bed0d5fe297d:contract/bibazaar.sol
