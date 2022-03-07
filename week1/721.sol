// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFT is ERC721, Ownable {
    using Strings for uint256;

    // Set a counter for TokenID enumeration to optimise gas fees for minting:
    using Counters for Counters.Counter;
    Counters.Counter private totalMinted;

    uint256 public cost = 0 ether;
    uint256 public maxSupply = 10000;
    uint256 public maxMintAmount = 20;

    // Variable to save merkle root:
    bytes32 public merkleRoot;

    // Mapping to denote which NFT has been minted:
    mapping(uint256 => bool) public tokenIdHasMinted;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
    }

    function mint(
        bytes32[] calldata proof,
        uint256 _tokenId,
        address _recipient
    ) public payable {
        require(totalMinted.current() + 1 <= maxSupply);
        require(_recipient != address(0));

        string memory currentTokenURI = tokenURI(_tokenId);

        //hash the 4 params
        bytes32 leaf = keccak256(
            abi.encodePacked(msg.sender, _recipient, _tokenId, currentTokenURI)
        );

        //check if the root matches
        require(MerkleProof.verify(proof, root, leaf), "Error, proof fail.");

        _safeMint(_recipient, _tokenId);

        totalMinted.increment();
    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override
        returns (string memory)
    {   
        //gen the metadata in json format
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "nft #', tokenId.toString(), '"',
                '"description": "zku ollection"'
            '}'
        );

        return string(
            abi.encodePacked(
                Base64.encode(dataURI)
            )
        );
    }

    function currentSupply() public view returns (uint256) {
        return totalMinted.current();
    }

    function setMerkleRoot(bytes32 _newMerkleRoot) public onlyOwner {
        root = _newMerkleRoot;
    }
}