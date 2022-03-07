// contracts/My721Token.sol
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract My721Token is ERC721 {
    using Strings for uint256;

    constructor() ERC721("Merkle", "MRK") {}
    
    //gen the metadata in json format
    function tokenURI(uint256 tokenId)
        public
        pure
        override
        returns (string memory)
    {
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
}