// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721A, Ownable{

    mapping (uint => string) promptUsed;
    
    constructor() Ownable(msg.sender) ERC721A("METANFT", "MTK") {
        promptUsed[0] = "A 3D render of a rainbow colored hot air balloon flying above a reflective lake";
        promptUsed[1] = "A hand-drawn sailboat circled by birds on the sea at sunrise";
        promptUsed[2] = "A photo of a teddy bear on a skateboard in Times Square";
        promptUsed[3] = "A 3D render of an astronaut walking in a green desert";
        promptUsed[4] = "3D render of a cute tropical fish in an aquarium on a dark blue background, digital art";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return 'https://chocolate-holy-whitefish-968.mypinata.cloud/ipfs/QmVMj2PrD1kdsGKXGfWEEWw5g3RSbowxJuEBWmswA2ynYD/?pinataGatewayToken=ReK_pW65exe6KenmZrwvpJ2EeZ2lB8Fsf_EPzCwFQ1aWm3X9u8er-OexRCZAR0Ep';
    }

    function whatPromptUsed(uint _tokenId) public view returns (string memory) {
        require (_tokenId < 5, "Invalid Token ID.");
        return promptUsed[_tokenId];
    }

    function mintFor(address _for, uint _qty) public payable onlyOwner {
        require(msg.value > (_qty * (0.05 ether)), "Not enough token sent.");
        require((_numberMinted(_for) + _qty) <= 2, "You can't mint more than 2.");
        _mint(_for, _qty);
    }

    function _sequentialUpTo() internal view virtual override returns (uint256) {
        return 4;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) _revert(URIQueryForNonexistentToken.selector);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), '.json')) : '';
    }

}
