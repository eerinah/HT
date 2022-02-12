pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/utils/Address.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

//@TODO: create migrations file 
//@TODO: include contract address in front end

contract CardToken is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
 
   //@TODO: add name and symbol 
   constructor () ERC721("",""){}

   /**
    * Defines an nft card 
    */
    struct Card {

        // unique ID for given card 
        uint256 id;

        // the rate of the harberger tax that will be charged for owning a card 
        uint32 fee; 

        // the address that receives the revenue from the harberger tax
        address payable beneficiary; 

        // universal resource identifier for the card use in frontend
        string uri;
    }
    
    mapping(address => uint256) ownerTokenCount;
    mapping(uint256 => address) tokenOwner;
    mapping(uint256 => Card) public Cards;

    /**
     * Mints a new card  
     */
    function mintCard(string memory uri, uint32 fee, address payable beneficiary) public returns(uint256) {
        require(beneficiary != address(0), "beneficiary address does not exist");
        _tokenIds.increment();
        uint256 newCardId = _tokenIds.current();
        _safeMint(msg.sender, newCardId);
        Cards[newCardId] = Card(newCardId, fee, beneficiary, uri);
        return newCardId;
    }

    function tokenURI(uint256 cardId) public view override returns (string memory) {
        require(_exists(cardId), "ERC721Metadata: URI query for nonexistent token");

        return Cards[cardId].uri;
      
    }
} 

