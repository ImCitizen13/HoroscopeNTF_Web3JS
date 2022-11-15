// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "./Base64.sol";
import "./IContent.sol";

/*
 * @author Citizen13
 * @notice HoroscopeNFT smart contract
 */
contract horoscopeNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // Adds a max supply to the number of NFTs that could be minted
    uint256 public constant MAX_SUPPLY = 2000;
    string baseSvg =
        "https://en.wikipedia.org/wiki/Aquarius_(astrology)#/media/File:";
    uint256 constant PRICE = 0.005 / 0.000000000000000001;
    mapping(uint256 => IContent.Item) Content;
    string constant PROJECT_NAME = "Horoscope";
    string constant PROJECT_SYMBOL = "HSCP";
    address public renderingContractAddress;

    // "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    /**
     * @dev construct the contract with the project name and symbol
     */
    constructor() ERC721(PROJECT_NAME, PROJECT_SYMBOL) {}

    // TODO: make base SVG as a function input
    function createSVG(string memory zodiacSign)
        private
        view
        returns (string memory)
    {
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, zodiacSign, "</text></svg>")
        );

        return finalSvg;
    }

    function creatMetadata(string memory zodiacSign, string memory finalSvg)
        private
        pure
        returns (string memory)
    {
        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        zodiacSign,
                        // We set the title of our NFT as the generated word.
                        '", "description": "On-chain Zodiac Sign NFTs", "attributes": [{"trait_type": "Zodiac Sign", "value": "',
                        zodiacSign,
                        '"}], "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    /**
     * @dev New minted item event
     */
    event newItem(address sender, uint256);

    function mintNFT(address recipient, string memory zodiacSign)
        public
        returns (uint256)
    {
        // Check that we didn't reach the MAX_SUPPLY number of NFTs
        require(
            MAX_SUPPLY >= _tokenIds.current(),
            "Reached the maximum amount of mints "
        );
        _tokenIds.increment();

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = creatMetadata(
            zodiacSign,
            createSVG(zodiacSign)
        );
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        return newItemId;
    }

    function generateNFT(srting calldata itemName, uint256[6] calldata Magic)
        public
        payable
        virtual
    {
        // A check if there's enough ETH sent to the method to mint
        require(msg.value >= price, "Not enough ETH sent; check price!");
        uint256 newItemId = _tokenIds.current();
    }
}
