pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract Market {

    struct AuctionCard {
        uint256 id;
        address tokenAddress;
        uint256 tokenId; 
        address payable seller; 
        uint256 askingPrice; 
        bool isOwned;
    }

    // listing of every card because all cards are 'always for sale' in the harberger tax model
    AuctionCard[] public cardsForSale;

    // stores the asking prices of each card listed under a certain token
    mapping(address => mapping(uint256 => uint256)) cardsAskPrice;

    /* EVENTS */

    /// @notice emits an event when a new card is added to the market 
    event cardAdded(uint256 id, uint256 tokenId, uint256 askingPrice);

    /// @notice emits an event when a card on auction is sold 
    event cardSold(uint256 id, address buyer, uint256 askingPrice);

    //@TODO: event for defaulting 

    //@TODO: event for paying tax 

    /* MODIFIERS */
     
    //@TODO: modifier for only benefactors 
    //@TODO: modifier for only patrons 
    //@TODO: modifier for only admin  
    /**
     * @notice Requires that only the owner of the car can call a given function.
     */
    modifier OnlyCardOwner(address tokenAddress, uint256 tokenId) {
        IERC721 tokenContract = IERC721(tokenAddress);
        require(tokenContract.ownerOf(tokenId) == msg.sender, "Operation can only be executed by card owner");
        _;
    }
 
    /** 
     * @notice Requires that the specified contract making an external call has been approved to make transfers. 
     */
    modifier HasTransferApproval(address tokenAddress, uint256 tokenId) {
        IERC721 tokenContract = IERC721(tokenAddress);
        require(tokenContract.getApproved(tokenId) == address(this), 
            "Contract has not been approved to make transfers");
        _;
    }
    
    /**
     * @notice Requires that the item is listed in the marketplace 
     */
     modifier CardExists(uint256 id) {
         require(id < cardsForSale.length && cardsForSale[id].id == id, "Could not find card.");
         _;
     }

    //@TODO finish 
     modifier isForSale(uint256 id) {
         // require that 
     }

     /* EXTERNAL FUNCTIONS */
     /**
      * @notice Lists a card for auction in the market 
      */
     function addCardToMarket(address tokenAddress, uint256 tokenId, uint256 askingPrice) 
        OnlyCardOwner(tokenAddress, tokenId) 
        HasTransferApproval(tokenAddress, tokenId)
        external
        returns (AuctionCard)
        {
        // @TODO:require that the card isn't for auction yet?
        uint256 newCardId = cardsForSale.length;
        cardsForSale.push(AuctionCard(newCardId, tokenAddress, tokenId, payable(msg.sender), askingPrice, false));
        
        //@TODO: add to cards on sale 
        //@TODO: assert, emit, then return the new card

    } 
     
    //TODO: finish function for making a sale 
    // function buyCard(uint256 id) payable external CardExists(id) IsForSale() HasTransferApproval {
        // require caller has sufficient funds. greater than listing price 
        // require that the buyer is not the seller 
        // mark the card as owned
        // remove from auction listing 
        // interface the nft 
        // safetransfer nft
        // transfer funds to seller 
        // emit event   
    
        
    }

    /* PRIVATE FUNCTIONS */
}